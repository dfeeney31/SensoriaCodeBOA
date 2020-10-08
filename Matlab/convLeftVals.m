function convValues = convLeftVals(data,calibData)
%convLeftVals Convert the Sensoria values to the correct scale using a manual
%zero calibration. A,B,C,D all come from Sensoria calibration report.
%Manual calibration requires the subject wear the sock but put their foot
%in the air to create a new 0.
%This is based on the zeroing function: 
%Weight = A (X - (Xo - D))^(-B) + C where A,B,C, and D come from the
%Sensoria-provided calibration reports and Xo is the average of the sensor
%recordings during the zero calibration recording. The weight is multiplied
%by the scaling factor listed below as calFactor to convert to PSI.


% Hard code the baseline sensor data from Sensoria. 
calFactor = (2.20462262/1000)/0.196349148;            %Provided by Sensoria 

A0cal = 1.61*10^10; B0cal = 2.15; C0cal = -1.50*10^4; D0cal = 6.41*10^2;
A1cal = 2.30*10^9; B1cal = 1.89; C1cal = -1.03*10^4; D1cal = 6.86*10^2;
A2cal = 1.18*10^9; B2cal = 1.66; C2cal = -2.13*10^4; D2cal = 7.29*10^2;
A3cal = 8.42*10^9; B3cal = 1.99; C3cal = -1.65*10^4; D3cal = 7.43*10^2;
A4cal = 1.54*10^9; B4cal = 1.72; C4cal = -1.82*10^4; D4cal = 7.21*10^2;
A5cal = 6.27*10^12; B5cal = 3.13; C5cal = -8.43*10^3; D5cal = 6.76*10^2;
A6cal = 3.94*10^10; B6cal = 2.31; C6cal = -1.38*10^4; D6cal = 6.27*10^2; 
A7cal = 1.51*10^9; B7cal = 1.57; C7cal = -3.99*10^4; D7cal = 8.41*10^2;


convValues.CS0 = (A0cal * ((data.S0(2:end) - (mean(calibData.S0(30:50)) - D0cal)).^-B0cal) + C0cal) * calFactor;
convValues.CS1 = (A1cal * ((data.S1(2:end) - (mean(calibData.S1(30:50)) - D1cal)).^-B1cal) + C1cal) * calFactor;
convValues.CS2 = (A2cal * ((data.S2(2:end) - (mean(calibData.S2(30:50)) - D2cal)).^-B2cal) + C2cal) * calFactor;
convValues.CS3 = (A3cal * ((data.S3(2:end) - (mean(calibData.S3(30:50)) - D3cal)).^-B3cal) + C3cal) * calFactor;
convValues.CS4 = (A4cal * ((data.S4(2:end) - (mean(calibData.S4(30:50)) - D4cal)).^-B4cal) + C4cal) * calFactor;
convValues.CS5 = (A5cal * ((data.S5(2:end) - (mean(calibData.S5(30:50)) - D5cal)).^-B5cal) + C5cal) * calFactor;
convValues.CS6 = (A6cal * ((data.S6(2:end) - (mean(calibData.S6(30:50)) - D6cal)).^-B6cal) + C6cal) * calFactor;
convValues.CS7 = (A7cal * ((data.S7(2:end) - (mean(calibData.S7(30:50)) - D7cal)).^-B7cal) + C7cal) * calFactor;


end

