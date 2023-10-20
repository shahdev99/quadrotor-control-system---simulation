function dX = EoM(X, m, g, u, I)
    R = R_Matrix(X(4:6));
    R2 = R_Matrix2(X(4:6));
    
    x_d_d = 1/m * ([0; 0; m*g] + R' * u(1) * [0; 0; -1]);
    euler_d = R2 * X(10:12);
    angle_d_d = I \ (u(2:4) - cross(X(10:12), I*X(10:12)));

    dX = [X(7:9); euler_d; x_d_d; angle_d_d];
end