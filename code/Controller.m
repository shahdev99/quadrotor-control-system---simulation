function [U, err] = Controller(control, X, gains, m, g, err_sum, prev_err, dt)
    phi_des = control(1);
    theta_des = control(2);
    psi_des = control(3);
    z_d_des = control(4);

    phi_err = phi_des - X(4);
    theta_err = theta_des - X(5);
    psi_err = psi_des - X(6);
    z_d_err = z_d_des - X(9);

    u2 = gains(1,1)*phi_err + gains(1,2)*err_sum(1) + gains(1,3)*(phi_err-prev_err(1))/dt;
    u3 = gains(2,1)*theta_err + gains(2,2)*err_sum(2) + gains(2,3)*(theta_err-prev_err(2))/dt;
    u4 = gains(3,1)*psi_err + gains(3,2)*err_sum(3) + gains(3,3)*(psi_err-prev_err(3))/dt;
    u1 = m*g - (gains(4,1)*z_d_err + gains(4,2)*err_sum(4) + gains(4,3)*(z_d_err-prev_err(4))/dt);

    U = [u1; u2; u3; u4];
    err = [phi_err; theta_err; psi_err; z_d_err];
end