n_values = linspace(0.01, 0.2, 20);  % Array for dark counts per pulse
n2_values = linspace(0.1, 5, 20);  % Array for mean photon number per pulse
MinQBER_matrix = zeros(length(n_values), length(n2_values)); 


for i = 1:length(n_values)
    n = n_values(i);
    
    for j = 1:length(n2_values)
        n2 = n2_values(j);

        data = 75; 
        data2 = data + 1;
        pn = linspace(0, data, data2);

        P = (n.^pn) .* exp(-n) ./ factorial(pn);
        P2 = (n2.^pn) .* exp(-n2) ./ factorial(pn);

        productArray = [];
        productArray2 = [];

        % Probability of Higher count due to noise
        for k = 2:length(P)
            for l = 1:(k-1)
                product = P(k) * P2(l);
                productArray = [productArray, product];
            end
        end

        % Probability of Higher count on detection
        for k = 2:length(P2)
            for l = 1:(k-1)
                product = P2(k) * P(l);
                productArray2 = [productArray2, product];
            end
        end

        % Calculate MinQBER
        MinQBER = 100 * sum(productArray) / (sum(productArray) + sum(productArray2));
        
        % Store MinQBER in matrix
        MinQBER_matrix(i, j) = MinQBER;
    end
end

% Generate MinQBER plot with enhanced aesthetics suitable for publication
figure('Renderer', 'painters', 'Position', [10 10 800 600]);
surf(n_values, n2_values, MinQBER_matrix', 'EdgeColor', 'k', 'FaceAlpha', 0.7);
xlabel('$\mu_{d}$ (Average dark counts per pulse)', 'Interpreter', 'latex', 'FontWeight', 'bold', 'FontSize', 18);
ylabel('$\mu_{s}$ (Average photon number per pulse)', 'Interpreter', 'latex', 'FontWeight', 'bold', 'FontSize', 18);
zlabel('Minimum QBER [%]', 'FontWeight', 'bold', 'FontSize', 18);
colorbar;
colormap jet;
grid on;
grid minor;
set(gca, 'FontSize', 16, 'FontWeight', 'bold', 'LineWidth', 1.5);
view(30, 30);
