%%% Left sock analysis %%%

%% How to use:
% The importfile.m functions should import the csv files from Sensoria.
% This version uses uigetfile to allow user to select files rather than
% hard code them in
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
disp('Select Calibration file')
[file1, path1] = uigetfile('*.csv');
left_cal = importfile(strcat(path1,file1));

%% Level running
disp('Select Lace')
[lace,path] = uigetfile('*.csv');
LaceSwitch = importfile(strcat(path,lace));
conA = convLeftVals(LaceSwitch, left_cal);

disp('Select LR')
[lr,lrPath] =uigetfile('*.csv');
LRSwitch = importfile(strcat(lrPath,lr));
conB = convLeftVals(LRSwitch, left_cal);

disp('Select Panels')
[panels, panelPath] = uigetfile('*.csv');
OverlapSwitch = importfile(strcat(panelPath,panels));
conC = convLeftVals(OverlapSwitch, left_cal);

disp('Select Tri strap')
[tri, triPath] = uigetfile('*.csv');
TriSwitch = importfile(strcat(triPath,tri));
conD = convLeftVals(TriSwitch, left_cal);

disp('Select Y Wrap')
[YW, yPath] = uigetfile('*.csv');
YSwitch = importfile(strcat(yPath,YW));
conE = convLeftVals(YSwitch, left_cal);
%% plotting
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
disp('Select Y Wrap')

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
plot(LaceSwitch.CS7(10:end))
title('Cuboid')
hold on
plot(LRSwitch.CS7(10:end))
plot(OverlapSwitch.CS7(10:end))
plot(TriSwitch.CS7(10:end))
plot(YSwitch.CS7(10:end))
legend('Lace','LR','Overlapping','Tri','X')

%% Accelerometer data to delimit steps
%LRacc = sqrt(LRSwitch.Ax.^2 + LRSwitch.Ay.^2 + LRSwitch.Az.^2);
%plot(LRacc)

