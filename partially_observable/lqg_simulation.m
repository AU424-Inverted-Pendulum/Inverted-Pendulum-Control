clear; clc; close all;

x = [0.1; 0.01; 0; 0];
x_store = [];

x_kf = x;
P_kf = 0.001 * eye(4); 
x_kf_store = [];

dt = 0.001;
t = 0:dt:15;

C = [
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 0, 0;
    0, 0, 0, 0;
];

Q = 1e-8 * eye(4);

R = 1e-8 * eye(4);

for t0 = t
    u = lqg_control(x_kf, @(t) 0.3 * t, t0);
    
    [x_kf, P_kf] = KF_pred(x_kf, P_kf, u, Q);
    x_noise = mvnrnd([0; 0; 0; 0;], Q, 1)';
    
    x = ode_func_d(x, u, x_noise); 
    x_store = [x_store, x];
     
    y_noise = mvnrnd([0; 0; 0; 0;], R, 1)';
    y = C * x + y_noise;
    [x_kf, P_kf] = KF_update(x_kf, P_kf, y, R);
    x_kf_store = [x_kf_store x_kf];
end

plot(t, x_store, 'LineWidth', 1.5);
xlabel('t/s');
title("Partially Oberavable LQG Tracker");
l = legend('$\theta_1$', '$\theta_2$', '$\dot\theta_1$', '$\dot\theta_2$', 'interpreter', 'latex');
set(gca, 'FontSize', 15,'Fontname', 'Times New Roman');
set(l, 'FontName', 'Times New Roman', 'FontSize', 15, 'FontWeight', 'normal');

lp = 0.153;  % (m)
r = 0.0826;  % (m)
xp = r .* cos(x_store(1, :)) - lp .* sin(x_store(2, :)) .* sin(x_store(1, :));
yp = -r .* sin(x_store(1, :)) - lp .* sin(x_store(2, :)) .* cos(x_store(1, :));
zp = lp * cos(x_store(2, :));
figure;
plot3(xp, yp, zp, 'LineWidth', 2);
grid on;
zlim([0, 0.2]);
title("Partially Observable Pendulum End Trajectory with LQG Tracker");