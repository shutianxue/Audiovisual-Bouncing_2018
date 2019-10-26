% METHOD 2. Breaking the curve as if it is made of straight lines
% Generating n x-points from a to b

%INPUTS
syms x;
curve = @(x) (f0*x + f1/2*x^2 + f2/3*x^3);
% lower limit
lowLim = xInitial;
% b=upper limit
UpLim = xInitial + xDelta;
% n = number of straight lines used to approximate f(x) for METHOD 2
n = 100;

xInterval = lowLim:(UpLim-lowLim)/n:UpLim;
% generating the y-values of the function
yInterval = subs(curve,x,xInterval);
% assuming that between consecutive data points, the curve can be approximated by linear splines.
leng_straight = 0;
numArc =length(xInterval);
% there are m-1 splines for m points
for i = 1:numArc-1
    dx = xInterval(i+1)-xInterval(i);
    dy = yInterval(i+1)-yInterval(i);
    lengthPerArc = sqrt(dx^2+dy^2);
    leng_straight = leng_straight+lengthPerArc;
end
fprintf ('\n\nBreaking the line into short lengths =%g',leng_straight)

