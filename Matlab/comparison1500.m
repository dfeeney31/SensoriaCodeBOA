%%%% 1500 V1 vs V2 testing %%%

clear
addpath('C:\Users\Daniel.Feeney\Desktop\SensoriaCode')  
%% Kate
left_cal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\KateCal.csv');

V1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\KateOld.csv'); 
V1cal = convLeftVals(V1, left_cal);
V2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\KateNew.csv');
V2cal = convLeftVals(V2, left_cal);

%% Dan
left_cal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\DFCal.csv');

V1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\DFboa.csv'); 
V1cal = convLeftVals(V1, left_cal);
V2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\DFLace.csv');
V2cal = convLeftVals(V2, left_cal);

%% Clark
left_cal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\ClarkCal.csv');

V1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\ClarkOld.csv');
V1cal = convLeftVals(V1, left_cal);
V2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\1500Testing\ClarkNew.csv');
V2cal = convLeftVals(V2, left_cal);

%% Variability in heel hold 
std(V1cal.CS5(50:end))
std(V2cal.CS5(50:end))
%% Plotting
figure(4)
plot(V1cal.CS0(10:end))
title('Lateral 5th ray')
hold on
plot(V2cal.CS0(10:end))
legend('V1','V2')
xlim([0 500])

figure(5)
plot(V1cal.CS1(10:end))
title('5th MTP')
hold on
plot(V2cal.CS1(10:end))
legend('V1','V2')
xlim([0 500])

figure(6)
plot(V1cal.CS2(10:end))
title('5th distal phalanx')
hold on
plot(V2cal.CS2(10:end))
legend('V1','V2')
xlim([0 500])

figure(7)
plot(V1cal.CS3(10:end))
title('1st MTP')
hold on
plot(V2cal.CS3(10:end))
legend('V1','V2')
xlim([0 500])

figure(8)
plot(V1cal.CS4(10:end))
title('Navicular')
hold on
plot(V2cal.CS4(10:end))
legend('V1','V2')
xlim([0 500])

figure(9)
plot(V1cal.CS5(10:end))
title('Calcaneous')
hold on
plot(V2cal.CS5(10:end))
legend('V1','V2')
xlim([0 500])

figure(10)
plot(V1cal.CS6(10:end))
title('1st Distal Phalanx')
hold on
plot(V2cal.CS6(10:end))
legend('V1','V2')
xlim([0 500])

figure(11)
plot(V1cal.CS7(10:end))
title('Cuboid')
hold on
plot(V2cal.CS7(10:end))
legend('V1','V2')
xlim([0 500])