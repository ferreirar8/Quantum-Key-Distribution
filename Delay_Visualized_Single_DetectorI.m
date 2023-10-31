close all;
clear all;

data = readtable('HDAdelay.txt', 'Delimiter', '|', 'HeaderLines', 2, 'ReadVariableNames', false);
channel = data.Var2;
timestamp = data.Var3;
events = numel(channel);

begin = false;
freq = 0;
fot1 = 0;
fot2 = 0;
ch1_delay = [];
ch2_delay = [];
delayH = [];
delayV = [];
eventosH = [];
eventosV= [];
% Save delay values to ch1_delay and ch2_delay
for i = 1:events
    if channel(i) == 4
        if fot1 > 0 || fot2 > 0 
            ch1_delay(end+1) = mean(delayH);
            ch2_delay(end+1) = mean(delayV);
            eventosH(end+1) = fot1;
            eventosV(end+1) = fot2;
        end
        freq = freq + 1;
        begin = true;
        start_time = timestamp(i);
        delayH = [];
        delayV = [];
        fot1 = 0;
        fot2 = 0;
    elseif begin && channel(i) == 1
        delay1 = timestamp(i) - start_time;
        delayH(end+1) = delay1;
        fot1 = fot1 + 1;
    elseif begin && channel(i) == 2
        delay2 = timestamp(i) - start_time;
        delayV(end+1) = delay2;
        fot2 = fot2 + 1;
    end
end

fprintf('Average fotons for H detection: %.2f, Standard deviation: %.2f\n', mean(eventosH), std(eventosH));
fprintf('Average fotons for V or D detection: %.2f, Standard deviation: %.2f\n', mean(eventosV), std(eventosV));

% Bimodal Distribution Fit
num_components = 2;
gm = fitgmdist(ch1_delay', num_components);
means = gm.mu;
std_devs = sqrt(gm.Sigma);
[means, idx] = sort(means);
std_devs = std_devs(idx);
disp(['Average of Gaussian 1: ', num2str(means(1))]);
disp(['Standard Deviation of Gaussian 1: ', num2str(std_devs(1))]);
fprintf('\n');
disp(['Average of Gaussian 2: ', num2str(means(2))]);
disp(['Standard Deviation of Gaussian 2: ', num2str(std_devs(2))]);
fprintf('\n');


% Initialize Figure
figure('Renderer', 'painters', 'Position', [10 10 1000 600]);
h = histogram(ch1_delay/1e6, 'BinWidth', .8, 'FaceColor', [0.2 0.4 0.8], 'Normalization', 'Probability', 'EdgeColor', 'black', 'HandleVisibility', 'off');
hold on;

% Extract histogram properties
binEdges = h.BinEdges;
binCenters = (binEdges(1:end-1) + binEdges(2:end)) / 2;
binValues = h.Values;

% Find the bins closest to the Gaussian means
[~, idx1] = min(abs(binCenters - means(1)/1e6));
[~, idx2] = min(abs(binCenters - means(2)/1e6));

% Retrieve peak values
peak_value1 = binValues(idx1);
peak_value2 = binValues(idx2);

% Generate Gaussian PDFs
x_range = linspace(min(ch1_delay)/1e6, max(ch1_delay)/1e6, 1000);
pdf1 = normpdf(x_range, means(1)/1e6, std_devs(1)/1e6);
pdf2 = normpdf(x_range, means(2)/1e6, std_devs(2)/1e6); 

% Scale PDFs to match histogram peaks
pdf1 = pdf1 * peak_value1 / max(pdf1);
pdf2 = pdf2 * peak_value2 / max(pdf2);

plot(x_range, pdf1, 'LineWidth', 3, 'Color', "#00FF00", 'DisplayName', 'Vertical pol. Gaussian');
plot(x_range, pdf2, 'LineWidth', 3, 'Color', 'red', 'DisplayName', 'Diagonal pol. Gaussian');

xline(means(1)/1e6, '--k', 'HandleVisibility', 'off','LineWidth', 2.5);
xline(means(2)/1e6, '--k', 'HandleVisibility', 'off','LineWidth', 2.5);

xlabel('Time bin [\mus]');
ylabel('Probability');
legend('show');
set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.4);
grid on;
grid minor;
set(gca, 'GridLineStyle', '--');
set(gca, 'GridAlpha', 0.3);
