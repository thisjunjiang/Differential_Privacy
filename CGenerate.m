% This function generates a count of events using counts
function count = CGenerate(x1,y1,x2,y2)
    counts = getCounts(x1,y1,x2,y2);
%     min_count = min(counts);
%     max_count = max(counts);
%     num_bins = max_count - min_count + 1; 
%     h = histogram(counts, num_bins);
%     hvalues = h.Values;
%     
%     length = sum(hvalues~=0);
%     hcounts = zeros(length,2);
    [hcounts(:,2),hcounts(:,1)] = hist(counts, unique(counts));
    len = length(hcounts);
    
    hprobs = zeros(len,1);
    hprobs(2:len,1) = AddLapNoise2(hcounts(2:len,2),1,0.5);
    if sum(hprobs)<1
        hprobs(1,1) = 1-sum(hprobs);
    else 
        hprobs(1,1) = 0;
    end

    counts_cdf = cumsum(hprobs(:,1));
    
    temp = rand(1);
    cdf_temp = temp - counts_cdf;
    count_temp = find(cdf_temp<=0);
    count = hcounts(count_temp(1),1);
end