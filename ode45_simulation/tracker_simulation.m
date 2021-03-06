clear; clc; close all;

C = eye(4);

x_store = [];
x0 = [0.1; 0.1; 0; 0];
dt = 0.001;
t = 0:dt:20;

for t0 = t
    u = tracker_control(x0, @(t) 0.3 * t, t0);
    noise = mvnrnd([0; 0; 0; 0;], 5e-3 * eye(4), 1)';
    [~, x] = ode45(@(t, x) ode_func(t, x, u, noise), [t0, t0 + dt], x0);
    x0 = x(end, :)';
    x_store = [x_store, x0];
end

plot(t, x_store, 'LineWidth', 1.5);
xlabel('t/s');
title('LQR Tracker', 'FontSize', 15);
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
title("Pendulum End Trajectory with LQR Tracker");