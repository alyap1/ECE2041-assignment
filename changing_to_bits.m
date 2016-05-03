function [ answer ] = changing_to_bits( input )
% voltage to binary

array = zeros(1,length(input));
for i = 1:length(input)
   if input(i) == 1
       array(i) = 0;
   elseif input(i) == -1; 
       array(i) = 1;
   else
       array(i) = NaN;
   end
end

answer = array;

end

