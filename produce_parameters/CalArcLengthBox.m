function ArcLengthBox = CalArcLengthBox(vInitial,acc,frameRate);
% acc = 1 or -1
t = 1; %(in frame)
g = acc*9.8/frameRate;

ArcLengthBox=[];
for n=1:96
    ArcLength = vInitial*t + 1/2*g*t^2;
    ArcLengthBox (n) = ArcLength;
    vEnd = vInitial+g*t;
    vInitial = vEnd;
end

% Now we just need to calculate x with a known arc length