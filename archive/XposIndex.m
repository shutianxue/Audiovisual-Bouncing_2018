function XposIndex = XposIndex

frameRate = 60;
YStart = -300;
speedG = 9.8/frameRate;
arcLength = 100; % the distance between subsequent discs on the route, in pixel

discAccount = 1;
syms n
eqn = abs((YStart*(discAccount+n) + 1/6*speedG*(discAccount+n)^3 -1/4*speedG*(discAccount+n)^2)-(YStart*discAccount + 1/6*speedG*discAccount^3 - 1/4*speedG*discAccount^2)) == arcLength;
XposIndex = round(solve(eqn, n));