% usage: pt = interparc(t,px,py)    % a 2-d curve
% usage: pt = interparc(t,px,py,pz) % a 3-d curve
% usage: pt = interparc(t,px,py,pz,pw,...) % a 4-d or higher dimensional curve
% usage: pt = interparc(t,px,py,method) % a 2-d curve, method is specified
% usage: [pt,dudt,fofthandle] = interparc(t,px,py,...) % also returns derivatives, and a function handle
%  
%   
% 127 equally spaced points, using a spline interpolant.

function [pt_x, pt_y, pt_z] = GetArcDist(xdat, ydat, zdat);

pt = interparc(127,xdat,ydat,zdat,'spline');
pt_x = pt(:,1);
pt_y = pt(:,2);
pt_z = pt(:,3);

% Plot the result 
plot(xdat,zdat,'r*',pt(:,1),pt(:,3),'b-o') 
%axis([-1.1 1.1 -1.1 1.1]) 
axis equal 
grid on 
xlabel X 
ylabel Y 
title 'Points in blue are uniform in arclength around the path'

end
%You can now also return a function handle to evaluate the curve itself at any point. 
%As well, CSAPE is an option for periodic (closed) curves, as long as it is available in your matlab installation.

% [~,~,foft] = interparc([],px,py,'spline'); 
% foft(0:0.25:1) 
% ans = 
%       0.98319 0.18257 
%      -0.19064 0.98151 
%      -0.98493 -0.17486 
%       0.18634 -0.98406 
%       0.98319 0.18257