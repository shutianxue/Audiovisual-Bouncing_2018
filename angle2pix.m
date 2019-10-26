function pix = angle2pix(dist,width,resolution,ang)

%converts visual angles in degrees to pixels.
%
%Inputs:
%display.dist (distance from screen (cm))
%display.width (width of screen (cm))
%display.resolution (number of pixels of display in horizontal direction)
%
%ang (visual angle)
%
%Warning: assumes isotropic (square) pixels

%Calculate pixel size
pixSize = width/resolution(1);   %cm/pix
sz = 2*dist*tan(pi*ang/(2*180));  %cm
pix = round(sz/pixSize);   %pix 

return;

