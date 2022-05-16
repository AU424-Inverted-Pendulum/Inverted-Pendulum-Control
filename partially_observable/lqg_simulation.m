clear; clc; close all;

x_store = [];
x0 = [0.1; 0.01; 0; 0];
x_kf = x0;
P_kf = 0.001 * eye(4); 
dt = 0.001;
t = 0:dt:5;

C = [
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 0, 0;
    0, 0, 0, 0;
];
y = C * x0;

Q_ = 0.001 * randn(4, 4);
Q = Q_ * Q_'; %控制噪声协方差矩阵 
Q = 0.001 * eye(4);
R_ = 0.001 * randn(4, 4);
R = R_ * R_'; %观测噪声协方差矩阵
R = 0.001 * eye(4);

for t0 = t
    u = lqg_control(x_kf, @(t) 0.0 * t, t0);

    [x_kf, P_kf] = KF_pred(x_kf, P_kf, u, Q);
    [x_kf, P_kf] = KF_update(x_kf, P_kf, y, R);
    
    [~, x] = ode45(@(t, x) ode_func_lqg(t, x, u), [t0, t0 + dt], x0);
    x0 = x(end, :)';
    y = x0 + 0.00001 * mvnrnd([0; 0; 0; 0], R, 1)';
    x_store = [x_store, x0];
end

plot(t, x_store, 'LineWidth', 1.5);
xlabel('t/s');
title("Partially Oberavable LQG Tracker");
l = legend('$\theta_1$', '$\theta_2$', '$\dot\theta_1$', '$\dot\theta_2$', 'interpreter', 'latex');
set(gca, 'FontSize', 15,'Fontname', 'Times New Roman');
set(l, 'FontName', 'Times New Roman', 'FontSize', 15, 'FontWeight', 'normal');