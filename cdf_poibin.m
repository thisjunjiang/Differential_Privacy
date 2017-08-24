% This function calculates the pmf and cdf of the poisson binomial
% distribution. This function has been verified with the library provided
% by Yili Hong in R.
% function [a,b,pmf,cdf]=cdf_poibin(Pij,sens,epsilon)
%           Pij_hat = AddLapNoise(Pij,sens,epsilon)
function [a,b,pmf,cdf]=cdf_poibin(Pij_hat)
    i = sqrt(-1);
    %[m,n] = size(Pij_hat);
    Pj = Pij_hat(:);
    %num = m*n; 
    num = length(Pj);
    omega = 2*pi/(num + 1);
    Z = zeros(num,num);
    for l = 1:num
        Z(:,l)=cos(omega*l)+i*sin(omega*l);
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
    pmf = real(fft(xx));
    cdf = zeros(1,num+1);
    for k = 1:num+1
        cdf(1,k)= sum(pmf(1:k));
    end
    
    
    % generate a count according to the cdf
    count = Generate(cdf);
end

% This function generates a count of events according to the input cdf.
function count = Generate(cdf)
    temp = rand(1);
    cdf_temp = temp - cdf;
    count_temp = find(cdf_temp<=0);
    count = count_temp(1)-1;
end

