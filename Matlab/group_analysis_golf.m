%%%%%% Sensor 0: Tibia, 1: MTP 5, 2: M Malleolus, 3: Navicular, 4: MTP 1 %%
%%%%%% Sensor 5: Calcaneus, 6: lateral malleolus, 7: cuboid %%%%%%%%%%%%%%
%walk_dat = importfile('C:\Users\Daniel.Feeney\Desktop\SensoriaCode\SauconyPilot\df_x_in.CSsv');
clear
cd 'C:\Users\Daniel.Feeney\Desktop\SensoriaCode\AdidasGolfDD\walkin'
files = dir('*.csv');
longdata(1,1) = struct();
counter = 1;

for file = files'
    walk_dat = importfile(file.name);
    swing_trial = convRightVals(walk_dat, rightCal);
    
    clear pks_nav locs_nav pks_cub locs_cub pks_5mt locs_5mt pks_1mt locs_1mt pks_calc locs_calc

    [pks_nav, locs_nav] = findpeaks(swing_trial.CS3(10:end), 'MinPeakDistance',20);
    [pks_cub, locs_cub] = findpeaks(swing_trial.CS1(10:end), 'MinPeakDistance',20);
    [pks_5mt, locs_5mt] = findpeaks(swing_trial.CS1(10:end), 'MinPeakDistance',20);
    [pks_1mt, locs_1mt] = findpeaks(swing_trial.CS4(10:end), 'MinPeakDistance',20);
    [pks_calc, locs_calc] = findpeaks(waswing_triallk_dat.CS5(10:end), 'MinPeakDistance',20);
    
    % Outlier detection %
    pks_1mt = pks_1mt(pks_1mt > (0.55 * mean(pks_1mt)));
    pks_5mt = pks_5mt(pks_5mt > (0.55 * mean(pks_5mt)));
    pks_calc = pks_calc(pks_calc > (0.55 * mean(pks_calc)));
    pks_cub = pks_cub(pks_cub > (0.55 * mean(pks_cub)));
    
    %%%%% Calculate the averages, etc. %%%
    longdata(1).avg_nav{counter} = mean(pks_nav);
    longdata(1).avg_cub{counter} = mean(pks_cub);
    longdata(1).avg_5mt{counter} = mean(pks_5mt); 
    longdata(1).avg_1mt{counter} = mean(pks_1mt); 
    longdata(1).avg_heel{counter} = mean(pks_calc);
    longdata(1).cvHeel{counter} = (std(walk_dat.CS5(10:end)) / mean(walk_dat.CS5(10:end))) * 100;
    
    %%% Save TS data %%%
    longdata(1).locs{counter} = locs_calc;
    longdata(1).calc{counter} = walk_dat.CS5;
    longdata(1).mtp1{counter} = walk_dat.CS4;
    longdata(1).mtp5{counter} = walk_dat.CS1;
    longdata(1).nav{counter} = walk_dat.CS3;
    longdata(1).cub{counter} = walk_dat.CS7;

    longdata(1).pkCalc{counter} = pks_calc;
    longdata(1).pk5mt{counter} = pks_5mt;
    longdata(1).pk1mt{counter} = pks_1mt;
    longdata(1).pkCub{counter} = pks_cub;
    longdata(1).pkNav{counter} = pks_nav;
    
    counter = counter + 1;
end

%% Histograms of peak pressures
%%% First met head %%%
h1 = longdata.pk1mt{1,1}; %L
h2 = longdata.pk1mt{1,2}; %R
h3 = longdata.pk1mt{1,3}; %T
%%% Requires brewermap and histf (modified on line 112) in same folder
map = brewermap(3,'Set1'); 
figure(1)
histf(h1,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(1,:),'facealpha',.5,'edgecolor','none')
title('1st Met Histogram')
hold on
histf(h2,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(2,:),'facealpha',.5,'edgecolor','none')
histf(h3,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(3,:),'facealpha',.5,'edgecolor','none')
box off
axis tight
legend1 = sprintf('LR mu = %.3f', mean(h1));
legend2 = sprintf('Lace mu = %.3f', mean(h2));
legend3 = sprintf('Tri mu = %.3f', mean(h3));
legend({legend1, legend2, legend3});

