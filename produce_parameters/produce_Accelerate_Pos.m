function  [posAccelerate,posBasic] = produce_Accelerate_Pos;


%% Parameters
posBasic.speed  = 4;
posBasic.xStart = -150; 
posBasic.yStart = -300;
posBasic.xEnd   = 300;
yPos = posBasic.yStart;
xPosMat = posBasic.xStart:posBasic.speed:posBasic.xEnd;
frameRate = 60;
g = 9.8/frameRate;
tmp = Screen('Resolution',0);
resolution = [tmp.width,tmp.height]; % number of pixels of display in horizontal direction

%% Loop
for n = 1:length(xPosMat)
    % KbWait; WaitSecs(0.1); 

    % Update position of discs
    Xpos = xPosMat(n);
    yPos = yPos + g*n;   %+ speed0

    % check the boundary
    if yPos > resolution(2)/2
        vEnd = g*n;
        break;
    end
    % record position of discs
    posAccelerate(n,:) = [Xpos,yPos];   
end

posBasic.vEnd = vEnd;

