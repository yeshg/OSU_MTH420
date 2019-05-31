%%
t=linspace(0,2*pi,2000);s=sin(220*t);

% bad version
for f=[262 294 330 349 392 440 466 524]
    s=sin(f*t);
    plot(t,s);
    pause;
    sound(s);
end

% C major triad is C, G, E: [262, 327.5, 393.0]


figure();
ratios = [1 9/8 5/4 4/3 3/2 5/3 15/8 2];

% good version computed with ratios
for f = 262 * ratios
    s=sin(f*t);
    plot(t,s);
    pause;
    sound(s);
end
