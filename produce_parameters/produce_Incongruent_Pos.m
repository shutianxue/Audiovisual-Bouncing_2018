function posIncongruent = produce_Incongruent_Pos;


xStart = -150; xEnd = 300;
arcInterval = 200; % the distance between subsequent discs on the trajectory,pixel/sec
                   % (negatively correlated with traveling time)
                   
                   % this paramter is set at the current level to ensure that 
                   % the traveling time for all three conditions are similar (around 1.6s)

f2 = 0.0051; f1 = 1.5925; f0 = -175.8054; 
% coefficients are derived from regression of disc positions in deccelaration condition

numPoints = double(calArcLength(f0,f1,f2,xStart, xEnd, arcInterval));
x = linspace(xStart,xEnd,numPoints);
y = f0 + f1*x + f2*x.^2;

% use the script from Dorita
posIncongruent = interparc(numPoints,x,y,'spline'); 