%%%%% 5th met %%%%%
h1 = longdata.pk5mt{1,1}; %L
h2 = longdata.pk5mt{1,2}; %R
h3 = longdata.pk5mt{1,3}; %T
figure(2)
histf(h1,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(1,:),'facealpha',.5,'edgecolor','none')
title('5th Met Histograms')
hold on
histf(h2,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(2,:),'facealpha',.5,'edgecolor','none')
histf(h3,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(3,:),'facealpha',.5,'edgecolor','none')
box off
axis tight
legend1 = sprintf('LR mu = %.3f', mean(h1));
legend2 = sprintf('Lace mu = %.3f', mean(h2));
legend3 = sprintf('Tri mu = %.3f', mean(h3));
legend({legend1, legend2, legend3});

%%%%% Heel %%%%%
h1 = longdata.pkCalc{1,1}; %L
h2 = longdata.pkCalc{1,2}; %R
h3 = longdata.pkCalc{1,3}; %T
figure(3)
histf(h1,mean(h1)-10*std(h1):.5:mean(h1)+10*std(h1),'facecolor',map(1,:),'facealpha',.5,'edgecolor','none')
title('Calcaneous Histograms')
hold on
histf(h2,mean(h1)-10*std(h1):.5:mean(h1)+10*std(h1),'facecolor',map(2,:),'facealpha',.5,'edgecolor','none')
histf(h3,mean(h1)-10*std(h1):.5:mean(h1)+10*std(h1),'facecolor',map(3,:),'facealpha',.5,'edgecolor','none')
box off
axis tight
legend1 = sprintf('LR mu = %.3f', mean(h1));
legend2 = sprintf('Lace mu = %.3f', mean(h2));
legend3 = sprintf('Tri mu = %.3f', mean(h3));
legend({legend1, legend2, legend3});

%%%%% Cuboid %%%%%
h1 = longdata.pkCub{1,1}; %L
h2 = longdata.pkCub{1,2}; %R
h3 = longdata.pkCub{1,3}; %T
figure(4)
histf(h1,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(1,:),'facealpha',.5,'edgecolor','none')
title('Cuboid Histograms')
hold on
histf(h2,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(2,:),'facealpha',.5,'edgecolor','none')
histf(h3,mean(h1)-10*std(h1):.1:mean(h1)+10*std(h1),'facecolor',map(3,:),'facealpha',.5,'edgecolor','none')
box off
axis tight
legend1 = sprintf('LR mu = %.3f', mean(h1));
legend2 = sprintf('Lace mu = %.3f', mean(h2));
legend3 = sprintf('Tri mu = %.3f', mean(h3));
legend({legend1, legend2, legend3});


%%%% Bar plot with error bars for averages %%%%
vals = [longdata.avg_5mt{1}, longdata.avg_5mt{2}, longdata.avg_5mt{3}];
x = categorical({'LR','Lace','Tri'});
errHigh = [std(longdata.pk5mt{1,1}), std(longdata.pk5mt{1,2}), std(longdata.pk5mt{1,3})];

figure(5)
bar(x, vals)
title('5th Met')
ylabel('Peak Pressure (PSI)')
hold on
err = errorbar(x,vals,errHigh,errHigh);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

%%% Bar plot for first met
vals = [longdata.avg_1mt{1}, longdata.avg_1mt{2}, longdata.avg_1mt{3}];
x = categorical({'Hammer','Lace','Dual-Dial'});
errHigh = [std(longdata.pk1mt{1,1}), std(longdata.pk1mt{1,2}), std(longdata.pk1mt{1,3})];

figure(6)
bar(x, vals)
title('1st Met')
ylabel('Peak Pressure (PSI)')
hold on
err = errorbar(x,vals,errHigh,errHigh);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

%%% Bar plot for calcaneous 
vals = [longdata.avg_heel{1}, longdata.avg_heel{2}, longdata.avg_heel{3}];
x = categorical({'Hammer','Lace','Dual-Dial'});
errHigh = [std(longdata.pkCalc{1,1}), std(longdata.pkCalc{1,2}), std(longdata.pkCalc{1,3})];

figure(7)
bar(x, vals)
title('Calcaneous')
ylabel('Peak Pressure (PSI)')
hold on
err = errorbar(x,vals,errHigh,errHigh);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off