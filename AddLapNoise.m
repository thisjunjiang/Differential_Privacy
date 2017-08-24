% This function adds noise directly to the probability.
% sens is sensitivity. epsilon is the privacy parameter.
% what should the sens be?
function Pij_hat = AddLapNoise(Pij,sens,epsilon)
    [m,n]=size(Pij);
    lambda = sens/epsilon;
    Delta_ij = laprnd(0,lambda,m,n);
    Pij_hat = Pij + Delta_ij;
    Pij_hat(Pij_hat<0)=0;
    Pij_hat(Pij_hat>1)=1;
end