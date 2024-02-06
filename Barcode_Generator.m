clc
clear
close all

%Ask user for input
userInputDec = input('Enter a number between 0 and 15:')

while (userInputDec < 0) || (userInputDec > 15)

DISP('Error: Number out of range try again')
userInputDec = input('Enter a number between 0 and 15:')
end
userInputBin = dec2bin(userInputDec,4)

%PlessiCode = flip(userInputBin)
% userInputBinFlipped = userInputBin*0;

% reverse the order of the characters in the binary code to get the plessey
% code
userInputBinFlipped = userInputBin(end:-1:1)

%image creater
A = ones(720,1280);

wide = 280;
narrow = 80;
e1 = 1;
e2 = 320;
e3 = 640;
e4 = 960;
e5 = 1280;

%if the number in the plessey code is a 1 then its a wide black bar and if
%its a 0 then its a narrow black bar
if (userInputBinFlipped(1) == '1')
 A(:,e1:e1+wide) = 0;
else
 A(:,e1:e1+narrow) =0;
end
if (userInputBinFlipped(2) == '1')
 A(:,e2:e2+wide) = 0;
else
 A(:,e2:e2+narrow) =0;
end
if (userInputBinFlipped(3) == '1')
 A(:,e3:e3+wide) = 0;
else
 A(:,e3:e3+narrow) =0;
end
if (userInputBinFlipped(4) == '1')
 A(:,e4:e4+wide) = 0;
else
 A(:,e4:e4+narrow) =0;
end

% adding some noise on top of the barcode
A = A+.2*rand(720,1280);

imwrite(A,'Data2.jpg')