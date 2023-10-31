close all;
clear all;

% Create an array of alpha values for 5-degree intervals from 0 to 90 degrees
alpha_degrees = 0:5:90;
alpha = deg2rad(alpha_degrees);

figure('Name', 'QBER vs. Beta Angle');
% Calculate QBER
errH = sin((pi/4) - (alpha/2)).^2;
errV = cos((pi/4) + (alpha/2)).^2;
QBER2 = (0.5 * errH) + (0.5 * errV);

% Plot Data
h = plot(alpha_degrees, QBER2, 'o-', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0 0 1]);

xlabel('\beta Angle [\circ]', 'FontWeight', 'bold', 'FontSize', 10);
ylabel('QBER [%]', 'FontWeight', 'bold', 'FontSize', 10);
set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
grid on; grid minor;

