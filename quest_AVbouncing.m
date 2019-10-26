function quest_AVbouncing(subjectID,block)

%% Description
% Audio-visual bounce-inducing effect (ABE) 
% Technically, two disks move from opposite points in space, overlapping, and continuing movement.
% On each trial, subjects will judge whether they perceive a bouncing of two discs.
% Choosing bouncing is always the correct answer.
% Temporal difference (delta) between visual crossing and sound is adjusted according to QUEST.

% Inputs
%  subjectID: three-letter subject identifier, must be string, e.g., '001'
%  block 

% Output: Data.stimuli_record
%   C1: trialCount
%   C2: condition
%   C3: sequence
%   C4: delta, in secs
%   C5: correctness (perception of bouncing)

rng('default');
Screen('Preference', 'SkipSyncTests', 1);
%% Set up trials and Run Expt
conditions = [-1;0;1]; % which staircase
                       % In this study: -1 = - acceleration (decelarate)
                       %                 0 = incongruent
                       %                 1 = + acceleration (accelerate)               
nconditions=size(conditions,1);

sequences = [-1;1];  % -1 = sound is before visual crossing
                     %  1 = sound is after visual crossing                
nsequences = size(sequences,1);

%Prepare EXP trials
numTrialBox=[90,4];

for N=1:2
    numtrials = numTrialBox(N);
    ntrials = numtrials/(size(conditions,1)); %ntrials gives trials per number of alternatives

    trialsMatrix=[];
    trialRow = 1;
    for r=1:ntrials
        for p=1:nconditions 
            for q=1:nsequences 
                trialsMatrix(trialRow,1)= conditions(p);
                trialsMatrix(trialRow,2)= sequences(q);
                trialRow=trialRow+1;
            end
        end
    end 

    random = randperm(size(trialsMatrix,1));
    j=1;
    for i=random
        trials2(j,:)=trialsMatrix(i,:);
        j=j+1;
    end
    
    if N==1
        trials=trials2;
    else
        prtrials=trials2;
    end
    clear trials2;

end

%Run Experiment
RunExp_AVbouncing(subjectID,block,trials,prtrials,nconditions,conditions)
