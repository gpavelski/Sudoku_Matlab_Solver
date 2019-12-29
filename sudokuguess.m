function [Grid] = sudokuguess(Grid)

%% Variables Initialization

A = zeros(1,81); % Matrix containing the number of possibilities for each element
k=0; % Loop variable
n=0; % Loop variable
vec=0; % Vector containing the current decision
h=1; % Minimum index for Matlab vector
nMax = 0; %Initialize the maximum level
nM = 0; % Counter of multiplications by 2
stopM=0; % Switch used for stopping multiplying by 2
Nlevels = 5; %Maximum number of tries in a given branch
set=0;  % Switch used to detect that a maximum level has been reached
m=0; % Used to detect how many levels need to return
l = zeros(1,9); % Vector for summing the lines (rows)
c = zeros(1,9); % Vector for summing the columns
b=0; 
it = 0; % Loop iteration counter

while h <= length(vec)
    if it == 0 % If it is the first iteration...
       Grid_orig = Grid; % Store the original grid for backup if the solution is wrong
    end
    
    [Grid, elements] = sudokusolve(Grid);
    % Call the function sudokusolve for updating the grid
    it = it+1; % Add 1 to the iteration index
    
    for i = 1:81
        A(1,i) = length(nonzeros(elements(i,:)));
        % Count the number of possibilities in each of the 81 grid cells;
        % If the cell is occupied, 0, otherwise, the number of
        % possibilities.
    end

    for i = 1:9
        l(i) = sum(Grid(i,:));
        c(i) = sum(Grid(:,i));
        % Compute the summation of the elements in each line and each
        % column for the purpose of checking the validity of the result.
    end
    S = sum(Grid(:)); % Do the summation of all the elements in the grid
    out=nnz(~Grid); 
    % Compute the number of zeros of the grid (How many cells still need to
    % be filled.
    
    if out > 4 && n < Nlevels && isempty(find(l>45,1)) ~= 0 && isempty(find(c>45,1)) ~= 0 && S <= 405% is incomplete
    % If there are at least 4 blank spaces AND the maximum number of levels have
    % not been attained AND there is no line or collumn with summation greater than 45
    % AND the total summation is lesser than 405, then should procceed.
        if nM == Nlevels % Detect when should stop multiplying the vector vec elements
            stopM = 1;
       end
       
       n = n+1; % The tree level index add 1 
       
       if n > nMax % If the tree level index is higher then the maximum level obtained up to now:
           nMax = n; % The maximum level attained is equal to n
           set=1; % Switch on for multiplying by 2 (a new child node is needed)
       end
       
       if stopM == 0 && set == 1 % If it is still possible to multiply the vector...
           vec = vec*2; % Then multiply by two
           nM = nM+1; % Increases the number of multiplications by 1
           set=0; % Switch off the multiplication switch
       end
       
       if rem(vec(h),2) == 0    % If vec in the index h is even...
           vec(end+1)=vec(h)+1*2^(nMax-n); % Add one brother to the current node
           vec = sort(vec); % Sort the vector elements
           binvec = de2bi(vec,'left-msb'); % Convert the vec vector to binary
           
           b(end+1) = 0; % Add one more element to the vector b
           b(h+1:end) = circshift(b(h+1:end),1); % Shift the current elements of the vector b
           a = find(A==2,1); % Find the first element of the grid with only two possibilities *
           [col,row] = ind2sub([9 9],a); % Convert the index to column and row index
           x = nonzeros(elements(a,:)); % Obtain the two possibilities for the cell a
           b(h:h+1) = x; % Add these two possibilities to the vector b
       end
       
       if h > 1 % If the vec index h is greater than 1:
            m = ceil(sum(xor(binvec(h,1:size(binvec,2)),binvec(h-1,1:size(binvec,2)))))-1;
            % Compute how many levels the tree should return for moving to
            % the next node. If 0: Same level, Otherwise, return to a
            % superior level
            if rem(vec(h),2) == 0 % If the number is even, don't return
                m = 0;
            end
       end
       
       Grid(row,col) = b(h); % Update the cell a with the current guess
       
    elseif out > 4 && n == Nlevels % If the maximum number of tries is attained        
        %and the problem is not solved, move to the next guess and return
        %to the initial grid
        h=h+1;
        Grid = Grid_orig;
        Grid(row,col) = b(h);
    elseif isempty(find(l>45,1)) == 0 || isempty(find(c>45,1)) == 0 || S > 405 % failed
        % if the current guess leads to a wrong solution, try the next
        % guess
        h=h+1;
        Grid = Grid_orig;
        Grid(row,col) = b(h);
    elseif out > 0 && out < 5
        %If the number of empty spaces is too small and the problem is not
        %solved, then fails, try the next guess
        h=h+1;
        Grid = Grid_orig;
        Grid(row,col) = b(h);
    else
        h = h+1;
        if h > length(vec)
            % It means the solution is finished, stops the loop
            break;
        end
        if length(find(l==45))==9 && length(find(c==45))==9 && S == 405
            % If the problem is correctly addressed, stops the loop
            break;
        end
        m = ceil(sum(xor(binvec(h,1:size(binvec,2)),binvec(h-1,1:size(binvec,2)))))-1;
    end
    
    n=n-m;
    % Return to a previous level if necessary
end