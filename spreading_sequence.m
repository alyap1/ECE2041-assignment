function [ value ] = spreading_sequence( userdata, codeword )
% spreaing the user's data with the codeword

data_for_coding1 = userdata(1) .* ones(1,4);
data_for_coding2 = userdata(2) .* ones(1,4) ;
seq1 = mod(data_for_coding1+codeword,2);
seq2 = mod(data_for_coding2+codeword,2); 
value = [seq1,seq2];
end

