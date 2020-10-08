clear
cd 'C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\Sept19 Testing\DF'; %Change this line to the subject folder
files = dir('*.csv');
longdata(1,1) = struct();
counter = 1;
addpath('C:\Users\Daniel.Feeney\Desktop\SensoriaCode')  
leftCal = importfile('C:\Users\Daniel.Feeney\Dropbox (Boa)\SensoriaFolder\Sept19 Testing\RawFiles\LeftCal.csv');

for file = files'
    walk_dat = importfile(file.name);
    walk_trial = convLeftVals(walk_dat, leftCal);
    
    clear pks_nav locs_nav pks_cub locs_cub pks_5mt locs_5mt pks_1mt locs_1mt pks_calc locs_calc

    %0: Lat 5th side, 1: 5th MTP, 2: 5th toe, 3:1st MTP, 4: navicular, 5:
    %calcaneous, 6: Hallux, 7: Cuboid
    
    [pks_5lat, locs_nav] = findpeaks(walk_trial.CS0(10:end), 'MinPeakDistance',20, 'MinPeakHeight',5);
    [pks_5mtp, locs_cub] = findpeaks(walk_trial.CS1(10:end), 'MinPeakDistance',20, 'MinPeakHeight',5);
    [pks_5toe, locs_5mt] = findpeaks(walk_trial.CS2(10:end), 'MinPeakDistance',20, 'MinPeakHeight',5);
    [pks_1mtp, locs_1mt] = findpeaks(walk_trial.CS3(10:end), 'MinPeakDistance',20, 'MinPeakHeight',5);
    [pks_nav, locs_nav] = findpeaks(walk_trial.CS4(10:end), 'MinPeakDistance',20, 'MinPeakheight',5);
    [pks_calc, locs_5mt] = findpeaks(walk_trial.CS5(10:end), 'MinPeakDistance',20, 'MinPeakHeight',5);
    [pks_hallux, locs_1mt] = findpeaks(walk_trial.CS6(10:end), 'MinPeakDistance',20, 'MinPeakHeight',5);
    [pks_cub, locs_calc] = findpeaks(walk_trial.CS7(10:end), 'MinPeakDistance',20, 'MinPeakheight',5);
    
    % Outlier detection %
    pks_1mtp = pks_1mtp(pks_1mtp > (0.55 * mean(pks_1mtp)));
    pks_5mtp = pks_5mtp(pks_5mtp > (0.55 * mean(pks_5mtp)));
    pks_calc = pks_calc(pks_calc > (0.55 * mean(pks_calc)));
    pks_nav = pks_nav(pks_nav > (0.55 * mean(pks_nav)));
    
    %%%%% Calculate the averages, etc. %%%
    longdata(1).avg_nav{counter} = mean(pks_nav);
    longdata(1).avg_cub{counter} = mean(pks_cub);
    longdata(1).avg_5mtp{counter} = mean(pks_5mtp); 
    longdata(1).avg_1mtp{counter} = mean(pks_1mtp); 
    longdata(1).avg_heel{counter} = mean(pks_calc);
    longdata(1).cvHeel{counter} = (std(walk_dat.CS5(10:end)) / mean(walk_dat.CS5(10:end))) * 100;
    
    %%% Save TS data %%%
    longdata(1).locs{counter} = locs_calc;
    longdata(1).calc{counter} = walk_dat.CS5;
    longdata(1).mtp1{counter} = walk_dat.CS4;
    longdata(1).mtp5{counter} = walk_dat.CS1;
    longdata(1).nav{counter} = walk_dat.CS4;
    longdata(1).cub{counter} = walk_dat.CS7;

    longdata(1).pkCalc{counter} = pks_calc;
    longdata(1).pk5mt{counter} = pks_5mtp;
    longdata(1).pk1mt{counter} = pks_1mtp;
    longdata(1).pkCub{counter} = pks_nav;
    longdata(1).pkNav{counter} = pks_nav;
    
    counter = counter + 1;
    
end

%%%% Bar plot with error bars for averages %%%%
%% 1st met head
vals = [longdata.avg_1mtp{2}, longdata.avg_1mtp{4}, longdata.avg_1mtp{6}, longdata.avg_1mtp{7}, longdata.avg_1mtp{8}];
x = categorical({'LR','Lace','Overlapping','Tri', 'X'});
errHigh = [std(longdata.pk1mt{1,2}), std(longdata.pk1mt{1,4}), std(longdata.pk1mt{1,6}), std(longdata.pk1mt{1,8}), std(longdata.pk1mt{1,8})];

figure(5)
bar(x, vals)
title('1st Met')
ylabel('Peak Pressure (PSI)')
hold on
err = errorbar(x,vals,errHigh,errHigh);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

%% Navicular
vals = [longdata.avg_nav{2}, longdata.avg_nav{4}, longdata.avg_nav{6}, longdata.avg_nav{7}, longdata.avg_nav{9}];
x = categorical({'LR','Lace','Overlapping','Tri', 'X'});
errHigh = [std(longdata.pkNav{1,2}), std(longdata.pkNav{1,4}), std(longdata.pkNav{1,6}), std(longdata.pkNav{1,7}), std(longdata.pkNav{1,9})];

figure(6)
bar(x, vals)
title('Navicular')
ylabel('Peak Pressure (PSI)')
hold on
err = errorbar(x,vals,errHigh,errHigh);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

%% Calcaneous
vals = [longdata.avg_heel{2}, longdata.avg_heel{4}, longdata.avg_heel{6}, longdata.avg_heel{7}, longdata.avg_heel{9}];
x = categorical({'LR','Lace','Overlapping','Tri', 'X'});
errHigh = [std(longdata.pkCub{1,2}), std(longdata.pkCub{1,4}), std(longdata.pkCub{1,6}), std(longdata.pkCub{1,7}), std(longdata.pkCub{1,9})];

figure(7)
bar(x, vals)
title('Calcaneous')
ylabel('Peak Pressure (PSI)')
hold on
err = errorbar(x,vals,errHigh,errHigh);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off

%% 5th met head
vals = [longdata.avg_5mtp{2}, longdata.avg_5mtp{4}, longdata.avg_5mtp{6}, longdata.avg_5mtp{7}, longdata.avg_5mtp{9}];
x = categorical({'LR','Lace','Overlapping','Tri', 'X'});
errHigh = [std(longdata.pk5mt{1,2}), std(longdata.pk5mt{1,4}), std(longdata.pk5mt{1,6}), std(longdata.pk5mt{1,7}), std(longdata.pk5mt{1,9})];

figure(8)
bar(x, vals)
title('5th Met Head')
ylabel('Peak Pressure (PSI)')
hold on
err = errorbar(x,vals,errHigh,errHigh);
err.Color = [0 0 0];
err.LineStyle = 'none';
hold off