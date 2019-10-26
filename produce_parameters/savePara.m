function savePara(frameRate)

% Instruction on how to re-produce the parameters
% Step 1: re-run "produce_Accelerate_Pos"
[posAccelerate,posBasic] = produce_Accelerate_Pos;
% output: posAccelerate,posBasic,resolution

% step 2. produce Deccelerate positions
ArcLengthBox = CalArcLengthBox(posBasic.vEnd,-1,frameRate);
posDeccelarate = produce_Deccelerate_Pos(ArcLengthBox);

% step 3. produce incongruent positions
posIncongruent = produce_Incongruent_Pos;

% Step 4. Save all
pos.Accelerate= posAccelerate;
pos.Deccelerate= posDeccelarate;
pos.Incongruent = posIncongruent;

% set the path where the parameters are saved
path = '/Users/xueshuqian/Desktop/AVBouncing/Para';
save(path,'ArcLengthBox','pos','posBasic');