clear; clc; close all;

C = eye(4);

x_store = [];
x0 = [0.1; 0.1; 0; 0];
dt = 0.01;
t = 0:dt:15;

for t0 = t
    u = tracker_control(x0, @(t) 0.3 * t, t0);
    [~, x] = ode45(@(t, x) ode_func(t, x, u), [t0, t0 + dt], x0);
    x0 = x(end, :)';
    x_store = [x_store, x0];
end

plot(t, x_store, 'LineWidth', 1.5);
xlabel('t/s');
title('LQR Tracker', 'FontSize', 15);
l = legend('$\theta_1$', '$\theta_2$', '$\dot\theta_1$', '$\dot\theta_2$', 'interpreter', 'latex');
set(gca, 'FontSize', 15,'Fontname', 'Times New Roman');
set(l, 'FontName', 'Times New Roman', 'FontSize', 15, 'FontWeight', 'normal');