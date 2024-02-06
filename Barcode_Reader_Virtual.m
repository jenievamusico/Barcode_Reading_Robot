clc
clear
close all

% read in csv file of colour sensor readings
myInputMatrix = csvread("barcode_6_data.csv");

% extract colour value column and time value colums seperately
ColourVals = double(myInputMatrix(:,3));
ColourTimeVals = double(myInputMatrix(:,2));

% plot the colour values vs the time values
plot(ColourTimeVals, ColourVals)


% Moving average algorithm to filter (window size is 7)
ws = 7;

for i = 1: length(ColourVals)-(ws-1)
 ColourValsAvg(i) = sum(ColourVals(i:i+(ws-1)))/ws;
end

for i = 1:length(ColourValsAvg)-1
 ColourDer(i) = ColourValsAvg(i+1) - ColourValsAvg(i);
end

% find peaks of the derivative
[pks, locs] = findpeaks(ColourDer, "MinPeakDistance", 75, "MinPeakHeight", 3);

subplot(2,1,1)
plot(ColourVals) %Raw
hold on
plot(ColourValsAvg, 'r') %Avg

subplot(2,1,2)
plot(ColourDer, 'LineWidth', 2)
xlabel('Sample [n]', 'FontSize', 12)
hold
plot(locs,pks,'or')

% create an array of values representing the distances between the peaks
% (wide or narrow black bar) this is the plessey code value as an array of
% numbers
barcode_bar = [];

wide = 5000;

if locs(1)< wide
    barcode_bar(1) = 0;
else
    barcode_bar(1) = 1;
end
    
    
for i = 2 : 4  if locs(i) - locs(i-1) < wide
        barcode_bar(i) = 0;
    else
        barcode_bar(i) = 1;
    end
end

  
% transform each number in the array into a string then make a character of
% those strings put together
barcodePlessey = char(string(barcode_bar(1)) + string(barcode_bar(2)) + string(barcode_bar(3)) + string(barcode_bar(4)))

% transform plessey code into binary code by flipping the order of the
% numbers in the character
barcodeBin = barcodePlessey(end:-1:1)

% transform binary code into decimal value
barcodeDec = bin2dec(barcodeBin)
