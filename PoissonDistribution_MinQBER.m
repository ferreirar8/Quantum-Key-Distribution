close all;
clear global;

data=10; %Number of photons
data2=data+1;


pn = linspace(0, data, data2);
n = 0.06;               % Dark counts per pulse
P = (n.^pn) .* exp(-n) ./ gamma(pn + 1);
n2 = 1;                 % Mean photon number per pulse
P2 = (n2.^pn) .* exp(-n2) ./ gamma(pn + 1);

figure('Name', 'Event Probability Distribution');

% Plot Poisson Distributions
h1 = semilogy(pn, P, 'o', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
h2 = semilogy(pn, P2, 'o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Number of Events Detected', 'FontWeight', 'bold', 'FontSize', 12);
ylabel('Probability', 'FontWeight', 'bold', 'FontSize', 12);
set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
grid on; grid minor;
legend([h1, h2], {['Dark counts per pulse, \mu_{d} = ' num2str(n)], ['Photon counts per pulse, \mu_{s} = ' num2str(n2)]}, 'FontSize', 11, 'Location', 'southwest');

empty=P(1)*P2(1)*100;
fprintf('No detection:%.3f%%\n', empty);

productArray2 = [];
%Probability of Higher count on detection
for i = 2:length(P2)
    for j = 1:(i-1)    
        product = P2(i) * P(j);
        productArray2 = [productArray2, product];  
    end
end
fprintf('Correct state detection:%.3f%%\n', sum(productArray2)*100);

productArray = [];
%Probability of Higher count on noise
for i = 2:length(P)
    for j = 1:(i-1)    
        product = P(i) * P2(j);
        productArray = [productArray, product];  
    end
end
fprintf('Wrong state detection:%.3f%%\n', sum(productArray)*100);

productArray3 = [];
%Probability of same counts on both detectors
for i = 2:length(P2)
        product = P2(i) * P(i);
        productArray3 = [productArray3, product]; 
end
fprintf('Same photon ratio:%.3f%%\n', sum(productArray3)*100);

Total=sum(productArray)*100+sum(productArray2)*100+sum(productArray3)*100+empty;
fprintf('Total:%.3f%%\n\n', Total);

MinQBER=100*(sum(productArray)*100)/(sum(productArray2)*100+sum(productArray)*100);
fprintf('Minimum QBER:%.3f%%\n\n', MinQBER);




