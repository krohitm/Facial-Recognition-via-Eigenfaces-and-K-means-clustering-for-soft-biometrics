function[Gender] = importSoft()
%this function imports information for soft biometric clustering 

filename = '\\Client\H$\Documents\Courses\EMI\Project2\Gender.txt';
delimiter = ',';
formatSpec = '%f%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
ID = dataArray{:, 1};
Gender = dataArray{:, 2};
clearvars filename delimiter formatSpec fileID dataArray ans;

