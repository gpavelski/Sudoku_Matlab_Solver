function [Grid,elements] = sudokusolve(Grid)

    model = 1:9; % The Sudoku puzzle only allows numbers between 1 and 9
    lines = zeros(9,9); % Array used for storing the elements in each line
    columns = zeros(9,9); % Array used for storing the elements in each columns
    blocks = zeros(9,9); % Array used for storing the elements in each 3x3 block
    elements = zeros(9^2,9); % Array used for storing the possible elements in each cell
    Z = zeros(9,9); % Auxiliary array
    W=Z; % Auxiliary array
    V=W; % Auxiliary array
    count = 1; % Start the counter
    it=0; % Start the iteration counter
    
    %Grid = Grid';

   ind = [1 2 3 10 11 12 19 20 21; 4 5 6 13 14 15 22 23 24; 7 8 9 16 17 18 25 26 27; ...
       28 29 30 37 38 39 46 47 48; 31 32 33 40 41 42 49 50 51; 34 35 36 43 44 45 52 53 54;...
      55 56 57 64 65 66 73 74 75; 58 59 60 67 68 69 76 77 78; 61 62 63 70 71 72 79 80 81];
    % Matrix of indexes
    
    while it == 1 || count ~= 0
        it=it+1;
        count=0;

        for i = 1:9
            a = nonzeros(Grid(i,:))'; % Store the nonzeros elements in line i
            lines(i,:) = [setdiff(model,a) zeros(1,9-length(setdiff(model,a)))];
            % Check what numbers are missing in the line i
            a = nonzeros(Grid(:,i))'; % Store the nonzeros elements in column i
            columns(i,:) =[setdiff(model,a) zeros(1,9-length(setdiff(model,a)))];
            % Check what numbers are missing in the column i
        end

       for i = 1:3
            for j = 1:3
                 a = nonzeros(Grid(3*(i-1)+1:3*(i-1)+3,3*(j-1)+1:3*(j-1)+3))';
                 % Store the nonzeros elements in the block i,j
                 blocks(3*(i-1)+j,:) = [setdiff(model,a) zeros(1,9-length(setdiff(model,a)))];
                 % Check what numbers are missing in the block i,j
            end
        end

        for i = 1:9 
            for j = 1:9 
                if Grid(i,j) == 0
                   a = nonzeros(intersect(lines(i,:),columns(j,:)))';
                   aux = nonzeros(intersect(a,blocks(3*((floor((i-1)/3)+1)-1)+floor((j-1)/3)+1,:)))';
                   elements(9*(i-1)+j,:) = [aux zeros(1,9-size(aux,2))];
                   if length(nonzeros(elements(9*(i-1)+j,:))) == 1
                      count = count+1;
                      Grid(i,j) = elements(9*(i-1)+j,1);
                      elements(9*(i-1)+j,:) = zeros(1,9);
                   end
                   [row,~] = ind2sub([9 9],find(ind==9*(i-1)+j));
                   if it > 1
                       a = nonzeros(intersect(elements(9*(i-1)+j,:),Z(row,:)));
                      if length(a) == 1
                          count = count+1;
                          Grid(i,j) = a;
                          elements(9*(i-1)+j,:) = zeros(1,9);
                      end
                      a = nonzeros(intersect(elements(9*(i-1)+j,:),V(j,:)));
                      if length(a) == 1
                          count = count+1;
                          Grid(i,j) = a;
                          elements(9*(i-1)+j,:) = zeros(1,9);
                      end
                      a = nonzeros(intersect(elements(9*(i-1)+j,:),W(i,:)));
                      if length(a) == 1
                          count = count+1;
                          Grid(i,j) = a;
                          elements(9*(i-1)+j,:) = zeros(1,9);
                      end
                   end
                end
            end
        end

        for i = 1:9
            X = nonzeros(histcounts(elements(ind(i,:),:)));
            Y = unique(elements(ind(i,:),:));
            Z(i,:) = [Y(X==1)' zeros(1,9 - length(Y(X==1)))];
            X = nonzeros(histcounts(elements([1:9]+(i-1)*9,:)));
            Y = unique(elements([1:9]+(i-1)*9,:));
            W(i,:) = [Y(X==1)' zeros(1,9 - length(Y(X==1)))];
            X = nonzeros(histcounts(elements(i:9:(i+72),:)));
            Y = unique(elements(i:9:(i+72),:));
            V(i,:) = [Y(X==1)' zeros(1,9 - length(Y(X==1)))];
        end
    end
end