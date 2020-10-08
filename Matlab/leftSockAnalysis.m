%%% Left sock analysis %%%

%% How to use:
% The importfile.m functions should import the csv files from Sensoria.
% Best practice is to have these uploaded to dropbox before closing the
% app. Record the order of trials in a lab notebook. convRightvals and
% convLeftVals are two functions that take a zero calibration recording
% (i.e. sock on foot, foot held in the air) to make sure the sensors can be
% zero'd on our backend. Important: this is a nonlinear zero'ing function
% that is described in those functions and cannot just be subtracted to the
% recorded values. 
%% 
clear
addpath('C:\Users\Daniel.Feeney\Desktop\SensoriaCode')  
leftCal = importsensoria('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting\Cal.csv');
levelVal = 1; %Change to 1 for level running
%% convert values
pre1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting\pre_1.csv');
conA = convLeftVals(pre1, leftCal);

pre2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting\pre_2.csv');
conB = convLeftVals(pre2, leftCal);

post1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting\post_1.csv');
conC = convLeftVals(post1, leftCal);

post2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting\post_2.csv');
conD = convLeftVals(post2, leftCal);

notension = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\ReliabilityTesting\noTension.csv');
conE = convLeftVals(notension, leftCal);
%% feature extraction from signals
%signals that look reasonable
%calcaneous, CS5
plot(conA.CS5(10:end))
[locs lvalsoc] = ginput(2);
%cut time series to be the same length
heel1 = conA.CS5(floor(locs(1)):floor(locs(2)));
nav1 = conA.CS4(floor(locs(1)):floor(locs(2)));
BigToe1 = conA.CS6(floor(locs(1)):floor(locs(2)));

heel1(heel1<5) = 0;
fThresh = 5;

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
desiredStepLen = 20;

pkHeel = zeros(1,length(lic));
varHeel = zeros(1,length(lic));
pkNav = zeros(1,length(lic));
varNav = zeros(1,length(lic));
pkBigToe = zeros(1,length(lic));
varBigToe = zeros(1,length(lic));

for step = 1:length(lic)
    pkHeel(step) = max(heel1(lic(step):lic(step)+desiredStepLen));
    varHeel(step) = std(heel1(lic(step):lic(step)+desiredStepLen));
    pkNav(step) = max(nav1(lic(step):lic(step)+desiredStepLen));
    varNav(step) = std(nav1(lic(step):lic(step)+desiredStepLen));
    pkBigToe(step) = max(BigToe1(lic(step):lic(step)+desiredStepLen));
    varBigToe(step) = std(BigToe1(lic(step):lic(step)+desiredStepLen));
end
[pkHeel; varHeel;pkNav;varNav;pkBigToe;varBigToe]'

%navicular, CS4
plot(conA.CS4(10:end))
hold on
plot(conB.CS4(10:end))



% 1st distal phalanx CS6
plot(conA.CS6(10:end))
hold on
plot(conB.CS6(10:end))

%% Broken down by sensor location 
figure(4)
plot(conA.CS0(10:end))
title('Lateral 5th ray')
hold on
plot(conB.CS0(10:end))
plot(conC.CS0(10:end))
plot(conD.CS0(10:end))
plot(conE.CS0(10:end))
legend('Lace','LR','Overlapping','Tri','X')

figure(5)
plot(conA.CS1(10:end))
title('5th MTP')
hold on
plot(conB.CS1(10:end))
plot(conC.CS1(10:end))
plot(conD.CS1(10:end))
plot(conE.CS1(10:end))
legend('Lace','LR','Overlapping','Tri','X')

figure(6)
plot(conA.CS2(10:end))
title('5th distal phalanx')
hold on
plot(conB.CS2(10:end))
plot(conC.CS2(10:end))
plot(conD.CS2(10:end))
plot(conE.CS2(10:end))
legend('Lace','LR','Overlapping','Tri','X')

figure(7)
plot(conA.CS3(10:end))
title('1st MTP')
hold on
plot(conB.CS3(10:end))
plot(conC.CS3(10:end))
plot(conD.CS3(10:end))
plot(conE.CS3(10:end))
legend('Lace','LR','Overlapping','Tri','X')

figure(8)
plot(conA.CS4(10:end))
title('Navicular')
hold on
plot(conB.CS4(10:end))
plot(conC.CS4(10:end))
plot(conD.CS4(10:end))
plot(conE.CS4(10:end))
legend('Lace','LR','Overlapping','Tri','X')

figure(9)
plot(conA.CS5(10:end))
title('Calcaneous')
hold on
plot(conB.CS5(10:end))
plot(conC.CS5(10:end))
plot(conD.CS5(10:end))
plot(conE.CS5(10:end))
legend('Lace','LR','Overlapping','Tri','X')

figure(10)
plot(conA.CS6(10:end))
title('1st Distal Phalanx')
hold on
plot(conB.CS6(10:end))
plot(conC.CS6(10:end))
plot(conD.CS6(10:end))
plot(conE.CS6(10:end))
legend('Lace','LR','Overlapping','Tri','X')

figure(11)
plot(conA.CS7(10:end))
title('Cuboid')
hold on
plot(conB.CS7(10:end))
plot(conC.CS7(10:end))
plot(conD.CS7(10:end))
plot(conE.CS7(10:end))
legend('Lace','LR','Overlapping','Tri','X')

%% Accelerometer data to delimit steps
%LRacc = sqrt(LRSwitch.Ax.^2 + LRSwitch.Ay.^2 + LRSwitch.Az.^2);
%plot(LRacc)

