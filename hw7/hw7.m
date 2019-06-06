%% II.14

G = [0 0 0 1;
    0.5 0 0 0;
    0.3 0 0 0;
    0.2 1 0 0;];

One = ones(4,4);

alpha = 0.15;

syms a;

M = (1-a)*G+(a/4)*One;

% M = (1-alpha)*G+(alpha/4)*One;

% fix column 3 to make M stochastic matrix

M(:,3) = [1/4, 1/4, 1/4, 1/4]';

M = double(subs(M,a,.15));

%% II.15

r0=rand(4,1);r0=r0/sum(r0);