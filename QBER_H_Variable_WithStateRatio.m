close all;
clear all;

alpha = linspace(0,pi/4,1000);
errH = (sin(alpha)).^2;
errD = (cos(alpha+(pi/4))).^2;

QBER = (0.9*errH) + (0.1*errD);

alpha_degrees = rad2deg(alpha);

plot(alpha_degrees, QBER);
grid on;
hold on;
xlabel('Alpha [\circ]');
ylabel('QBER');
title('QBER vs. Alpha');
hold on;

[minErr, minIndex] = min(QBER);
minAlphaDegrees = alpha_degrees(minIndex);

fprintf('Minimum value of QBER: %f\n %%', minErr*100);
fprintf('Corresponding Alpha (degrees): %f\n', minAlphaDegrees);
