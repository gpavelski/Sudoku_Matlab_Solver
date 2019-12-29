%% Program Init

clc; close all; clear all;

%% Grid input

%Simply manually update the elements of the Sudoku grid
Grid = [...
    0 0 0 2 0 0 0 0 0;8 0 0 7 0 0 4 0 0;7 0 0 0 5 3 9 0 0;...
    3 7 0 0 0 0 0 0 4;0 0 0 3 0 6 0 0 0;1 0 0 0 0 0 0 3 5; ...
    0 0 1 8 9 0 0 0 3;0 0 4 0 0 1 0 0 2;0 0 0 0 0 5 0 0 0];

%% Solve puzzle

 Grid = sudokuguess(Grid)