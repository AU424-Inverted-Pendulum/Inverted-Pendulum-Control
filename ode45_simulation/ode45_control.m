function u = ode45_control(x)
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

    C = [
        1, 0, 0, 0;
        0, 1, 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1;
    ];
    
    Q = diag([1 1000 1 10]);
    R = 100000;
    
    [P, ~, ~] = care(A_ctl, B_ctrl, C * Q * C', R);
    noise = 0.01 *  mvnrnd([0; 0; 0; 0;], 0.01 * eye(4), 1)';
    y = C * x + noise;
    u = -inv(R) * B_ctrl' * P * y;
end