clear all;
GainI = -3;
GainVdc = 82; 
OffsetVdc = -2.1;
GainIpince = 10; % 0.1V / 1A
OffsetI1 = -0.18; 
OffsetI2 = -0.22; 
OffsetI3 = 0; % Offset sonde compensé mécaniquement 
% DATA PV
G = 1000;       
R = 10;         
Icc = 8.5;      
Vco = 37;
n = 1.3;
Vt = 0.026;
Ns = 60;
T=25;
Te = 0.1;
Qnom = 300;
