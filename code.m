clear all ; clc;

%Walsh-Hammard Code for 3 users
codeSize = 4; % used in CDMA signal to create N separate channels per base stations
N = 2;
H = [0 0 ; 0 1];
if bitand(codeSize,codeSize-1) == 0
    while(N ~= codeSize)
           N = N*2; %increae by power of 2 
           H = repmat(H,[2,2]); % B = repmat(A,n) - The size of B is size(A)*n when A is a matrix.
           [m,n] = size(H);

          %Invert the matrix located at the bottom right hand corner
          for i = m/2+1:m,
              for j = n/2+1:n,
                    H(i,j) =~ H(i,j);
             end
         end
    end
else
disp('INVALID CODE SIZE:The code size must be a power of 2');
end

%codewords for each user
codeword1 = H(1,:);
codeword2 = H(2,:);
codeword3 = H(3,:);

%User data
user1_data_S = [0,0];
user2_data_S = [1,0];
user3_data_S = [1,1];

%Multiplexing
%for user1 
spreadingseq1 = spreading_sequence(user1_data_S, codeword1);
%for user2
spreadingseq2 = spreading_sequence(user2_data_S, codeword2);
%for user3
spreadingseq3 = spreading_sequence(user3_data_S, codeword3);

% converting to volts for composite signal
array1 = changing_to_volts(spreadingseq1);
array2 = changing_to_volts(spreadingseq2);
array3 = changing_to_volts(spreadingseq3);

compositesequence = array1 + array2 + array3;

%Demultiplexing
%User 1
codeword_volt1 = changing_to_volts([codeword1,codeword1]);
user1_signal = codeword_volt1.*compositesequence ;
user1_data_E = changing_to_bits([sum(user1_signal(1,1:4))/4,sum(user1_signal(1,5:8))/4]) ;

%User 2
codeword_volt2 = changing_to_volts([codeword2,codeword2]);
user2_signal = codeword_volt2.*compositesequence ;
user2_data_E = changing_to_bits([sum(user2_signal(1,1:4))/4,sum(user2_signal(1,5:8))/4]) ;

%User 3
codeword_volt3 = changing_to_volts([codeword3,codeword3]);
user3_signal = codeword_volt3.*compositesequence ;
user3_data_E = changing_to_bits([sum(user3_signal(1,1:4))/4,sum(user3_signal(1,5:8))/4]) ;