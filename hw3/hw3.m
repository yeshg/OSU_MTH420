%% Problem 1
%%%%%%%%%%%%%%%

%% Set up
labels = ["Years in Education","Gross Domestic Product","Life Satisfaction"];
countryNames = ["Australia" "Austria" "Denmark" "Iceland" "Ireland" "Luxembourg" "Netherlands" "Norway" "Sweden" "Switzerland" "United States"];
testCountryNames = ["Germany" "France"];

%% Model 1 - years in education on life satisfaction

% scatterplot
figure();
title = 'Scatterplot of years in education on life satisfaction';

% Use normal equations to find u_hat from A and f
A = [ones(1,11)' data(:,1)];
f = data(:,3);
u_hat = A'*A \ A'*f;

my_scatter(data(:,1),data(:,3),title,countryNames,u_hat);

% Test on test data
test_model_2d(testData(:,1),testData(:,3), testCountryNames, u_hat);

%% Model 2 - gross domestic product on life satisfaction
figure();
title = 'Scatterplot of gross domestic product on life satisfaction';

% Use normal equations to find u_hat from A and f
A = [ones(1,11)' data(:,2)];
f = data(:,3);
u_hat = A'*A \ A'*f;

my_scatter(data(:,2),data(:,3),title,countryNames,u_hat);

% Test on test data. In this case, both points are extrapolated
test_model_2d(testData(:,2),testData(:,3), testCountryNames, u_hat);

%% Model 3 - years in education and gdp on life satisfaction (multinomial)
figure();
title = 'Years of education and GDP on life satisfaction';

% Use normal equations to find u_hat from A and f
A = [ones(1,11)' data(:,1) data(:,2)];
f = data(:,3);
u_hat = A'*A \ A'*f;

my_3d_scatter(data(:,1),data(:,2),data(:,3),title,countryNames,u_hat)

% Test on test data. In this case, both points are extrapolated
test_model_3d(testData(:,1),testData(:,2),testData(:,3), testCountryNames, u_hat);

%% Problem 2
%%%%%%%%%%%%%%%

x = linspace(0,1);

figure();
plot(x,x.^2,x, x - (1/6),x,(3/4)*x,x,(4/3)*x-(1/4));legend('q(x)','u(x)','u_1(x)','u_2(x)');
title("Plot of q(x), u(x) and arbitrary lines u_1(x), u_2(x)");

% calculate norm of minimized u
norm_fun = @(t) ((t - 1/6) - t.^2).^2;
norm_u = sqrt(integral(norm_fun,0,1));

% calculate norm of arbitrary u_1
norm_fun = @(t) (((3/4)*t) - t.^2).^2;
norm_u2 = sqrt(integral(norm_fun,0,1));

% calculate norm of arbitrary u_2
norm_fun = @(t) (((4/3)*t-(1/4)) - t.^2).^2;
norm_u1 = sqrt(integral(norm_fun,0,1));

%% Functions

function y = my_scatter(x,y,the_title,textCell,u_hat)
    %scatter(x,y);
    plot(x,y,'*',x,u_hat(2)*x+u_hat(1),'-');%legend('data','linear fit');
    title(the_title);
    for ii = 1:numel(x) 
        text(x(ii)+.02, y(ii)+.02,textCell{ii},'FontSize',8) 
    end
    axis tight
    ylim([6.2 7.8])
    hold on
end

function f = test_model_2d(x,y,labels,u_hat)
    plot(x,y,'+',x,u_hat(2)*x+u_hat(1),'O');
    for ii = 1:numel(x) 
        text(x(ii)+.02, y(ii)+.02,strcat('Actual ',labels{ii}),'FontSize',8);
        text(x(ii)+.02, u_hat(2)*x(ii)+u_hat(1)+.02,strcat('Estimated ',labels{ii}),'FontSize',8);
    end
    axis tight
    ylim([6.2 7.8])
    hold on
end

function y = my_3d_scatter(x,y,z,the_title,textCell,u_hat)
    %scatter(x,y);
    syms a b
    fsurf(u_hat(1) + a*u_hat(2) + b*u_hat(3),[15, 22, 5*10^4, 12*10^4])
    hold on
    plot3(x,y,z,'*');
    title(the_title);
    axis tight
    zlim([6.7 7.7])
    for ii = 1:numel(x) 
        text(x(ii)+.02, y(ii)+.02,z(ii)+.02,textCell{ii},'FontSize',8) 
    end
    hold on
end

function f = test_model_3d(x,y,z,labels,u_hat)
    plot3(x,y,z,'+',x,y,u_hat(3)*y+u_hat(2)*x+u_hat(1),'O');
    for ii = 1:numel(x) 
        text(x(ii)+.02, y(ii)+.02,strcat('Actual ',labels{ii}),'FontSize',8);
        text(x(ii)+.02, u_hat(2)*x(ii)+u_hat(1)+.02,strcat('Estimated ',labels{ii}),'FontSize',8);
    end
    axis tight
    zlim([6.7 7.7])
    hold on
end