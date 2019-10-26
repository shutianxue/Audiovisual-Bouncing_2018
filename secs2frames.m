function frames=secs2frames(frameRate,secs)

%converts time in seconds to frames

%11/16/07 gmb wrote it.

frames = round(secs*frameRate);