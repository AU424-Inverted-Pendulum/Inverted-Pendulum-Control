clear; clc;
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

% For controller:
S_ctl = [
    0.01, 0;
    0, 0.01
];

% For real scenarios:
S_real = [
    0.01, 0;
    0, 0.01
];

G = [
    0, 0;
    0, -Mp * g * lp
];

A_real = [
   zeros(2, 2), eye(2);
   -inv(M) * G, -inv(M) * S_real
];

A_ctl = [
   zeros(2, 2), eye(2);
   -inv(M) * G, -inv(M) * S_ctl
];

B = [
    zeros(2, 1);
    inv(M) * [1; 0]
];

C = [
    0, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 0, 0;
    0, 0, 0, 0
];

D = zeros(4, 1);

Q = diag([1 10 1 1]);
R = 1;

K = lqr(A_ctl, B, Q, R);
x_dot = @(t, x) A_real * x + B * (-K * x);
[t, y] = ode45(x_dot, [0, 15], [0.1, 0.1, 0, 0]);
plot(t, y, 'LineWidth', 1.5);
legend('$\theta_1$', '$\theta_2$', '$\dot\theta_1$', '$\dot\theta_2$', 'interpreter', 'latex')