% This function adds noise to the counts.
% Nij is the count of each cell. M is the total intervals.
% sens here should be 1
function Pij_hat = AddLapNoise2(Nij,sens,epsilon)
    global total_intervals;
    [m,n]=size(Nij);
    lambda = sens/epsilon;
    Delta_ij = laprnd(0,lambda,m,n);
    Nij_hat = Nij + Delta_ij;
    Pij_hat = Nij_hat/total_intervals;
    Pij_hat(Pij_hat<0)=0;
    Pij_hat(Pij_hat>1)=1;
end

% The Gaussian mechanism with parameter sigma adds noise scaled to
% N(0,sigma^2) to each  of the d components.
% R = normrnd(MU,SIGMA,m,n) % MU--mena, SIGMA--standard variance
% This function adds Gaussian noise to the probabilities.
function Pij_hat = AddGauNoise(Pij,sens2,epsilon,delta)
    % epsilon (0,1), delta should be small
    % c^2 > 2ln(1.25/delta)
    c = sqrt(2*log(1.25/delta));
    % sigma >= c*sens2/epsilon
    sigma = c*sens2/epsilon;
    [m,n]=size(Nij);
    Delta_ij = normrnd(0,sigma,m,n);
    Pij_hat = Pij + Delta_ij;
    Pij_hat(Pij_hat<0)=0;
    Pij_hat(Pij_hat>1)=1;
end

% This function adds Gaussian noise to the counts.
function Pij_hat = AddGauNoise2(Nij,M,sens2,epsilon)
    % epsilon (0,1)
    % c^2 > 2ln(1.25/delta)
    c = sqrt(2*log(1.25/delta));
    % sigma >= c*sens/epsilon
    sigma = c*sens2/epsilon;
    [m,n]=size(Nij);
    Delta_ij = normrnd(0,sigma,m,n);
    Nij_hat = Nij + Delta_ij;
    Pij_hat = Nij_hat/M;
    Pij_hat(Pij_hat<0)=0;
    Pij_hat(Pij_hat>1)=1;
end

% This function generates m*n laplace noise.
function x = laprnd(mu,lambda,m,n)
% mu is mean, sigma >= 0 is standard deviation, lambda is a scale parameter. 
% m and n represent the number of rows and columns of the generated random 
% matrix
%   sigma = sqrt(2)*b;
%   lambda = sigma/sqrt(2);
    u = rand(m,n)-0.5;
    x = mu - lambda*sign(u).*log(1-2*abs(u));
end
% test laplace distribution
% x = laprnd(0,1,1,10000); mean(x); std(x); hist(x,100)