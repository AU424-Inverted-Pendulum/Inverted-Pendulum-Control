clear; clc;
A = [
    0,       0,     1.0,       0;
    0,       0,       0,     1.0;
    0, -167.59, -20.603,  41.354;
    0,  574.76,  41.354, -141.83;
];

B = [
          0;
          0;
     2060.3;
    -4135.4;
];

C = eye(4);

D = zeros(4, 4);

Q = diag([1 100 1 1]);
R = diag(1e10);

[P, ~, ~] = care(A, B, Q, R);

Ac = A - B * inv(R) * B' * P;
Bc = - B * inv(R) * B' * inv((B * inv(R) * B' * P - A)') * C' * Q;

ss_ctl = ss(Ac, Bc, C, D);

t = 0 : 0.01 : 50;
x0 = [0.5, 0.7, 0, 0];
r = [
    0.5 * sin(t);
    zeros(size(t));
    zeros(size(t));
    zeros(size(t));
];

[y, tOut, x] = lsim(ss_ctl, r, t, x0);

%% 画图

subplot(4, 1, 1);
plot(tOut, x(:, 1), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\theta_1/rad$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);

subplot(4, 1, 2);
plot(tOut, x(:, 2), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\theta_2/rad$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);

subplot(4, 1, 3);
plot(tOut, x(:, 3), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\dot\theta_1/(rad/s)$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);

subplot(4, 1, 4);
plot(tOut, x(:, 4), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\dot\theta_2/(rad/s)$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);