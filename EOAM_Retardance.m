% Create a figure and set its size and background
figure('Position', [100, 100, 900, 700], 'Color', 'white');

% Define the data
x = linspace(0, 300, 300); % Applied Voltage
y = pi * x / 283; % Retardance

% Plot the data
plot(x, y, 'LineWidth', 3, 'Color', [0 0.4470 0.7410]); % MATLAB's default blue color

% Set y-axis ticks and labels
yticks([pi/4, pi/2, 3*pi/4, pi]);
yticklabels({'\pi/4', '\pi/2', '3\pi/4', '\pi'});

% Set x-axis and y-axis limits
xlim([0 283]);
ylim([0 pi]);

% Labeling the axes with larger fonts
xlabel('Applied Voltage [V]', 'FontSize', 16, 'FontName', 'Arial');
ylabel('Retardance [rad]', 'FontSize', 16, 'FontName', 'Arial');

% Display subtle grid
grid on;

set(gca, 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 1.8); % Increase font size and line width for axes

% Grid Configuration
grid on;
grid minor;
set(gca, 'GridLineStyle', '--'); % Set grid line style
set(gca, 'GridAlpha', 0.5); % Set grid line transparency

% print('figure_name', '-dpng', '-r300');  % Uncomment to save

% Display the plot
hold off;

