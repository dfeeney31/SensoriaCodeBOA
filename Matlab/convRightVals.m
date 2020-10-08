function convValues = convRightVals(data,calibData)
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

A0cal = 43333480; B0cal = 1.006716; C0cal = -47705.61; D0cal = 867.9985;
A1cal = 1.98*10^8; B1cal = 1.42; C1cal = -1.5*10^4; D1cal = 785.0005197;
A2cal = 5.01*10^9; B2cal = 1.95; C2cal = -1.14^4; D2cal = 781.0011045;
A3cal = 1.16*10^9; B3cal = 1.66; C3cal = -1.96*10^4; D3cal = 756.00000728;
A4cal = 9.66*10^8; B4cal = 1.851143; C4cal = -4763.286; D4cal = 735.9987463;
A5cal = 1.74*10^11; B5cal = 2.77; C5cal = -5.53*10^3; D5cal = 506.9997497;
A6cal = 2.81*10^13; B6cal = 3.68; C6cal = -2.6*10^3; D6cal = 533.9996174; 
A7cal = 4.85*10^8; B7cal = 1.59; C7cal = -1.57*10^4; D7cal = 677.0007279;


convValues.CS0 = (A0cal * ((data.S0(2:end) - (mean(calibData.S0(4:end)) - D0cal)).^-B0cal) + C0cal) * calFactor;
convValues.CS1 = (A1cal * ((data.S1(2:end) - (mean(calibData.S1(4:end)) - D1cal)).^-B1cal) + C1cal) * calFactor;
convValues.CS2 = (A2cal * ((data.S2(2:end) - (mean(calibData.S2(4:end)) - D2cal)).^-B2cal) + C2cal) * calFactor;
convValues.CS3 = (A3cal * ((data.S3(2:end) - (mean(calibData.S3(4:end)) - D3cal)).^-B3cal) + C3cal) * calFactor;
convValues.CS4 = (A4cal * ((data.S4(2:end) - (mean(calibData.S4(4:end)) - D4cal)).^-B4cal) + C4cal) * calFactor;
convValues.CS5 = (A5cal * ((data.S5(2:end) - (mean(calibData.S5(4:end)) - D5cal)).^-B5cal) + C5cal) * calFactor;
convValues.CS6 = (A6cal * ((data.S6(2:end) - (mean(calibData.S6(4:end)) - D6cal)).^-B6cal) + C6cal) * calFactor;
convValues.CS7 = (A7cal * ((data.S7(2:end) - (mean(calibData.S7(4:end)) - D7cal)).^-B7cal) + C7cal) * calFactor;



end

