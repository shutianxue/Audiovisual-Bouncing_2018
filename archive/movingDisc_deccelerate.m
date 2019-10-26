function movingDisc_deccelerate(pos)
%%
% VFinal = 15.84; %measured from accelerate condition
% thus, in this condition, V0 = VFinal;

%% 
PsychDefaultSetup(2);screenNumber = max(Screen('Screens'));
%HideCursor(screenNumber);
% Color 
grey  = [.5 .5 .5];
white = [1 1 1];
bgColor = grey;

% Screen
[window,windowRect] = PsychImaging('OpenWindow', screenNumber, bgColor);
[xCenter, yCenter] = RectCenter(windowRect);
tmp = Screen('Resolution',0);
resolution = [tmp.width,tmp.height]; % number of pixels of display in horizontal direction
Screen(window, 'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
frameRate = 1/Screen('GetFlipInterval',window);%60; % originally = 
discSize = 15;

%% Parameters
travelingRoute = 0;

% function: f(x) = Ystart+speedG * n*(n-1)/2) (n is the index of disc)
% integral: I(x) = YStart*(n+1) + 1/6*speedG^(n+1)^3 - 1/4*speedG*(n+1)^2
f2 = 0.0051; f1 = 1.5925; f0 = -175.8054;

syms x
F(x)= f0 + f1*x + f2*x.^2;
I(x)= f0*x + f1/2*x^2 + f2/3*x.^3;

xStart = -150; xEnd = 300; yStart = -300;
aGravity = 9.8/frameRate;

%% Build up position box
% speed0 (0), integral function, initial position
%{
load postion_record_Dec18
numDiscs = size(posRecord,1); % determine the number of discs based on accelerate condition
speedLast = speedLast; % extracted from postion_record_Dec18 as well

disTotal = I(resolution(2)/2) - I(yStart);
xPos = posRecord(:,2);
disSub = disTotal / numDiscs;
%}
xInitial = -150;
f2 = 0.0051; f1 = 1.5925; f0 = -175.8054;
F(x)= f0 + f1*x + f2*x.^2;
I(x)= f0*x + f1/2*x^2 + f2/3*x.^3;

tic    
%% LOOP
for n = 1:96
    % Draw dots
    Screen('DrawDots',window,[pos(n,1),-pos(n,1);pos(n,2),pos(n,2)],discSize,white,[xCenter, yCenter],1);
    Screen('Flip',window);
    
    if pos(n,2) > resolution(2)/2%+discSize
        break;
    end
end
toc

KbWait;
sca;
