function [ answer ] = changing_to_volts( input )
% binary to voltage

array = zeros(1,length(input));
for i = 1:length(input)
   if input(i) == 0
       array(i) = 1;
   elseif input(i) == 1 
       array(i) = -1;
   else
       array(i) = NaN;
   end
end

answer = array;
end

