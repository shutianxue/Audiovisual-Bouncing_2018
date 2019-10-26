
Instructions
%% step 1: yield all coordinates beforehand
% (skip this step if there is "Para.mat" in the current folder)
% Go to the folder called "produce_parameters"
% --> run "savePara(frameRate) (frameRate is usually 60);
% (the variable will be saved in the folder out of produce_parameters)

%% Step 2: Run experiment
% Run "quest_AVbouncing(subjectID,block)"
% Please refer to this script for details of inputs.

% Note: currently, the number of practice is set to 3 and number of experimental
% trials to 6 for convenience of testing (refer to line#92-103 of "RunExp_AVbouncing")

%% Step 3: Check staircase
% After finishing one session, go to the folder called ?Data?
% load the data file (by double-click), then run "plotData(Data)"
% You can see a plot of three staircases, for judging whether the
% performacne is ideal

