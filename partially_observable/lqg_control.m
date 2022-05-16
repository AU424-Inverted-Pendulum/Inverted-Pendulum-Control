function u = lqg_control(x, r, t)
    A_ctl = [
        0,         0, 1.0,   0;
        0,         0,   0, 1.0;
        0,  -167.587,   0,   0;
        0,   574.761,   0,   0;
    ];
  
    B_ctrl = [
                0;
                0;
         2060.299;
        -4135.392;
    ];

    C = eye(4);
    
    Q = diag([1 1000 1 1]);
    R = 100;
    [P, ~, ~] = care(A_ctl, B_ctrl, Q, R);
    
    G = inv((B_ctrl * inv(R) * B_ctrl' * P - A_ctl)') * C' * Q;
    g = G * [r(t); 0; 0; 0];
    u = -inv(R) * B_ctrl' *(P * x - g);
end