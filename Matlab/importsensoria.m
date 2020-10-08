function x1 = importsensoria(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   imports sensoria csv files with the UNCALIBRATED SENSORS for backend
%   calibration on our end. 

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 12;
    endRow = inf;
end

%% Read columns of data as text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'WhiteSpace', '', 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    % Converts text in the input cell array to numbers. Replaced non-numeric
    % text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% Split data into numeric and string columns.
rawNumericColumns = raw(:, [3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31]);
rawStringColumns = string(raw(:, [1,2,17,32]));


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
x1 = table;
x1.Tag = rawStringColumns(:, 1);
x1.AutoTag = rawStringColumns(:, 2);
x1.Tick = cell2mat(rawNumericColumns(:, 1));
x1.T = cell2mat(rawNumericColumns(:, 2));
x1.S0 = cell2mat(rawNumericColumns(:, 3));
x1.S1 = cell2mat(rawNumericColumns(:, 4));
x1.S2 = cell2mat(rawNumericColumns(:, 5));
x1.Ax = cell2mat(rawNumericColumns(:, 6));
x1.Ay = cell2mat(rawNumericColumns(:, 7));
x1.Az = cell2mat(rawNumericColumns(:, 8));
x1.Gx = cell2mat(rawNumericColumns(:, 9));
x1.Gy = cell2mat(rawNumericColumns(:, 10));
x1.Gz = cell2mat(rawNumericColumns(:, 11));
x1.Mx = cell2mat(rawNumericColumns(:, 12));
x1.My = cell2mat(rawNumericColumns(:, 13));
x1.Mz = cell2mat(rawNumericColumns(:, 14));
x1.HRM = rawStringColumns(:, 3);
x1.S3 = cell2mat(rawNumericColumns(:, 15));
x1.S4 = cell2mat(rawNumericColumns(:, 16));
x1.S5 = cell2mat(rawNumericColumns(:, 17));
x1.S6 = cell2mat(rawNumericColumns(:, 18));
x1.S7 = cell2mat(rawNumericColumns(:, 19));
x1.CS0 = cell2mat(rawNumericColumns(:, 20));
x1.CS1 = cell2mat(rawNumericColumns(:, 21));
x1.CS2 = cell2mat(rawNumericColumns(:, 22));
x1.CS3 = cell2mat(rawNumericColumns(:, 23));
x1.CS4 = cell2mat(rawNumericColumns(:, 24));
x1.CS5 = cell2mat(rawNumericColumns(:, 25));
x1.CS6 = cell2mat(rawNumericColumns(:, 26));
x1.CS7 = cell2mat(rawNumericColumns(:, 27));
x1.RSSI = cell2mat(rawNumericColumns(:, 28));
x1.Timestamp = rawStringColumns(:, 4);

