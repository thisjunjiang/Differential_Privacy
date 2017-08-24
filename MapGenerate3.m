% This funciton generates a map based on bernoulli distribution of each cell.
function map = MapGenerate3(x_start, y_start, M, N, medium)
    map = zeros(M,N);
    for i = 1:M
        x1 = x_start+medium*(i-1);
        x2 = x1+medium-1;
        for j = 1:N
            y1 = y_start+medium*(j-1);
            y2 = y1+medium-1;
            map(i,j) = BGenerate(x1,y1,x2,y2);
        end
    end  
end