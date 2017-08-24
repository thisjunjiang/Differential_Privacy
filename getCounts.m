% This function gets event counts for this area for each time interval.
% x1, y1, x2, y2 are all coordinates in the map matrix, i.e starting from 1.
function counts = getCounts(x1, y1, x2, y2)
    global m;
    global total_intervals;
    global x_min;
    global y_max;
    global data;
    
    counts = zeros(1, total_intervals);
    curr_interval = 1;
    
    for k = 1:m
        x_temp = y_max-data(k,3)+1;
        y_temp = data(k,2)-x_min+1;
        if x_temp >= x1 && x_temp <= x2 && y_temp >= y1 && y_temp <= y2
            if data(k,1) == curr_interval
                counts(1,curr_interval) = counts(1,curr_interval)+1;
            else
                curr_interval = curr_interval+1;
                counts(1,curr_interval) = counts(1,curr_interval)+1;
            end
        end
    end
end

% With the counts, you can fit a distribution. Refer histfit() in MATLAB.