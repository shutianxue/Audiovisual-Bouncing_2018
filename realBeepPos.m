function realBeepPos = realBeepPos(beepLag,beepXpos,timeRecord)

% Parameters (updated on Dec 18, 2017)
%i2 = 0.0281;
%beepXpos = 38;

cutRange = 10;
timeRecordM = timeRecord(beepXpos-cutRange:beepXpos+cutRange,:);
realBeepposXRounding = timeRecordM(cutRange+1,2)-beepLag;
diffM(:,[1,2]) =[timeRecordM(:,1), (timeRecordM(:,2) - realBeepposXRounding)];
realBeepPos = diffM(find(abs(diffM(:,2)) == min(abs(diffM(:,2)))),1);