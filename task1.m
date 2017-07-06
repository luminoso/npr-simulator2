p = [0 1 2];    % probability of 0, 1 and 2 errors
B = 800;        % packet size of 100 bytes (100*8 bits)

error_rates = [ 10^-7 10^-6 10^-5];

% Determine the probability of a data packet of total size B = 100 bytes
% being received without errors, with exactly 1 error and with 2 or more
% errors. Fulfil the following table:

% |                     | q=10E-7 | q=10E-6 | q=10E-5 |
% |---------------------|---------|---------|---------|
% | p(no errors)        |         |         |         |
% | p(1 error)          |         |         |         |
% | p(2 or more errors) |         |         |         |

results = [];

for i=0:1
    for j=1:3
        results(i+1,j) = binopdf(i, B, error_rates(j));
    end
end

results(3,:) = 1 - results(1,:) - results(2,:);

format SHORTE;
results

% Consider that 10% of data packets has a total size B=64 bytes and 90%
% of data packets has a total size B=1500 bytes. Determine the packet
% discard rate (i.e., the percentage of packets that are discarded) and fulfil the following table:

% |                     | q=10E-7 | q=10E-6 | q=10E-5 |
% |---------------------|---------|---------|---------|
% | Packet discard rate |         |         |         |

format shorte;
results = [];

for j=1:3
    results(j) = 1;
    for k=0:1
        results(j) = (0.90 * (results(j) - binopdf(k, 1500*8, error_rates(j)))) + (0.10 * (results(j) -binopdf(k, 64*8, error_rates(j))));
    end
    results(j) = results(j) * 100; % convert to %
end

format short;
results
results = [];

% Consider now that the total size, in number of Bytes, of the data
%packets is a constant value (64 Bytes) plus a geometric random value with
%parameter p=0.02. Determine the packet discard rate on this case and
%fulfil the following table:

% |                     | q=10E-7 | q=10E-6 | q=10E-5 |
% |---------------------|---------|---------|---------|
% | Packet discard rate |         |         |         |

p = 0.02;

for j=1:3
    results(j) = 0;
    for i=0:1000
        n = (64 +i)* 8;
        geo_value = p*(1-p).^i;
        results(j) = results(j) + (1- binopdf(0,n, error_rates(j)) - binopdf(1,n, error_rates(j))) * geo_value;
    end
    results(j) = results(j) * 100; % convert to %
end

format short;
results
results=[];


% Consider now that the 32 bytes field for error correction are replaced by a 4 bytes field
% on each data packet which only enables the receiver to detect if the data packet has been
% received with errors. Repeat 1.b. and 1.c. for this case and fulfill the following tables:

% |                     | q=10E-7 | q=10E-6 | q=10E-5 |
% |---------------------|---------|---------|---------|
% | Packet discard rate |         |         |         |

for j=1:3
    results(j) = (0.90 * (1- binopdf(0, 1500*8 -28*8, error_rates(j)))) + (0.10 * (1- binopdf(0, 64*8 - 28*8, error_rates(j))));
    results(j) = results(j) * 100;
end
format shortE;
results
results = [];

p = 0.02;

for j=1:3
    results(j) = 0;
    for i=0:1000
        n = (64-28 +i)* 8;
        geo_value = p*(1-p).^i;
        results(j) = results(j) +  (1-binopdf(0,n, error_rates(j))) * geo_value;
    end
    results(j) = results(j) * 100;
end
format short;
results

