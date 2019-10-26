function [disc1Pos,disc2Pos]=dotPosition(x,y)

discPos = [-x;-y]; % disc on the top left
disc1Pos = discPos; % distance from the central axis (bottom right is double-positive)
discPos(1,1) = discPos(1,1)*(-1);
disc2Pos = discPos;
%discPos=[disc1Pos,disc2Pos];