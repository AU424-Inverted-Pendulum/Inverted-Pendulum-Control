function x_dot = ode_func(t, x, u, noise)
    % 失配
    A_real = [
        0,      0,      1.0,          0;
        0,      0,        0,        1.0;
        0, 77.298, -0.57593, -0.0019074;
        0, 83.413, -0.24502, -0.0020583;
    ];
    
    B_real = [
             0;
             0;
        17.161;
        7.3008;
    ];

    x_dot = A_real * x + B_real * u;
    if nargin == 4
        x_dot = x_dot + noise;
    end
end