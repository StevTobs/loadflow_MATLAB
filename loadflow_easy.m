clc;
clear;
v1 = 1.02 + 0j; %fixed voltage regulator

v4 = 1 + 0j; % Guess...
v2 = 1 + 0j; % Guess...

y12 = 0 - 2j; % z = j0.5
y24 = 0 - 2j; % z = j0.5
y12 = -y12;
y24 = -y24;
y22 = y12 + y24;

s = -1.0 + 0j;

for indx = 1:10
    
    v2 = 1 / y22 * ( (s /conj(v2) ) - y12*v1 - y24*v4);
    
    v2m = abs(v2);
    v2a = angle(v2) * 360 / (2*pi);
    
    formatSpec = 'v2 = %6.4f + j%6.4f Mag = %6.4f Ang = %6.4f \n';
    fprintf( formatSpec, real(v2), imag(v2), v2m, v2a );
    
end

v2_final = v2;

v4 = 1 + 0j; % Guess...
v2 = 1 + 0j; % Guess...
% This is not finish yet....
