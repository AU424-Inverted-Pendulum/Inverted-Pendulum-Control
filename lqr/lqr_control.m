clear; clc; close all;
A = [
    0,      0,      1.0,   0;
    0,      0,        0, 1.0;
    0, 77.298, -0.57145,   0;
    0, 83.413, -0.24312,   0;
];

B = [
         0;
         0;
    17.161;
    7.3008;   
];

C = eye(4);
D = zeros(4, 1);

Q = diag([1 100 1 1]);
R = 10;

K = lqr(A, B, Q, R);
Ac = A - B * K;
Bc = B;
Cc = C;
Dc = D;

ss_ctl = ss(Ac, B, C, D);

t = 0 : 0.01 : 10;
x0 = [0.1, 0.1, 0, 0];
r = zeros(size(t));

[y, tOut, x] = lsim(ss_ctl, r, t, x0);

%% 画图

plot(t, x, 'LineWidth', 1.5);
xlabel('t/s');
title('Realistic LQR Controller', 'FontSize', 15);
l = legend('$\theta_1$', '$\theta_2$', '$\dot\theta_1$', '$\dot\theta_2$', 'interpreter', 'latex');
set(gca, 'FontSize', 15,'Fontname', 'Times New Roman');
set(l, 'FontName', 'Times New Roman', 'FontSize', 15, 'FontWeight', 'normal');

% figure
% subplot(4, 1, 1);
% plot(t, x(:, 1), 'linewidth', 2);
% grid on;
% grid minor;
% xlabel('t/s');
% title('$\theta_1/rad$', 'interpreter', 'latex');
% set(gca, 'fontname', 'times new roman', 'fontsize', 12);
% 
% subplot(4, 1, 2);
% plot(t, x(:, 2), 'linewidth', 2);
% grid on;
% grid minor;
% xlabel('t/s');
% title('$\theta_2/rad$', 'interpreter', 'latex');
% set(gca, 'fontname', 'times new roman', 'fontsize', 12);
% 
% subplot(4, 1, 3);
% plot(t, x(:, 3), 'linewidth', 2);
% grid on;
% grid minor;
% xlabel('t/s');
% title('$\dot\theta_1/(rad/s)$', 'interpreter', 'latex');
% set(gca, 'fontname', 'times new roman', 'fontsize', 12);
% 
% subplot(4, 1, 4);
% plot(t, x(:, 4), 'linewidth', 2);
% grid on;
% grid minor;
% xlabel('t/s');
% title('$\dot\theta_2/(rad/s)$', 'interpreter', 'latex');
% set(gca, 'fontname', 'times new roman', 'fontsize', 12);