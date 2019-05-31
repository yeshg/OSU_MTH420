function [K] = barcode(n,D )
    K = zeros(n,n);
    h = 1/n;
    gfun =@(x)(exp(-(x.^2)/(D^2)));
    distance=linspace(0,1);
    plot(distance,gfun(distance));
    for j=1:n
        for m=1:n
            K(j,m) = gfun((j-m)/n);
        end
    end
    K = h*K;
end