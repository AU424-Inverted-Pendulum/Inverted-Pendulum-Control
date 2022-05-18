clear; clc;
Mp = 0.027;  % (kg)
lp = 0.153;  % (m)
r = 0.0826;  % (m)
Jeq = 3.68e-4;  % (kg.m^2)
Jp = 6.98e-4;  % (kg.m^2)
g = 9.81;  % (m/s^2)

Kt = 0.0333;
Km = 0.0333;
Rm = 8.7;

Beq = 1e-6;
Bp = 1e-6;

syms theta1 theta2 s;
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
    0, -Mp * g * lp
];

A = [
   zeros(2, 2), eye(2);
   -inv(M) * G, -inv(M) * S
];

B = [
    zeros(2, 1);
    inv(M) * [Kt / Rm; 0]
];

C = [
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1
];

D = zeros(4, 1);

Gs = [0, 1, 0, 0] * C * inv(s * eye(4) - A) * B;

disp("M = "); disp(vpa(M, 5));
disp("S = "); disp(vpa(S, 5));
disp("G = "); disp(G);
disp("A = "); disp(vpa(A, 5));
disp("B = "); disp(vpa(B, 5));
disp("C = "); disp(C);
disp("G(s) = "); disp(vpa(Gs, 5));
