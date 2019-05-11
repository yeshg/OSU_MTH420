%% Problem 1
%%%%%%%%%%%%%%%

% Setup

close all;
clear all;
clc;

set(0, 'DefaultLineLineWidth', 5);

% 1 - A = [2 -1; -1 2];
%illustrateSVD([2 -1; -1 2], 0);

% 2 - A = [7 5; 1 5];
%illustrateSVD([7 5; 1 5], 0);

% 3 - A = [1 1; 1 1];
%illustrateSVD([1 1; 1 1], 1);

% 4 - A = [1 0; 0 -1];
illustrateSVD([1 0; 0 -1], 0);


% Functions

function f = illustrateSVD(A, flag)
    theta =0:0.1:2*pi ;
    u = [cos(theta);sin(theta)]; %% parametrize points on a circle;
    zero =[0;0]; one1 = [1;0]; one2= [0;1];

    K = A'*A;
    [V,E]=eig(K);
    E = sqrt(E);
    U = ones(2,2);

    U(:,1) = 1/E(1,1) * A*V(:,1);
    U(:,2) = 1/E(2,2) * A*V(:,2);
    
    if(flag == 1)
        [U, E, V] = svd(A);
    end
    
    U
    E
    V'
    
    %Geometrically, an eigenvector, corresponding to a real nonzero eigenvalue, points in a direction that is stretched by the transformation and the eigenvalue is the factor by which it is stretched. If the eigenvalue is negative, the direction is reversed

    % Plot vectors at origin
    figure();
    win(1) = subplot(2, 2, 1);
    win(2) = subplot(2, 2, 2);
    win(3) = subplot(2, 2, 3);
    win(4) = subplot(2, 2, 4);
    set(win,'Nextplot','add')
    drawVectors(u, zero, one1, one2, win(1), 'Starting vectors e1 (red) and e2 (blue)');
    drawVectors(V'*u, zero, V'*one1, V'*one2, win(2), 'Transformation V^Tx');
    drawVectors(E*V'*u, zero, E*V'*one1, E*V'*one2, win(3), 'Transformation EV^Tx');
    drawVectors(U*E*V'*u, zero, U*E*V'*one1, U*E*V'*one2, win(4), 'Transformation UEV^Tx');
    figure();
    drawVectors_alone(A*u, zero, A*one1, A*one2, 'Transformation Ax');
end

function f = drawVectors(u, zero, one1, one2, plot_id, the_title)
    plot(plot_id, u(1,:),u(2,:),'b-'); axis equal;
    vector = [zero, one1]; plot(plot_id, vector(1,:),vector(2,:),'r-*');
    vector = [zero, one2]; plot(plot_id, vector(1,:),vector(2,:),'m-*');
    title(plot_id,the_title);
end

function f = drawVectors_alone(u, zero, one1, one2, the_title)
    clf; plot(u(1,:),u(2,:),'b-'); axis equal;
    vector = [zero, one1]; hold on; plot(vector(1,:),vector(2,:),'r-*');hold off;
    vector = [zero, one2]; hold on; plot(vector(1,:),vector(2,:),'m-*');hold off;
    title(the_title);
end

% function f = drawVectors(vec1, vec2, the_title)
%     figure(); h = compass([vec1(1) vec2(1)],[vec1(2) vec2(2)]);
%     set(h(1),'color','r');
%     set(h(2),'color','b');
%     title(the_title);
% end

