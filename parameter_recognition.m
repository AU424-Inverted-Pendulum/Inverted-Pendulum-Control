clear; clc; close all;
Mp = 0.027;  % (kg)
lp = 0.153;  % (m)
r = 0.0826;  % (m)
Jeq = 1.84e-4;  % (kg.m^2)
Jp = 1.70e-4;  % (kg.m^2)
g = 9.81;  % (m/s^2)

Kt = 0.0333;
Km = 0.0333;
Rm = 8.7;

Beq = 1e-6;
Bp = 1e-6;

M = [
    Jeq + Mp * r * r, -Mp * r * lp;
    -Mp * r * lp, Jp + Mp * lp * lp
];

S = [
    Kt * Km / Rm + Beq, 0;
    0, Bp;
];

G = [
    0, 0;
    0, -Mp * g * lp;
];

G_prime = -G;

% syms omega;
% eqn = det(G_prime - omega^2 * M) == 0;
% omega = solve(eqn);
% disp(vpa(omega, 10));

omega = [0, 9.133066815];
phi = [
    1;
    0;
];

temp = G_prime - omega(2)^2 * M;
temp = det(temp) * inv(temp);

phi = [phi, -temp(:, 1) / norm(temp(:, 1), 2)];

A = [
   zeros(2, 2), eye(2);
   -inv(M) * G_prime, -inv(M) * S
];

B = [
    zeros(2, 1);
    inv(M) * [Kt / Rm; 0]
];

C = eye(4);
D = zeros(4, 1);

system = ss(A, B, C, D);

T = 0.001;
t = 0:T:20;
x0 = [0.1, 0.1, 0, 0];
u = zeros(size(t));
[y, tOut, x] = lsim(system, u, t, x0);
noise = mvnrnd([0, 0], 1e-6 * eye(2), size(y, 1));
y1 = y(:, 1:2)' + noise';

y2 = inv(phi) * y1;
y21 = y2(1, :);
y22 = y2(2, :);
delta_y = y2(1, :) - y2(2, :);
plot(t, delta_y);
% function parameters
% p(1) = A
% p(2) = lambda
% p(3) = mu
% p(4) = phi
fun = @(p, k) p(1) .* exp(-p(2) .* k .* T) .* cos(p(3) .* k .* T + p(4));
params0 = [0, 0, 0, 0];
k = 1:length(y2);
params = [];
for i = 1:2
    params_ = lsqcurvefit(fun, params0, k, y2(i, :));
    params = [params; params_];
end
lambda = params(:, 2)';
mu = params(:, 3)';
alpha = 2 * (lambda(1) * omega(1)^2 - lambda(2) * omega(2)^2) / (omega(1)^2 - omega(2)^2);
beta = 2 * (lambda(1) - lambda(2)) / ((lambda(1)^2 + mu(1)^2) - (lambda(2)^2 + mu(2)^2));
S = alpha * M + beta * G_prime;

y21_hat = fun(params(1, :), k);
y22_hat = fun(params(2, :), k);

subplot(2, 1, 1);
plot(t, y21, t, y21_hat);
subplot(2, 1, 2);
plot(t, y22, t, y22_hat);