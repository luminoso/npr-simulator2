function pi = markov_func(n,br,dr)

pi = 0;

for i=1:size(br,2)
    pi = pi + (prod(br(1:i))/prod(dr(1:i)));
end

if n == 0
    pi = 1/(1+pi);
else
    pi = 1/(1+pi);
    pi = pi * (prod(br(1:n))/prod(dr(1:n)));
end

end