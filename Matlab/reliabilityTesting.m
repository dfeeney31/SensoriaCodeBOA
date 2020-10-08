% calcualting reliability of sensoria data. Use a calibration file
% "leftCal" to do a zero based on the values during a recording with the
% foot in the air and no pressure on the sensors. 
% Step1: convert values, Step2: delimit trial, Step3: extract features
clear
addpath('C:\Users\Daniel.Feeney\Desktop\SensoriaCode')  
leftCal = importsensoria('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting\Cal.csv');
% input dir where files live
input_dir = 'C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting';

cd(input_dir)
files = dir('*.csv');
dataList = {files.name};
dataList = sort(dataList);
[f,~] = listdlg('PromptString','Select data files for all subjects in group','SelectionMode','multiple','ListString',dataList);
NumbFiles = length(f);

outputAllConfigs = {'TrialNo','PrePost','PkHeel','varHeel','PkNav','VarNav','PkToe','VarToe','PkL5R','VarL5R'};
% constants
writeData = 1; %writes spreadsheet if 1, does not if 0.
fThresh = 5; %filter for low heel pressure values. Sets values below this to 0
desiredStepLen = 20; %number of indices to look forward (step length)
    
for s = 1:NumbFiles
    %% convert values
    fileName = dataList{f(s)};
    fileLoc = [input_dir '\' fileName];
    
    splitFName = strsplit(fileName,'_'); 
    prepost = splitFName{1};
    trialno = splitFName{2}(1);
    
    pre1 = importsensoria(fileLoc);
    conA = convLeftVals(pre1, leftCal);
    
    %% feature extraction from signals
    %signals that look reasonable
    %calcaneous, CS5
    plot(conA.CS5(10:end))
    [locs lvalsoc] = ginput(2);
    %cut time series to be the same length
    heel1 = conA.CS5(floor(locs(1)):floor(locs(2)));
    nav1 = conA.CS4(floor(locs(1)):floor(locs(2)));
    BigToe1 = conA.CS6(floor(locs(1)):floor(locs(2)));
    L5R = conA.CS0(floor(locs(1)):floor(locs(2)));
    heel1(heel1<fThresh) = 0;
    
    %%%% Delimit strides based on heel data %%%%
    lic = zeros(10,1);
    count = 1;
    for step = 1:length(heel1)-1
        if (heel1(step) == 0 && heel1(step + 1) >= fThresh)
            lic(count) = step;
            count = count + 1;
        end
    end
    lto = zeros(10,1);
    count = 1;
    for step = 1:length(heel1)-1
        if (heel1(step) >= fThresh && heel1(step + 1) == 0)
            lto(count) = step+1;
            count = count + 1;
        end
    end
    %Find approximate heel strike and toe off based on heuristic that there
    %will be a minimal value at toe off. Value of fThresh may be adjusted as
    %the limit for this value
    if (lic(1) > lto(1))
        lto(1) = [];
    end
    lic(lic == 0) = []; lto(lto == 0) = [];
    
    if (lic(end) > lto(end))
        lic(end) = [];
    end
    
    plot(heel1)
    hold on
    for i = 1:length(lic)
        xline(lic(i), 'color','r');
        xline(lto(i),'color','b');
    end
    
    pkHeel = zeros(1,length(lic));
    varHeel = zeros(1,length(lic));
    pkNav = zeros(1,length(lic));
    varNav = zeros(1,length(lic));
    pkBigToe = zeros(1,length(lic));
    varBigToe = zeros(1,length(lic));
    pkL5R = zeros(1,length(lic));
    varL5R = zeros(1,length(lic));
    
    for step = 1:length(lic)
        pkHeel(step) = max(heel1(lic(step):lic(step)+desiredStepLen));
        varHeel(step) = std(heel1(lic(step):lic(step)+desiredStepLen));
        pkNav(step) = max(nav1(lic(step):lic(step)+desiredStepLen));
        varNav(step) = std(nav1(lic(step):lic(step)+desiredStepLen));
        pkBigToe(step) = max(BigToe1(lic(step):lic(step)+desiredStepLen));
        varBigToe(step) = std(BigToe1(lic(step):lic(step)+desiredStepLen));
        pkL5R(step) = max(L5R(lic(step):lic(step)+desiredStepLen)); %change to appropriate sensor!
        varL5R(step) = std(L5R(lic(step):lic(step)+desiredStepLen));
    end
    
    PrePostTmp = cell(length(lic),1); %condition from early in the file
    TrialNoTmp = cell(length(lic),1); %subject name from earlier in the file
    for i = 1:length(lic)
        PrePostTmp(i) = {prepost};
        TrialNoTmp(i) = {trialno};
    end
    
    kinData = num2cell([pkHeel; varHeel;pkNav;varNav;pkBigToe;varBigToe;pkL5R;varL5R]'); %modulate this to subject name and config
    kinData = horzcat(PrePostTmp, TrialNoTmp, kinData);
    outputAllConfigs = vertcat(outputAllConfigs, kinData);
   
    close all
    
end

if writeData == 1
    % Convert cell to a table and use first row as variable names
    T = cell2table(outputAllConfigs(2:end,:),'VariableNames',outputAllConfigs(1,:));
    % Write the table to a CSV file
    writetable(T,'trial3.csv')
end