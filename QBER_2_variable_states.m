close all;
clear all;

% Create an array of alpha values for 10-degree intervals from 0 to 90 degrees
alpha_degrees = 0:20:90;
alpha_radians = deg2rad(alpha_degrees);

% Initialize arrays to store QBER values for each alpha
QBER = zeros(length(alpha_degrees), 1);

% Create a figure for the plot
figure;

% Initialize a cell array to store legend labels
legend_labels = cell(length(alpha_degrees), 1);

for i = 1:length(alpha_degrees)
    alpha = alpha_radians(i);
    
    % Create an array of angles for errD from alpha to 90 degrees in 10-degree intervals
    errD_alpha_to_90 = alpha:deg2rad(10):pi/2;
    errH = (sin(alpha)^2);
    errD = cos(errD_alpha_to_90).^2;
    % Calculate QBER for the current alpha and errD_alpha_to_90 values
    QBER_current = 0.5 * (errH) + (0.5 * errD);
    
    % Plot errD_alpha_to_90 against QBER for the current alpha with a unique color
    plot(rad2deg(errD_alpha_to_90), QBER_current, 'o-');
    hold on;
    
    % Store the legend label for this alpha
    legend_labels{i} = ['Angle of first state = ', num2str(alpha_degrees(i)), '^\circ'];
end

grid on;
xlabel('Angle of Second State [\circ]');
ylabel('QBER');
%title('QBER vs. Angle for Different Alpha Values');
legend(legend_labels, 'Location', 'Best');
