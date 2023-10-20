function [] = Project(X, control)

    m = 1.25;                                   % Mass
    g = 9.81;                                   % Gravity
    L = 0.265;                                  % Rotor arm length
    I = [0.0232 0 0; 0 0.0232 0; 0 0 0.0468];   % Inertial Moment

    drone_body = [ L,  0,    0, 1;      % Drone arm 1
                   0, -L,    0, 1;      % Drone arm 2
                  -L,  0,    0, 1;      % Drone arm 3
                   0,  L,    0, 1;      % Drone arm 4
                   0,  0,    0, 1;      % Drone body centre
                   0,  0, 0.15, 1]';    % Drone payload

    pid_gains = [0.32, 0.001, 0.27;     % kp_phi   ki_phi   kd_phi
                 0.32, 0.001, 0.27;     % kp_theta ki_theta kd_theta
                 0.6, 0.000, 0.5;       % kp_psi   ki_psi   kd_psi
                 10.0, 0.2, 0.0];       % kp_z_d   ki_z_d   kd_z_d
    
    simTime = 2;                        % Simulation Time
    dt = 0.01;                          % dt = T_i+1 - T_i
    
    % Figure
    [fig1_ARM13, fig1_ARM24, fig1_payload, fig1_shadow] = Display(X, drone_body);
    
    err_sum = [0.0; 0.0; 0.0; 0.0];     % phi, theta, psi, z_d error sums
    prev_err = [0.0; 0.0; 0.0; 0.0];    % phi, theta, psi, z_d previous error
    
    for i = 0:dt:simTime
        [U, err] = Controller(control, X, pid_gains, m, g, err_sum, prev_err, dt);
        err_sum = err_sum + err;
        prev_err = err;
        dX = EoM(X, m, g, U, I);
        X = X + dX*dt;
    
        figure(1)
        wHb = [R_Matrix(X(4:6))' X(1:3); 0 0 0 1];
        drone_world = wHb * drone_body;
        drone_attitude = drone_world(1:3,:);
    
        set(fig1_ARM13, 'xData', drone_attitude(1,[1 3]), 'yData', drone_attitude(2,[1 3]), 'zData', drone_attitude(3,[1 3]));
        set(fig1_ARM24, 'xData', drone_attitude(1,[2 4]), 'yData', drone_attitude(2,[2 4]), 'zData', drone_attitude(3,[2 4]));
        set(fig1_payload, 'xData', drone_attitude(1,[5 6]), 'yData', drone_attitude(2,[5 6]), 'zData', drone_attitude(3,[5 6]));
        set(fig1_shadow, 'xData', X(1), 'yData', X(2), 'zData', 0);
    
        figure(2)
        subplot(2,3,1)
            plot(i, rad2deg(X(4)), '.');
        subplot(2,3,2)
            plot(i, rad2deg(X(5)), '.');
        subplot(2,3,3)
            plot(i, rad2deg(X(6)), '.');
        subplot(2,3,4)
            plot(i, X(1), '.');
        subplot(2,3,5)
            plot(i, X(2), '.');
        subplot(2,3,6)
            plot(i, X(9), '.');
    end
end