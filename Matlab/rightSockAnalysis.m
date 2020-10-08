%%%%%% Sensor 0: Tibia, 1: MTP 5, 2: M Malleolus, 3: Navicular, 4: MTP 1 %%
%%%%%% Sensor 5: Calcaneus, 6: lateral malleolus, 7: cuboid %%%%%%%%%%%%%%

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

importsensoria('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\DFCal.csv')

testCal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\CalibrationTesting\BHCal.csv');
BH = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\CalibrationTesting\BHWalk.csv');


rightCal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\StretchTesting\RVCalRight.csv');
rightCal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\StretchTesting\MZCalRight.csv');


walk_dat = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\StretchTesting\DFRightA.csv');
walk_dat2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\StretchTesting\DFRightB.csv');

%walk_dat3 = importfile('C:\Users\Daniel.Feeney\Desktop\SensoriaCode\reliability\rightWalkHigh.csv');
%rightCal = importfile('C:\Users\Daniel.Feeney\Desktop\SensoriaCode\reliability\rightNoLoad.csv');

%%% convert values with function convRightVals
test = convRightVals(BH, testCal);
conB = convRightVals(walk_dat2, rightCal);
%walkHigh = convRightVals(walk_dat3, rightCal);

%%% Full sock %%%
figure(1)
plot(test.CS0(10:end))
hold on
plot(test.CS1(10:end))
plot(test.CS2(10:end))
plot(test.CS3(10:end))
plot(test.CS4(10:end))
plot(test.CS5(10:end))
plot(test.CS6(10:end))
plot(test.CS7(10:end))
ylabel('Pressure (PSI)', 'FontSize',14)
xlabel('Index (1/33 s)', 'FontSize',14)
legend('Tibia','5th Met', 'M Malleolus', 'Navicular','1st Met','Calcneus','L. Malleolus','Cuboid')

%%% Only foot sensors %%%
figure(2)
plot(BH.CS3(10:end))
title('Config A')
hold on
plot(BH.CS7(10:end))
plot(BH.CS1(10:end))
plot(BH.CS4(10:end))
plot(BH.CS5(10:end))
ylim([0 100])
xlim([0 300])
legend('Navicular','Cuboid', '5th Met','1st Met','Calcaneus')

figure(3)
plot(conB.CS3(10:end))
title('Config B')
hold on
plot(conB.CS7(10:end))
plot(conB.CS1(10:end))
plot(conB.CS4(10:end))
plot(conB.CS5(10:end))
ylim([0 100])
xlim([0 300])
legend('Navicular','Cuboid', '5th Met','1st Met','Calcaneus')

figure(4)
plot(walk_dat3.CS3(10:end))
title('Over Tight')
hold on
plot(walk_dat3.CS7(10:end))
plot(walk_dat3.CS1(10:end))
plot(walk_dat3.CS4(10:end))
plot(walk_dat3.CS5(10:end))
legend('Navicular','Cuboid', '5th Met', '1st Met','Calcaneus')

figure(5)
plot(walk_dat4.CS3(10:end))
title('Lace less')
hold on
plot(walk_dat4.CS7(10:end))
plot(walk_dat4.CS1(10:end) + 3)
plot(walk_dat4.CS4(10:end))
plot(walk_dat4.CS5(10:end) + 6)
ylim([0 30])
legend('Navicular','Cuboid', '5th Met', '1st Met','Calcaneus')

