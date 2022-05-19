function u = lqg_control(x, r, t)
    A_ctrl = [
        0,      0,      1.0,   0;
        0,      0,        0, 1.0;
        0, 77.298, -0.57145,   0;
        0, 83.413, -0.24312,   0;
    ];
  
    B_ctrl = [
             0;
             0;
        17.161;
        7.3008;
    ];

    C = eye(4);
    
    Q = diag([1 1000 1 10]);
    R = 10;
    [P, ~, ~] = care(A_ctrl, B_ctrl, Q, R);

    G = inv((B_ctrl * inv(R) * B_ctrl' * P - A_ctrl)') * C' * Q;

    g = G * [r(t); 0; 0; 0];
    u = -inv(R) * B_ctrl' *(P * x - g);
end