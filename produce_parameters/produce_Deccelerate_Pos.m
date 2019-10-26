
function posDeccelarate = produce_Deccelerate_Pos(ArcLengthBox);
f2 = 0.0051; f1 = 1.5925; f0 = -175.8054;
F = @(x) (f0 + f1*x + f2*x^2);

xDelta = 1;
arcL = 0;
arcLDelta = 0;
posDeccelarate=[];
n = 96;
x = -150;

posDeccelarate(1,:) = [x,F(x)];
for t = 2:n
    while arcL <= ArcLengthBox (t)
        xLast = x - xDelta;
        y = F(x);
        yLast = F(xLast);
        arcLDelta = sqrt(xDelta^2 + ((y-yLast)^2));
        
        % Update
        x = x + xDelta;
        arcL = arcL + arcLDelta;
    end
    % record
    posDeccelarate(t,:) = [x,y];  
    % Update
    arcLDelta = 0;
    arcL = 0;
end
