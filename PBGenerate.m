% This function generates a count of events according to poison binomial
function count = PBGenerate(x1,y1,x2,y2)
    [count_cells, ~] = getProb(x1, y1, x2, y2);
    Pij_hat = AddLapNoise2(count_cells,1,0.5); %laplacian noise added
    [~,~,~,cdf] = cdf_poibin(Pij_hat);
    
    temp = rand(1);
    cdf_temp = temp - cdf;
    count_temp = find(cdf_temp<=0);
    count = count_temp(1)-1;
end