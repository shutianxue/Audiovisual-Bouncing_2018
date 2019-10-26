function minusDeltaBeepPos = minusDelta(delta,sequence,realBeepPosSeq)

% locate the time point where the beep should be played based on delta and sequence
% Input:
%   delta: the temporal difference between the point when disc overlapping
%          occurs and the point when beep should be played
%          produced by QUEST, in sec
%   sequence: -1 = beep is played before the overlapping
%              1 = beep is played after the overlapping

load time_record; % obtain timeRecord
if sequence == -1
    timeRecordM = timeRecord(1:realBeepPosSeq,:);
else
    timeRecordM = timeRecord(realBeepPosSeq:end,:);
end

diffM(:,[1,2]) =[timeRecordM(:,1), timeRecordM(:,2)+ sequence * delta;];
minusDeltaBeepPos = diffM(find(abs(diffM(:,2)) == min(abs(diffM(:,2)))),1);