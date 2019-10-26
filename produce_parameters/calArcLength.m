function discPointNum = calArcLength(f0,f1,f2,xStart, xEnd, arcInterval);
% function: y = f0 + f1*x + f2*x^2;
% produce the integral function
syms x
integralF = int(f0 + f1*x + f2*x^2);

% calculate the number of discs needed based on arcInterval
syms I(x)
I(x) = integralF;
arcLength = I(xEnd)-I(xStart);
discPointNum = round(arcLength/arcInterval);


