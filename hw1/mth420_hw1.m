%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 2A - Use MATLAB to solve system for equilibrium and do gradient descent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Redefine system from three masses to two masses
% Givens
m_1 = 10; m_2 = 2; m_3 = 3;
c_1 = 10; c_2 = 1;
g = 9.8;

% Adjust for rod between m_1 and m_2
m_1 = m_1 + m_2;
m_2 = m_3;

%% Set up the system with Kx = f, where f = mg

% Construct vector of forces f = m*g, where m is vector of masses
m = [m_1 m_2]';
f = m*g
f(1)

% Construct matrix K that describes the linear transformation of x to f
K = [c_1 + c_2 -c_2 ; -c_2 c_2]

%% Solve Kx = f
x_star = K \ f

%% Set up energy functional phi(x)
x = linspace(-10,50);
[x1,x2] = meshgrid(x, x);                                
phi = (1/2)*(c_1*x1.^2 + c_2*(x1-x2).^2) - (x1*f(1)+x2*f(2));

%% Plot contour plot, x0
% fa1 = gradient(phi, 0.2, 0.2);                  % Derivative
% zv = contour(x1,x2,fa1, [0; 0]);              % Critical Points (not
                                                % important for this
                                                % assignment
figure(1)
%surf(x1,x2,phi)
contour(x1,x2,phi,100)  % contour plot with 100 levels
title('Contour Plot of Phi with 50 Steps of Gradient Descent')
hold on
plot3(x_star(1),x_star(2),0,'*')
plot3(0,0,0,'o')
min(phi)

%% Gradient Descent
syms x y
%f = -(sin(x) + sin(y))^2;
f = (1/2)*(c_1*x^2+c_2*(x-y)^2) - (x*f(1) + y*f(2));
g = gradient(f, [x, y]);

alpha = 0.02; % step size (not that important because we will keep moving
              % down until no longer decreasing
x = 0; y = 0;

for i = 1:50  % used to be 50
    %pause  % for user interaction
    grad = subs(g);
    decreased = true;
    % keep moving down gradient until function values are no longer
    % decreasing
    while decreased
        before = subs(f);
        x = x - alpha*grad(1);
        y = y - alpha*grad(2);
        after = subs(f);
        if after > before
            decreased = false;
        end
    end
    plot3(x,y,subs(f),'x')
end


vpa([x,y]) % final result of gradient descent

hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 2B - Illustration of Spring-Mass System with and without gravity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Spring Mass System without gravity
figure();
title('Spring Mass System without Gravity');
hold on
axis([-10 100 -10 100])
pbaspect([1 1 1])
grid on
axis off

% plot first spring
plot([50 50], [90 100],'m','LineWidth',2)
text(51,95,'\leftarrow c_1 = 10, length = 10')

circle(50,80,10,'b')
text(61,80,'\leftarrow m_1 = 10')

% plot rod between m_1 and m_2
hold on
plot([50 50], [60 70],'b','LineWidth',3)
text(51,67,'\leftarrow non-elastic rod, length = 10')

circle(50,58,2,'b')
text(53,58,'\leftarrow m_2 = 2')

% plot second spring
hold on
plot([50 50], [56 46],'m','LineWidth',2)
text(51,50,'\leftarrow c_2 = 1, length = 10')

circle(50,43,3,'b')
text(54,43,'\leftarrow m_3 = 3')

%% Spring Mass System with Gravity
figure();
title('Spring Mass System with Gravity');
hold on
axis([-10 100 -10 100])
pbaspect([1 1 1])
grid on
axis off

% plot first spring
plot([50 50], [75.3 100],'m','LineWidth',2)
text(51,87.65,'\leftarrow c_1 = 10, length = 24.7')

circle(50,65.3,10,'b')
text(61,65.3,'\leftarrow m_1 = 10')

% plot rod between m_1 and m_2
hold on
plot([50 50], [45.3 55.3],'b','LineWidth',3)
text(51,50.3,'\leftarrow non-elastic rod, length = 10')

circle(50,43.3,2,'b')
text(53,43.3,'\leftarrow m_2 = 2')

% plot second spring
hold on
plot([50 50], [41.3 -2.8],'m','LineWidth',2)
text(51,19.25,'\leftarrow c_2 = 1, length = 54.1')

circle(50,-5.8,3,'b')
text(54,-5.8,'\leftarrow m_3 = 3')


function h = circle(x,y,r,c)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit);
fill(xunit,yunit, c);
hold off
end