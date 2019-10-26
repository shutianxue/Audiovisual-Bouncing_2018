function line = extractLines

line_i1 = 'In each trial, you will see two moving white discs.\nTheir trajectory will start from opposite points on the screen.\n\n';
line_iL = 'Press <Left> if you think that two discs bounced each other.\n           then moved in the direction oppostive to its previous trajectory.\n\n';
line_iR = 'Press <Right> if you think that two discs crossed each other.\n           then moved in the direction same with its previous trajectory.\n\n';
line_instruction = strcat(line_i1,line_iL,line_iR);
line_practice = 'Press ANY key to start practice.';
line_exp      = 'If you don''t have any question,\nPress ANY key to start experiment.';
line_question = 'Did two discs bounced each other?\n\n';
line_choice   = '<-- Yes     No -->';
line_posiFeed = 'Correct';
line_negaFeed = 'Wrong';
line_rest     = 'You can have a rest.\nPress ANY key to continue.';
line_restTest = 'You have finished this task.\nYou can have a rest outside if you want.\nThere are %d session(s) left in the test/training part.\nPress any key to continue';
line_makeSure = 'Are you sure that you have had enough rest?';
line_ending   = 'This is the end of this experiment.\nPlease wait for your experimenter.';

line_instructionSize = 35;
line_OthersSize      = 45;

%% Conversion into struct
line.instruction=line_instruction;
line.question=line_question;
line.practice=line_practice;
line.exp=line_exp;
line.choice=line_choice;
line.posiFeed=line_posiFeed;
line.negaFeed=line_negaFeed;
line.rest=line_rest;
line.restTest=line_restTest;
line.makeSure=line_makeSure;
line.ending=line_ending;

line.instructionSize=line_instructionSize;
line.OthersSize=line_OthersSize;
