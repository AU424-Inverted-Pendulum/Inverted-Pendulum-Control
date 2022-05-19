clear; clc;
A = [
    0,      0,      1.0,          0;
    0,      0,        0,        1.0;
    0, 77.298, -0.57593, -0.0019074;
    0, 83.413, -0.24502, -0.0020583;
];

B = [
    0;
    0;
    17.161;
    7.3008;
];

[n, m] = size(B);
temp = [
  A, B;
  zeros(m, m + n);
];
dt = 0.001;

temp = expm(temp * dt);
G = temp(1:n, 1:n);
H = temp(1:n, n + 1: n + m);

disp("G"); disp(G);
disp("H"); disp(H);