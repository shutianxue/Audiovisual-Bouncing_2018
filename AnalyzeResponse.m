function [correctness] = AnalyzeResponse(answer)

%        order   answer(win)  answer(mac) 
% left     -1       37             80
% right     1       39             79

% OUTPUT: correctness
%incorrect = 0; correct = 1

if answer == 37
    correctness = 1;
else
    correctness = 0;
end
    