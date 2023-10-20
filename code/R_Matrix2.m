function R = R_Matrix2(angles)
    phi = angles(1);
    theta = angles(2);

    R = [ 1 sin(phi)*tan(theta)  cos(phi)*tan(theta);
          0 cos(phi)            -sin(phi);
          0 sin(phi)*sec(theta)  cos(phi)*sec(theta)];
end