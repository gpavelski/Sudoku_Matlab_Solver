# Sudoku_Matlab_Solver
Code for solving Sudoku puzzle giving an array as input

The algorithm was tested for four different levels of difficulty: Easy, Normal, Hard and Evil, according to: https://www.websudoku.com/

It is capable of solving any puzzle of any difficulty level considering the input correct.

For the puzzles Easy and Normal the idea is basically compare the elements missing in each column, line and block and compare.

However, for the puzzles of Hard and Evil difficult, there are some steps where guessing is necessary. 
For guessing the idea was to use a dual-tree computing model, first selecting one cell where only two values are possible, then guessing the smaller one and test if it works, if it fails, then select the next guess. In general, only a few guesses are necessary for solving the problem.

For input, you can use two ways:

1. ManualGrid.m : a manual input, such as:

Grid = [...
    0 0 0 2 0 0 0 0 0;8 0 0 7 0 0 4 0 0;7 0 0 0 5 3 9 0 0;...
    3 7 0 0 0 0 0 0 4;0 0 0 3 0 6 0 0 0;1 0 0 0 0 0 0 3 5; ...
    0 0 1 8 9 0 0 0 3;0 0 4 0 0 1 0 0 2;0 0 0 0 0 5 0 0 0];
    
  or:
  
2. AutoGrid.m : The code will connect directly to the https://www.websudoku.com/, import a random puzzle of a random level and solve it. The URL and the solution are the outputs. (Require a good internet connection).
