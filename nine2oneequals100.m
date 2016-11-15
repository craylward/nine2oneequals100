% How many ways can you make 100 out of the sequence of non-zero digits
% 987654321 in order by placing arithmetic signs in between them.
% +, -, /, *

% Consider the nine descending sequenced digits with a "bucket" to place an
% operator in between each digit. We have 5 operators (+. -, /, *,'combine'),
% so 8 buckets with 5 possible choices yields 5^8
% possibilities (390625). 
% NOTE: If we include the leading minus sign, possibilities increases to 5^9
% FUTURE: Implement modulus operator (%). Where would this fit in the order
% of operations...?

% 1. Brute force approach: Generate base 5 numbers from 00000000 to 44444444 to cover all
% posibilities. 
% 2. Order of operations I.Combine; II. Multiply and Divide; III. Add and
% subtract

ops = 5; % Set the number of operators to use i.e. 3: combine, +, ,-; 5: *,/
target = 100; % set target
signs = zeros(1,9); % buckets to store sign operators
possibilities = 5^ops; % number of possible combinations
solutions = 0; % count for solutions
progress = waitbar(0, 'Finding solutions'); % progress bar 

for i=0:possibilities % iterate through ALL possibilities
    % Convertbase - creates array of operators
    w = int32(i);
    for k=length(signs):-1:1
        signs(1, k) = mod(w,5);
        w = w/5;
    end
    sum = 0; % track sum of current combination
    next_num = 9; % number we are performing an operation ON
    lastop = signs(1,1); % get the first operator
    lastop_sec = 0; % used for tracking secondary operator (*, /)
    factor = 0; % used for tracking secondary operand
    % 0=concat, 1=+, 2=-, 3=*, 4=/
    if lastop ~= 1 && lastop ~= 3 && lastop ~= 4 % skip if the first operator is +, /, or * (non-sensical)
        for j=2:9
            if signs(1,j)==1 || signs(1,j)==2 % Add/Subtract
                switch lastop_sec % Check if we need to multiplty/divide before adding/subtracting
                    case 3
                        next_num = factor*next_num; % Get product
                    case 4 
                        next_num = factor/next_num; % Get quotient
                end
                switch lastop
                    case 1
                        sum = sum+next_num; % Get sum
                    case 2
                        sum = sum-next_num; % Get difference
                    otherwise
                        sum = next_num; % Case for combined
                end
                % reset secondary operator/operand
                lastop_sec = 0; 
                factor = 0;
                
             	next_num = 0;
                lastop = signs(1,j);
            elseif signs(1,j)==3 || signs(1,j)==4 % Multiply/Divide
                switch lastop_sec
                    case 3
                        factor = factor*next_num; % Get product
                    case 4 
                        factor = factor/next_num; % Get quotient
                    otherwise
                        factor = next_num; % Case for combined
                end
                next_num = 0;
                lastop_sec = signs(1,j);
            end
            next_num = next_num*10 + (9-j+1);  % Combine
        end 
        % handle final operation
        switch lastop_sec
            case 3
                next_num = factor*next_num; % Get product
            case 4 
                next_num = factor/next_num; % Get quotient
        end
        switch lastop
            case 1
                sum = sum+next_num; % Get sum
            case 2
                sum = sum-next_num; % Get difference
            otherwise
                sum = next_num; % Case for combined
        end
        if sum == target % solution found          
            solutions = solutions + 1; % increment solution count
            % Display string
            str = '';
            for m=1:9
                switch signs(1,m)
                    case 1
                        str = strcat(str,'+');
                    case 2
                        str = strcat(str,'-');
                    case 3
                        str = strcat(str,'*');
                    case 4
                        str = strcat(str,'/');
                end
                str=strcat(str,num2str(9-m+1));
            end 
            str= strcat(str,'=100');
            disp(str);        
        end
    end
    % increment progress bar (every 1000 iterations for timeliness)
    if mod(i,1000)==0 
        waitbar(i/possibilities);
    end
end
close(progress);

