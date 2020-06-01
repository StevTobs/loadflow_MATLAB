function [outputArg] = markOff_1D(unknown_index,inputArg )
n=size(unknown_index,2);
for i = 1:n
  
     if unknown_index (i)==0
        inputArg(i)= NaN;
        
     end
 
end

mark = not(isnan(inputArg));
dmm = zeros(1, sum(any(mark,1)));

outputArg = reshape( inputArg( not(mark == 0)),  [ 1,  sum(any(mark,1))]);

end
