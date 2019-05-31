function [K] = gravity(n,D )
    K = zeros(n,n);
    h = 1/n;
    gfun =@(x)(D./(sqrt(D^2+x.^2)).^3);
    distance=linspace(0,1);
    %plot(distance,gfun(distance));
    for j=1:n
        for m=1:n
            K(j,m) = gfun((j-m)/n);
        end
    end
    K = h*K;
end