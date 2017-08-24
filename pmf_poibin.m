function [a,b,pmf]=cdf_poibin(Pij_hat)
    i = sqrt(-1);
    %[m,n] = size(Pij_hat);
    Pj = Pij_hat(:);
    %num = m*n; 
    num = length(Pj);
    omega = 2*pi/(num + 1);
    Z = zeros(num,num);
    for l = 1:num
        Z(:,l)=cos(omega*l)+i*sin(omega*l)
    end
    Z = bsxfun(@plus,(1-Pj),bsxfun(@times,Pj,Z));
    Z_modu = abs(Z);
    Z_arg = atan2(imag(Z),real(Z)); %Z_arg = angle(Z);
    d = exp(sum(log(Z_modu)));
    Z_argtemp = sum(Z_arg);
    a = d.*cos(Z_argtemp);
    b = d.*sin(Z_argtemp);
    x = a + i*b;
    x = [1,x];
    xx = x/(num+1);
    pmf = fft(xx);
    
end

% The function adds noise directly to the probability.
function Pij_hat = AddNoise(Pij,sens,epsilon)
    [m,n]=size(Pij);
    lambda = sens/epsilon;
    Delta_ij = laprnd(0,lambda,m,n);
    Pij_hat = Pij + Delta_ij;
    Pij_hat(Pij_hat<0)=0;
    Pij_hat(Pij_hat>1)=1;
end

% The function adds noise to the counts.
function AddNoise2(Nij,M,sens,epsilon)

end

function x = laprnd(mu,lambda,m,n)
%mu is mean, sigma >= 0 is standard deviation, lambda is a scale parameter. 
% m and n represent the number of rows and columns of the generated random 
% matrix
%   sigma = sqrt(2)*b;
%   lambda = sigma/sqrt(2);
    u = rand(m,n)-0.5;
    x = mu - lambda*sign(u).*log(1-2*abs(u));
end
%test laplace distribution
%x = laprnd(0,1,1,10000); mean(x); std(x); hist(x,100)