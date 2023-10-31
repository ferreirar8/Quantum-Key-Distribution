D2 = 2078.5e-6; % Replace with actual value for beam diameter at 120 cm
D1 = 1094.9e-6; % Replace with actual value for beam diameter at 30 cm
z1 = 30e-2;  % Distance in cm
z2 = 120e-2; % Distance in cm

theta_mrad = 2*atan((D2 - D1) / ((z2 - z1)*2)); 

fprintf('The beam divergence angle is %.4f milliradians.\n', theta_mrad*1000);
