function [fig1_ARM13, fig1_ARM24, fig1_payload, fig1_shadow] = Display(X, drone_body)
    fig1 = figure('pos', [0 150 800 600]);
    view(3);
    fig1.CurrentAxes.YDir = 'reverse';
    fig1.CurrentAxes.ZDir = 'reverse';
    
    axis equal;
    grid on;
    
    xlim([-5, 5]); ylim([-5, 5]); zlim([-8, 0]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    
    hold(gca, 'on');
    R = R_Matrix(X(7:9));
    wHb = [R', X(1:3); 0, 0, 0, 1];
    drone_world = wHb * drone_body;
    drone_attitude = drone_world(1:3,:);
    
    fig1_ARM13 = plot3(gca, drone_attitude(1,[1 3]), drone_attitude(2, [1 3]), drone_attitude(3, [1 3]), '-ro', 'MarkerSize', 5);
    fig1_ARM24 = plot3(gca, drone_attitude(1,[2 4]), drone_attitude(2, [2 4]), drone_attitude(3, [2 4]), '-bo', 'MarkerSize', 5);
    fig1_payload = plot3(gca, drone_attitude(1,[5 6]), drone_attitude(2, [5 6]), drone_attitude(3, [5 6]), '-k', 'LineWidth', 3);
    fig1_shadow = plot3(gca, 0, 0, 0, 'xk', 'LineWidth',3);

    hold(gca, 'off');
    
    titles = ["phi" "theta" "psi" "x" "y" "z_d"];

    fig2 = figure('pos', [800 350 600 400]);
    for i = 1:6
        subplot(2, 3, i);
        title(titles(i));
        grid on;
        hold on;
    end
end