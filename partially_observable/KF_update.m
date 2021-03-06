function [x_kf_u,P_kf_u] = KF_update(x_kf_p, P_kf_p, y, R)
    C = [
        1, 0, 0, 0;
        0, 1, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0;
    ];
    innovation = y - C * x_kf_p; 
    lamda_t = C * P_kf_p * C' + R;
    kalman_gain = P_kf_p * C' * inv(lamda_t);
    
    x_kf_u = x_kf_p + kalman_gain * innovation;
    P_kf_u = P_kf_p - kalman_gain * C * P_kf_p;
end