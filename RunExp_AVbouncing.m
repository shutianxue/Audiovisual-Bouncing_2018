function RunExp_AVbouncing(subjectID, block, trials, prtrials, nconditions, conditions)

%Screen('Preference', 'SkipSyncTests', 1);
%% ============ Setting ============
PsychDefaultSetup(2);
screenNumber = max(Screen('Screens'));
%HideCursor(screenNumber);

InitializePsychSound(1);
%beep.nrchannels = 2;
%% ============ Parameters ===============

% Color 
color.grey  = [.5 .5 .5];
color.black = [0 0 0];
color.white = [1 1 1];
color.blue  = [0 1 1];
color.bgColor   = color.grey;
color.lineColor = color.white;
color.discColor = color.white;

% Screen
[window,windowRect] = PsychImaging('OpenWindow', screenNumber, color.bgColor);
[screen.xCenter, screen.yCenter] = RectCenter(windowRect);
tmp = Screen('Resolution',0);
screen.resolution = [tmp.width,tmp.height]; % number of pixels of display in horizontal direction
Screen(window, 'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
screen.frameRate = 1/Screen('GetFlipInterval',window);% 60; % originally = ;
screen.window = window;

dist      = 50;  %distance from screen (cm)
width     = 53;  %width of screen (cm)
discAngle = 0.5; %visual angle of disc
disc.Size  = angle2pix(dist,width,screen.resolution,discAngle); % radius of disc
disc.Color = color.white;
disc.bgColor = color.bgColor;

pitch    = 1800; % frequency of sound 
fs       = 48000;
beepT    = 0.01;
beep = sin(linspace(0, beepT*pitch*2*pi, round(beepT*fs)));

pos.speed  = 4;
pos.xStart = -150; 
pos.yStart = -300;
pos.xEnd   = 300;
pos.speedG = 9.8/screen.frameRate;

% Line
line = extractLines;

%% ============ Staircase setup ============
Data = CreateData(subjectID,block,nconditions,conditions);
 
%Get Initial Parameters
[StimValInit, MaxtTest, InitGuess] = GetParams;

%Initialize staircases for practice (2 staircases)
for j = 1:nconditions
    q(j) = CreateQuest(InitGuess);
end

% Determine the situation
if block ==1 
    ThisIsPractice=1;
else
    ThisIsPractice=0;
end

if ThisIsPractice
    N=2;
else
    N=1;
end

for practiceOrNot=1:N
    %% LINES
    if ThisIsPractice % have practice with line_choice
        Screen('TextSize', window, line.instructionSize); 
        DrawFormattedText(window,[line.instruction,line.practice],300,'center',color.lineColor,0,0,0,2);Screen('flip',window);

    else % no practice line_choice
        DrawFormattedText(window,line.exp,'center','center',color.lineColor,0,0,0,2);Screen('flip',window);
        Screen('TextSize', window, line.OthersSize); 
    end

    KbWait;

    Screen('FillRect', window, color.bgColor);Screen('flip',window);
    Screen('TextSize', window, line.OthersSize); 

    % Determine TrialN
    if ThisIsPractice
        TrialN = size(prtrials,1);
        % just for testing:  
        TrialN = 3;
        extraction = prtrials;
    else
        TrialN = size(trials,1);
        % just for testing: 
        TrialN = 6;
        extraction = trials;
    end

    %% LOOP
    for trialCount = 1:TrialN
        %Extract trial parameters
        condition = extraction(trialCount,1);
        sequence = extraction(trialCount,2);
        i = condition+2;

        %Check if first trial     
        if trialCount == 1
            delta = StimValInit;
            tTest=log(delta);
        else
            tTest = min(MaxtTest,QuestQuantile(q(i)));
            delta = 10^tTest;
        end

        if ~ThisIsPractice
            % check progress and give a rest in the middle of whole block
            if trialCount==TrialN/3+1 || trialCount==TrialN/3*2+1
                DrawFormattedText(window,line.rest,'center','center',color.blue); Screen('flip',window);
                KbWait;
                Screen('FillRect', window,color.bgColor); Screen('flip',window);
                WaitSecs(0.5);
            end
        end

        % --------- Present Stimuli ---------
        % Extract ready information of position
        load Para;
        switch condition
            case -1 % deccelarate
                posBox = pos.Deccelerate;
            case 0 % accelarate
                posBox = pos.Incongruent;
            case 1 % incongruent
                posBox = pos.Accelerate;
        end
        
        presentDisc(posBox,delta,sequence,disc,screen,beep,fs); 
        Screen('FillRect',window,disc.bgColor);
        Screen('flip',window);
        % ------------------------------------
        
        % Ask question
        if ThisIsPractice
            line1=strcat(line.question,line.choice);
        else 
            line1=line.choice;
        end
        DrawFormattedText(window,line1,'center','center',color.lineColor);
        Screen('flip',window);

        % Detect response
        t0=GetSecs;       
        [answer, anstime]=get_key([37 39], 2, t0);
        correctness = AnalyzeResponse(answer);
        
        anstime=anstime-t0;
        
        Screen('FillRect',window,color.bgColor);
        Screen('flip',window);
        WaitSecs(0.2);                            

        %Update Staircase Structure
        q(i) = QuestUpdate(q(i),tTest,correctness);

        %Update Data
        if ThisIsPractice
            % Reset staircases
            clear q;
            for j = 1:nconditions
                q(j) = CreateQuest(InitGuess);
            end
        else
            % record stimuli parameters
            %   C1: trialCount
            %   C2: condition
            %   C3: sequence
            %   C4: delta, in secs
            %   C5: correctness (perception of bouncing)
            recordPerTrial = {trialCount,extraction(trialCount,:),delta,correctness};
            Record(trialCount,:) = recordPerTrial;
        end
    end

    % convert to the formal exp mode
    ThisIsPractice = ThisIsPractice-1;
end

Data.stimuli_record = Record;

%% Ending
DrawFormattedText(window,line.ending,'center','center',color.blue);Screen('flip',window);
WaitSecs(1);
Screen('CloseAll');

%% Obtain thresholds and display in command window (for check)
fprintf('\n');
for m = 1:Data.Nthresholds
    i = conditions(m)+2;
    t = min(MaxtTest, QuestMean(q(i))); %in case at floor
    Data.Threshold(i) = 10^t;
    fprintf('Threshold Estimate = %7.3f  (%s)\n', Data.Threshold(i), char(Data.ThresholdName(i)));
    Data.ThresholdConfidenceInterval(i,1) = max(0, 10^QuestQuantile(q(i),0.025));
    Data.ThresholdConfidenceInterval(i,2) = min(10^MaxtTest, 10^QuestQuantile(q(i),0.975));
    fprintf('95%% Confidence Interval (%7.4f, %7.3f)\n', ...
        Data.ThresholdConfidenceInterval(i,1), Data.ThresholdConfidenceInterval(i,2));
end
fprintf('\n');

%% Save Data
CreateDataFile(Data);
ShowCursor;

