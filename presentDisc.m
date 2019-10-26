function presentDisc(posBox,delta,sequence,disc,screen,beep,fs);

xPos = posBox(:,1);
yPos = posBox(:,2);

BeepXPosSeq = 38;
minusDeltaBeepPos = minusDelta(delta,sequence,BeepXPosSeq);

for n = 1:size(posBox,1)
    % Draw discs 
    Screen('DrawDots',screen.window,[xPos(n),-xPos(n);yPos(n),yPos(n)],disc.Size,disc.Color,[screen.xCenter,screen.yCenter],1);
    Screen('Flip',screen.window);
    %timeRecord(n)=toc;
    
    % Play sound at proper time point
    if n == minusDeltaBeepPos
        pahandle = psychSound(beep,fs);
    end
    
    % check whether step on the boundary
    if yPos(n) > screen.resolution(2)/2
        break;
    end
end

% close audio channel
PsychPortAudio('Stop', pahandle, 1);

%KbWait;
%sca;