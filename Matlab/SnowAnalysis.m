%%%%% Ski Sensoria analysis %%%%%

clear
addpath('C:\Users\Daniel.Feeney\Desktop\SensoriaCode')  
leftCal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Cal_L.csv');
rightCal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Cal_R.csv');

%% Left side
G1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Groom_L_1.csv');
G2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Groom_L_2.csv');
G3 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Groom_Unbuckled_L.csv');

%%%%% Convert to dynamically-calibrated pressure data %%%%%
trial1_Cal = convLeftVals(G1, leftCal);
trial2_Cal = convLeftVals(G2, leftCal);
trial3_Cal = convLeftVals(G3, leftCal);

%% Right side
G1R = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Groom_R_1.csv');
G2R = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Groom_R_2.csv');
G3R = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Snow Protocol\Protocol_Data\SensoriaData\BV_Groom_Unbuckled_R.csv');

%%%%% Convert to dynamically-calibrated pressure data %%%%%
trial1_CalR = convRightVals(G1R, rightCal);
trial2_CalR = convRightVals(G2R, rightCal);
trial3_CalR = convRightVals(G3R, rightCal);

%% Right Plotting
figure(1)
plot(G2.CS0(10:end))
hold on
plot(G2.CS1(10:end))
plot(G2.CS2(10:end))
plot(G2.CS3(10:end))
plot(G2.CS4(10:end))
plot(G2.CS5(10:end))
plot(G2.CS6(10:end))
plot(G2.CS7(10:end))
ylabel('Pressure (PSI)', 'FontSize',14)
xlabel('Index (1/33 s)', 'FontSize',14)
legend('Tibia','5th Met', 'M Malleolus', 'Navicular','1st Met','Calcneus','L. Malleolus','Cuboid')

figure(2)
plot(G2R.CS0(10:end))
hold on
plot(G2R.CS1(10:end))
plot(G2R.CS2(10:end))
plot(G2R.CS3(10:end))
plot(G2R.CS4(10:end))
plot(G2R.CS5(10:end))
plot(G2R.CS6(10:end))
plot(G2R.CS7(10:end))
ylabel('Pressure (PSI)', 'FontSize',14)
xlabel('Index (1/33 s)', 'FontSize',14)
legend('Tibia','5th Met', 'M Malleolus', 'Navicular','1st Met','Calcneus','L. Malleolus','Cuboid')

%% Right side comparison
% CV for pressure on tibia
std(G2R.CS0(800:1500)) / mean(G2R.CS0(800:1500))
std(G3R.CS0(800:1500)) / mean(G3R.CS0(800:1500))


figure
plot(G2R.CS0(10:end))
title('Tibia')
hold on
plot(G3R.CS0(10:end))
legend('Trial 2','Trial 3')

figure
plot(G1R.CS1(10:end))
title('5th Met')
hold on
plot(G2R.CS1(10:end))
plot(G3R.CS1(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure
plot(G1R.CS2(10:end))
title('M Malleolus')
hold on
plot(G2R.CS2(10:end))
plot(G3R.CS2(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure
plot(G2R.CS3(10:end))
title('Navicular')
hold on
plot(G3R.CS3(10:end))
legend('Trial 2','Trial 3')

figure
plot(G1R.CS4(10:end))
title('1st Met')
hold on
plot(G2R.CS4(10:end))
plot(G3R.CS4(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure
plot(G2R.CS5(10:end))
title('Calcaneous')
hold on
ylabel('Pressure (PSI)')
plot(G3R.CS5(10:end))
legend('Trial 2','Trial 3')


figure
plot(G1R.CS6(10:end))
title('L. Malleolus')
hold on
plot(G2R.CS6(10:end))
plot(G3R.CS6(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure
plot(G1R.CS7(10:end))
title('Cuboid')
hold on
plot(G2R.CS7(10:end))
plot(G3R.CS7(10:end))
legend('Trial 1','Trial 2','Trial 3')

%% Plotting
figure(1)
plot(trial1_Cal.CS0(10:end))
title('Lateral 5th ray')
hold on
plot(trial2_Cal.CS0(10:end))
plot(trial3_Cal.CS0(10:end))
legend('Trial 1','Trial 2','Trial 3')


figure(2)
plot(trial1_Cal.CS1(10:end))
title('5th MTP')
hold on
plot(trial2_Cal.CS1(10:end))
plot(trial3_Cal.CS1(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure(3)
plot(trial1_Cal.CS4(10:end))
title('Navicular')
hold on
plot(trial2_Cal.CS4(10:end))
plot(trial3_Cal.CS4(10:end))
legend('Trial 1','Trial 2','Trial 3')


figure(4)
plot(trial1_Cal.CS3(10:end))
title('1st MTP')
hold on
plot(trial2_Cal.CS3(10:end))
plot(trial3_Cal.CS3(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure(5)
plot(trial1_Cal.CS2(10:end))
title('5th distal phalanx')
hold on
plot(trial2_Cal.CS2(10:end))
plot(trial3_Cal.CS2(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure(6)
plot(trial1_Cal.CS5(10:end))
title('Calcaneous')
hold on
plot(trial2_Cal.CS5(10:end))
plot(trial3_Cal.CS5(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure(7)
plot(trial1_Cal.CS7(10:end))
title('Cuboid')
hold on
plot(trial2_Cal.CS7(10:end))
plot(trial3_Cal.CS7(10:end))
legend('Trial 1','Trial 2','Trial 3')

figure(10)
plot(trial1_Cal.CS6(10:end))
title('1st Distal Phalanx')
hold on
plot(trial2_Cal.CS6(10:end))
plot(trial3_Cal.CS6(10:end))
legend('Trial 1','Trial 2','Trial 3')