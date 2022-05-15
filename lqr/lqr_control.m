clear; clc; close all;
Mp = 0.027;  % (kg)
lp = 0.153;  % (m)
r = 0.0826;  % (m)
Jeq = 1.84e-4;  % (kg.m^2)
Jp = 1.70e-4;  % (kg.m^2)
g = 9.81;  % (m/s^2)

% syms theta1 theta2 s;
M = [
    Jeq + Mp * (r^2 + lp^2) + Jp, Mp * r * lp;  % cos(theta2)^2
    Mp * r * lp, Jp
];

S = [
    0.01, 0;
    0, 0.01
];

G = [
    0, 0;
    0, -Mp * g * lp
];

A = [
   zeros(2, 2), eye(2);
   -inv(M) * G, -inv(M) * S
];

B = [
    zeros(2, 1);
    inv(M) * [1; 0]
];

C = [
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
];

D = zeros(4, 1);

% Gs = [0, 1, 0, 0] * C * inv(s * eye(4) - A) * B;

% disp("M = "); disp(vpa(M, 5));
% disp("S = "); disp(vpa(S, 5));
% disp("G = "); disp(G);
% disp("A = "); disp(vpa(A, 5));
% disp("B = "); disp(vpa(B, 5));
% disp("C = "); disp(C);
% disp("G(s) = "); disp(vpa(Gs, 5));

Q = diag([1 1000 1 1]);
R = 10;

K = lqr(A, B, Q, R);
Ac = A - B * K;
Bc = B;
Cc = C;
Dc = D;

ss_ctl = ss(Ac, B, C, D);

t = 0 : 0.01 : 15;
x0 = [0.1, 0.1, 0, 0];
r = 0 * ones(size(t));

[y, tOut, x] = lsim(ss_ctl, r, t, x0);

%% 画图

subplot(4, 1, 1);
plot(t, x(:, 1), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\theta_1/rad$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);

subplot(4, 1, 2);
plot(t, x(:, 2), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\theta_2/rad$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);

subplot(4, 1, 3);
plot(t, x(:, 3), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\dot\theta_1/(rad/s)$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);

subplot(4, 1, 4);
plot(t, x(:, 4), 'linewidth', 2);
grid on;
grid minor;
xlabel('t/s');
title('$\dot\theta_2/(rad/s)$', 'interpreter', 'latex');
set(gca, 'fontname', 'times new roman', 'fontsize', 12);