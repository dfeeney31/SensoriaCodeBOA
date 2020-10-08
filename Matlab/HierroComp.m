clear
addpath('C:\Users\Daniel.Feeney\Desktop\SensoriaCode')  
%%%%% Instructions %%%%%
% Choose a subject below, and run code for them. Take the average peaks
% manually. This will move to automation once we have fully vetted the
% dynamic calibration (convLeftVals) works reliably. 

%% Devin testing
left_cal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\Devin\Devin_cal.csv');

V1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\Devin\Devin_DH_DD.csv'); 
DDcal = convLeftVals(V1, left_cal);
V2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\Devin\Devin_DH_SD.csv');
SDcal = convLeftVals(V2, left_cal);
V3 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\Devin\Devin_DH_DD.csv');
Lacecal = convLeftVals(V3, left_cal);

% Chad
left_cal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\CP\CP_cal.csv');

V1 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\CP\CP_DH_DD.csv'); 
DDcal = convLeftVals(V1, left_cal);
V2 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\CP\CP_DH_SD.csv');
SDcal = convLeftVals(V2, left_cal);
V3 = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\Trail Run Internal Pilot\TreadmillSensoria\CP\CP_DH_Lace.csv');
Lacecal = convLeftVals(V3, left_cal);

std(DDcal.CS5(50:end))
std(SDcal.CS5(50:end))
std(Lacecal.CS5(50:end))


%% look at reliable sensors to delimit strides

% V1
[pks_5lat, locs_5late] = findpeaks(DDcal.CS0(10:end), 'MinPeakDistance',20);
[pks_5mtp, locs_cub] = findpeaks(DDcal.CS1(10:end), 'MinPeakDistance',20);
[pks_5toe, locs_5mt] = findpeaks(DDcal.CS2(10:end), 'MinPeakDistance',20);
[pks_1mtp, locs_1mt] = findpeaks(DDcal.CS3(10:end), 'MinPeakDistance',20);
[pks_nav, locs_nav] = findpeaks(DDcal.CS4(10:end), 'MinPeakDistance',20);
[pks_calc, locs_calc] = findpeaks(DDcal.CS5(10:end), 'MinPeakDistance',20);
[pks_hallux, locs_1mt] = findpeaks(DDcal.CS6(10:end), 'MinPeakDistance',20);
[pks_cub, locs_cub] = findpeaks(DDcal.CS7(10:end), 'MinPeakDistance',20);

% V2
[pks_5lat2, locs_5late2] = findpeaks(SDcal.CS0(10:end), 'MinPeakDistance',20);
[pks_5mtp2, locs_cub2] = findpeaks(SDcal.CS1(10:end), 'MinPeakDistance',20);
[pks_5toe2, locs_5mt2] = findpeaks(SDcal.CS2(10:end), 'MinPeakDistance',20);
[pks_1mtp2, locs_1mt2] = findpeaks(SDcal.CS3(10:end), 'MinPeakDistance',20);
[pks_nav2, locs_nav2] = findpeaks(SDcal.CS4(10:end), 'MinPeakDistance',20);
[pks_calc2, locs_calc2] = findpeaks(SDcal.CS5(10:end), 'MinPeakDistance',20);
[pks_hallux2, locs_1mt2] = findpeaks(SDcal.CS6(10:end), 'MinPeakDistance',20);
[pks_cub2, locs_cub2] = findpeaks(SDcal.CS7(10:end), 'MinPeakDistance',20);

% V3
[pks_5lat3, locs_5late3] = findpeaks(Lacecal.CS0(10:end), 'MinPeakDistance',20);
[pks_5mtp3, locs_cub3] = findpeaks(Lacecal.CS1(10:end), 'MinPeakDistance',20);
[pks_5toe3, locs_5mt3] = findpeaks(Lacecal.CS2(10:end), 'MinPeakDistance',20);
[pks_1mtp3, locs_1mt3] = findpeaks(Lacecal.CS3(10:end), 'MinPeakDistance',20);
[pks_nav3, locs_nav3] = findpeaks(Lacecal.CS4(10:end), 'MinPeakDistance',20);
[pks_calc3, locs_calc3] = findpeaks(Lacecal.CS5(10:end), 'MinPeakDistance',20);
[pks_hallux3, locs_1mt3] = findpeaks(Lacecal.CS6(10:end), 'MinPeakDistance',20);
[pks_cub3, locs_cub3] = findpeaks(Lacecal.CS7(10:end), 'MinPeakDistance',20);


