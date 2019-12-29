%% Program Init

clc; close all; clear all;


%% Sudoku Grid Import

level=num2str(randperm(4,1));
code = num2str(randperm(999999999,1));
url = ['https://nine.websudoku.com/?level=' level '&set_id=' code]
data = webread(url);
startStr = 'cheat" TYPE=hidden VALUE="';
endStr = '">';
newStr = extractBetween(data,startStr,endStr);
v = zeros(1,length(newStr{1,1}));
for i = 1:length(newStr{1,1})
    v(i) = str2double(newStr{1,1}(i));
end
G = reshape(v,9,9)';

startStr = 'editmask" TYPE=hidden VALUE="';
endStr = '">';
newMask = extractBetween(data,startStr,endStr);
for i = 1:length(newStr{1,1})
    v(i) = str2double(newMask{1,1}(i));
end
M = reshape(v,9,9)';
M = abs(M-1);
H = G.*M;

%% Solve puzzle

'Solution : '
Grid = sudokuguess(H)