function pos = deccelerateBox;
tmp = Screen('Resolution',0);
resolution = [tmp.width,tmp.height]; 

f2 = 0.0051; f1 = 1.5925; f0 = -175.8054;
F = @(x) (f0 + f1*x + f2*x^2);
I = @(x) (f0*x + f1/2*x^2 + f2/3*x^3);

xInitial = -150;
yInitial = double(F(xInitial));

disTotal = double(I(resolution(2)/2) - I(yInitial));
numDiscs = 96;
disSub = disTotal / numDiscs;

% calculate length of curve: 
% theory: http://mathinsight.org/length_curves_refresher

% 3 methods to calculate arc length: 
% https://autarkaw.org/2008/06/18/finding-the-length-of-curve-using-matlab/
% Use trapz:
% https://www.mathworks.com/matlabcentral/answers/130871-finding-length-of-curve-created-using-fit-function

for n = 1:numDiscs
    syms xDelta
    xDelta = double(int(I,xInitial,xInitial+xDelta) == disSub);
    xDelta = xDelta(xDelta >= 0);
    xPos = xInitial + xDelta;
    xInitial = xPos;
    yPos = double(F(xPos));
    pos (n,:) = [xPos,yPos];
end
