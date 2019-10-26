function  test_deaccelerate(posRecordCentral)
%movingDisc_congruent(window,delta,condition,sequence,beep,pos,screen);
% [finalSpeed,beepLag,beepXpos,timeRecord,posRecord] = movingDisc_congruent;
% movingDisc_congruent(window,delta,condition,sequence,beep,fs,speed,xStart,yStart,xEnd,speedG,discSize,xCenter, yCenter,resolution);
% Run the following script when you need to obtain outputs necessary for 
% calibrating the real time point when a beep should be played.

pos = posRecordCentral;
%% Input:
% condition: 1 = congruent (with acceleration);
%            0 = incongruent

%% Setting
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);screenNumber = max(Screen('Screens'));
%HideCursor(screenNumber);
discSize = 15;

InitializePsychSound(1);

% Screen
[window,windowRect] = PsychImaging('OpenWindow', screenNumber, [.5 .5 .5]);
[xCenter, yCenter] = RectCenter(windowRect);
tmp = Screen('Resolution',0);
resolution = [tmp.width,tmp.height]; % number of pixels of display in horizontal direction
Screen(window, 'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
frameRate = 1/Screen('GetFlipInterval',window);% 60; % originally = ;


%% Parameters

speedG = 9.8/60;

% if the parameter of this script is changed, need to calibate the time lag
% and real time point for playing sound by run the following script after
% the current script (with new parameters) has been ran once to obtain the
% necessary input:
%      realBeepPos = realBeepPos(beepLag,beepXpos,timeRecord);

beepLag     = 0.025;
beepXpos    = 38; % the index (based on x position)when two discs are closest to overlapping
realBeepPos = 36; % the index when sound should be played to produce the effect 
                  % that a beep is played when the two discs are ovelapping
beepTime=0.02;frequency=1800;fs=48000;
beep = sin(linspace(0, beepTime*frequency*2*pi, round(beepTime*fs)));
%minusDeltaBeepPos = minusDelta(delta,sequence,realBeepPos);

% set initial speed (or can combine in one formula)
%{
if condition == 1
    speed0 = 0;
else 
    speed0 = 16.6631; 
end
%}

beepTime  = 0.01; % in secs
frequency = 1800;
fs        = 48000;
beep      = MakeBeep(frequency,beepTime,fs);

%% Loop
%tic
for t = 1:size(posRecordCentral,1)
    account = size(posRecordCentral,1) - t+1;
    
    % KbWait; WaitSecs(0.1); 
    xPos = pos(account,2);
    yPos = pos(account,3);
    
    Screen('DrawDots',window,[xPos,-xPos;yPos,yPos],discSize,[1 1 1],[xCenter,yCenter],1);
    Screen('Flip',window);
    %i = toc;
    %timeRecord(t,:) = [t,i];
    
    % check the boundary
    if pos(t,3) > resolution(2)/2
        finalSpeed = speedG*t;
        break;
    end
    % record position of discs
    %posRecord(t,:) = [t,Xpos,yPos];   
end

PsychPortAudio('Close');

KbWait;
sca;