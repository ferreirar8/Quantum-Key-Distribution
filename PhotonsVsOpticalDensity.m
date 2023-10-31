close all;
h = 6.626e-34;  % Planck's constant (m^2 kg / s)
c = 3e8;
lambda = 850e-9; % Photon's wavelength
eta = 0.5;      % SPCM efficiency
format long
syms Pdet_sym; %

fixed_loss_dB = 30; % Source-Detector Loss
P_incident = 2.38e-3; % Power emitted from source
Em_DLoss=17.72; % Emitter's Beam expander to Detector Loss
var_loss_dB_min = 0;  % Minimum variable loss in from neutral density filter
var_loss_dB_max = 100; % Maximum variable loss in from neutral density filter
n_points = 100;

var_loss_dB = linspace(var_loss_dB_min, var_loss_dB_max, n_points);
total_loss_dB = fixed_loss_dB + var_loss_dB;

total_loss_linear = 10.^(-total_loss_dB / 10);
P_effective = P_incident * total_loss_linear;
f = c / lambda;   
E_photon = h * f;   
N_photons = (P_effective / E_photon) * eta;

figure;
h = semilogy(var_loss_dB/10, N_photons/100000,'LineWidth',2, 'Color', [0 0 1]);
xlabel('Optical Density', 'FontWeight', 'bold', 'FontSize', 3);
ylabel('Number of Photons per Pulse', 'FontWeight', 'bold', 'FontSize', 3);
grid on;
grid minor;
set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth', 1.5);
annotation('textbox',[.2 .5 .3 .3],'String',['Fixed Loss: ', num2str(fixed_loss_dB), ' dB'],'FitBoxToText','on','BackgroundColor',[.9 .9 .9]);

target_photons = [10000, 50000, 100000, 300000];

variable_loss_for_targets = zeros(1, length(target_photons));
   %Calulate optical density needed
for i = 1:length(target_photons)
    P_required = (target_photons(i) * E_photon) / eta;
    total_loss_required_linear = P_required / P_incident;
    total_loss_required_dB = -10 * log10(total_loss_required_linear);
    variable_loss_for_targets(i) = total_loss_required_dB - fixed_loss_dB;
end

for i = 1:length(target_photons)
    fprintf('For %g photons per pulse, the optical density required is: %g\n', target_photons(i)/100000, variable_loss_for_targets(i)/10);
end

    % Calculate Power emitted
for i = 1:length(variable_loss_for_targets)
    Pdet_sym = vpa(P_effective(1) * (10^(-variable_loss_for_targets(i) / 10)), 50);
    Pdet_0(i) = double(Pdet_sym);
end

for i = 1:length(variable_loss_for_targets)
    P_after_gain = Pdet_0(i) * (10^(Em_DLoss / 10));
    N_photons_detector(i) = (P_after_gain / E_photon) * eta;
    fprintf('To achieve %g photons in the detector, an average of: %g photons are emitted from the source beam expander.\n',target_photons(i)/100000, N_photons_detector(i)/100000);
end