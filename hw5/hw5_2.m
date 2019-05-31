%% Problem 1
D = [0.1000 1.0000 10.0000];
n = [10 100];

for i=1:3
    for j=1:2
        cond(barcode(n(j), D(i)))
        pause;
    end
end

% Problem 1-A:
% As D gets larger, cond(K) gets much larger (problem gets more sensitive) this makes sense.
% As the resolution of the reading gets larger, the sensitivity of the
% problem gets larger.

S = svds(barcode(n(1), D(2)));

%% Problem 2
D = [0.1000 1.0000 10.0000];
n=10;  
mytreasure = [0,1,1,1,0,0,1,0,1,0]';
% (1 means present , 0 means absent ).

for i=1:3
    K = barcode(n,D(i)); 
    f=mytreasure;
    g=K*f;
    t=linspace(0,1,length(mytreasure))';

    % now solve the inverse problem
    newf = K \ g;
    norm(newf-f);

    % perturb rhs and try to find the treasure now
    rand_mag=50;
    gp = g + rand_mag*rand(n,1);
    fp = K \ gp;

    figure(); plot(t,f,t,g,t,newf); %% or plot in a more fancy way
    legend("Actual Treasure","Receiver","Inverse Problem");
    title("D = " + D(i));
    pause;
end