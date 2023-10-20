clc; clear;
close all;

X = [0; 0; -5;                      % x, y, z
     0; 0; 0;                       % phi, theta, psi
     0; 0; 0;                       % dx, dy, dz
     0; 0; 0];                      % p, q, r 

phi_des = 10.0;
theta_des = 10.0;
psi_des = 0.0;
z_d_des = 1.0;

control = [deg2rad(phi_des); deg2rad(theta_des); deg2rad(psi_des); z_d_des];

Project(X, control);