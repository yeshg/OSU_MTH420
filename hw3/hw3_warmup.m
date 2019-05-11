%% Warm Up Problem II.3 
t=[0.5, 1.5, 2, 5];
b = [3.1 6.8 10.3 25];

% Using x = A \ f
A = [t' ones(1,4)'];
f = b';
x = A \ f;

% Using normal equations to solve for u_hat
u_hat = A'*A \ A'*b';

% Using polyfit for linear regression
p = polyfit(t,b,1);
a = p(1); c = p(2);
figure();
plot(t,b,'*',t,a*t+c,'-');legend('data','linear fit');

% Using polyfit for quadratic regression
p = polyfit(t,b,2);

a = p(1); d = p(2); c = p(3);
figure();
plot(t,b,'*',t,a*t.^2+d*t+c,'-');legend('data','quadratic fit');

%% Warm Up Problem II.4
t=[0.5, 1.5, 2, 5]; b = [3.1 6.8 10.3 25];

% Set up Au = f, where u = [a ln(c)]'
A = [t' ones(1,4)'];
f = log(b)';
u = A \ f;

%a = u(1); c = exp(u(2));
%plot(t,b,'*',t,c*exp(a*t),'-');legend('data','exponential fit');

% Now try to use normal equations
u_hat = A'*A \ A'*f;
a = u(1); c = exp(u(2));
plot(t,b,'*',t,c*exp(a*t),'-');legend('data','exponential fit');

hold on;
fplot(@z, c*exp(a*z));