%% Delimit strides to plot mean
len = 15;
for i = 2:10
    try
        calc_v1(i,:) = DDcal.CS5(floor(locs_calc(i)-len):floor(locs_calc(i)+len));
        calc_v2(i,:) = SDcal.CS5(floor(locs_calc2(i)-len):floor(locs_calc2(i)+len));
        calc_v3(i,:) = Lacecal.CS5(floor(locs_calc3(i)-len):floor(locs_calc3(i)+len));
        
        
        nav_v1(i,:) = DDcal.CS4(floor(locs_nav(i)-len):floor(locs_nav(i)+len));
        nav_v2(i,:) = SDcal.CS4(floor(locs_nav2(i)-len):floor(locs_nav2(i)+len));
        nav_v3(i,:) = Lacecal.CS4(floor(locs_nav3(i)-len):floor(locs_nav3(i)+len));
        
        mtp1_v1(i,:) = DDcal.CS3(floor(locs_nav(i)-len):floor(locs_nav(i)+len));
        mtp1_v2(i,:) = SDcal.CS3(floor(locs_nav2(i)-len):floor(locs_nav2(i)+len));
        mtp1_v3(i,:) = Lacecal.CS3(floor(locs_nav3(i)-len):floor(locs_nav3(i)+len));
        
        mtp5_v1(i,:) = DDcal.CS1(floor(locs_nav(i)-len):floor(locs_nav(i)+len));
        mtp5_v2(i,:) = SDcal.CS1(floor(locs_nav2(i)-len):floor(locs_nav2(i)+len));
        mtp5_v3(i,:) = Lacecal.CS1(floor(locs_nav2(i)-len):floor(locs_nav2(i)+len));
        
        toe5_v1(i,:) = DDcal.CS2(floor(locs_nav(i)-len):floor(locs_nav(i)+len));
        toe5_v2(i,:) = SDcal.CS2(floor(locs_nav2(i)-len):floor(locs_nav2(i)+len));
        toe5_v3(i,:) = Lacecal.CS2(floor(locs_nav3(i)-len):floor(locs_nav3(i)+len));
        
        toe1_v1(i,:) = DDcal.CS6(floor(locs_nav(i)-len):floor(locs_nav(i)+len));
        toe1_v2(i,:) = SDcal.CS6(floor(locs_nav2(i)-len):floor(locs_nav2(i)+len));
        toe1_v3(i,:) = Lacecal.CS6(floor(locs_nav3(i)-len):floor(locs_nav3(i)+len));
        
        
        %except
        %pass
    end
end

%% Plotting ensemble average data. 
plot(mean(calc_v1,1))
hold on
plot(mean(calc_v2,1))
plot(mean(calc_v3,1))
xlabel('Time(1/33)s','FontSize',14,'FontWeight','bold')
ylabel('Pressure (PSI)','FontSize',14,'FontWeight','bold')
title('Heel Pressure')
legend('DD','SD','Lace')

std(calc_v1')

plot(mean(nav_v1,1))
hold on
plot(mean(nav_v2,1))
plot(mean(nav_v3,1))
xlabel('Time(1/33)s','FontSize',14,'FontWeight','bold')
ylabel('Pressure (PSI)','FontSize',14,'FontWeight','bold')
title('Navicular Pressure')
legend('DD','SD','Lace')

plot(mean(mtp1_v1,1))
hold on
plot(mean(mtp1_v2,1))
plot(mean(mtp1_v3,1))
xlabel('Time(1/33)s','FontSize',14,'FontWeight','bold')
ylabel('Pressure (PSI)','FontSize',14,'FontWeight','bold')
title('MTP1 Pressure')
legend('DD','SD','Lace')

plot(mean(mtp5_v1,1))
hold on
plot(mean(mtp5_v2,1))
plot(mean(mtp5_v3,1))
xlabel('Time(1/33)s','FontSize',14,'FontWeight','bold')
ylabel('Pressure (PSI)','FontSize',14,'FontWeight','bold')
title('MTP5 Pressure')
legend('DD','SD','Lace')

plot(mean(toe5_v1,1) + 20)
hold on
plot(mean(toe5_v2,1) + 20)
plot(mean(toe5_v3,1) + 20)
xlabel('Time(1/33)s','FontSize',14,'FontWeight','bold')
ylabel('Pressure (PSI)','FontSize',14,'FontWeight','bold')
title('5th Toe Pressure')
legend('DD','SD','Lace')


plot(mean(toe1_v1,1) + 20)
hold on
plot(mean(toe1_v2,1) + 20)
plot(mean(toe1_v3,1) + 20)
xlabel('Time(1/33)s','FontSize',14,'FontWeight','bold')
ylabel('Pressure (PSI)','FontSize',14,'FontWeight','bold')
title('1st Toe Pressure')
legend('DD','SD','Lace')
