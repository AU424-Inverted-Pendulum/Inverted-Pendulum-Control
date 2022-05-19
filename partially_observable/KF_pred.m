function [x_kf_p, P_kf_p] = KF_pred(x_kf_u, P_kf_u, u, Q)
    G = [
        1.0000,    0.0000,    0.0010,    0.0000;
             0,    1.0000,   -0.0000,    0.0010;
             0,    0.0773,    0.9994,    0.0000;
             0,    0.0834,   -0.0002,    1.0000;
    ];

    H = [
        0.0000;
        0.0000;
        0.0172;
        0.0073;
    ];

	x_kf_p = G * x_kf_u + H * u;
    P_kf_p = G * P_kf_u * G' + Q;
end

