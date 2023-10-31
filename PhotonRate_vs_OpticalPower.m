clear all; clc;
min=1e-21;
max=1e-11;

P = linspace(min, max, 1000); % Optical power Wwatts
photonRateFactor = 5.03e15 * 850; % Constant term in photon rate equation
N = photonRateFactor * P;

h = loglog(P, N, 'LineWidth', 2, 'Color', [0 0 1]);
grid on; hold on;
xlim([min,max]);
xlabel('Optical power [W]', 'FontSize', 20, 'FontWeight', 'bold');
ylabel('Photon rate [Hz]', 'FontSize', 20, 'FontWeight', 'bold');
set(gca, 'FontSize', 10, 'FontWeight', 'bold', 'LineWidth', 1.5);
grid on;
grid minor;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.5);