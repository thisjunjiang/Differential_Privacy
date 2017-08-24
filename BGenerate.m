% This function generates a count of events using bernoulli distribution
function count = BGenerate(x1,y1,x2,y2)
    count = 0;
    [count_cells, ~] = getProb(x1, y1, x2, y2);
    Pij_hat = AddLapNoise2(count_cells,1,0.5); %laplacian noise added
    Pj = Pij_hat(:);
    num = length(Pj);
    for i = 1:num
        temp = rand(1);
        if(temp <= Pj(i))
            count = count+1;
        end
    end
end