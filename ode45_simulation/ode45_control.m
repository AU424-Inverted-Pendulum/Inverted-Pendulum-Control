function u = ode45_control(x)
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
    
    Q = diag([1 1000 1 10]);
    R = 10;
    
    [P, ~, ~] = care(A_ctrl, B_ctrl, Q, R);

    u = -inv(R) * B_ctrl' * P * x;
end