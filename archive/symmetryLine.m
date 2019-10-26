function posRecordCentral= symmetryLine(posRecord);

headTail = posRecord([1,end],:);
x1 = headTail(1,2);
x2 = headTail(2,2);
y1 = headTail(1,3);
y2 = headTail(2,3);
xCenter = mean([x1,x2]);
yCenter = mean([y1,y2]);

k = (y2-y1) / (x2-x1);
b = y2 - k * x2;

% the function of symmtetry line : y = k*x+b;

posRecordCentral(:,1)= posRecord(:,1);
posRecordCentral(:,2)= -posRecord(:,2)+xCenter;
posRecordCentral(:,3)= -posRecord(:,3)+yCenter;