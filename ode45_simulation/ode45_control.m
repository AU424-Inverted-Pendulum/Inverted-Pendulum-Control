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
    
    Q = diag([100 100 200 1]);
    R = 400000;
    
    K = lqr(A_ctl, B_ctrl, Q, R);
%     disp(K);
%     K = [-0.0316   -1.6359   -0.0424   -0.1262];
    u = -K * x;
end