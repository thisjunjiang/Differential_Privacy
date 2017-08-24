load('taxi8v2.mat');
global data;
data = taxi8v2;
% The following is global variables we are going to use throught the simu.
global m;
global total_intervals;
global x_max;
global x_min;
global y_max;
global y_min;
global map_aggregation;
global m_map;
global n_map;


%% Step1
% First we tranfer the discontinuous time_interval_no 
% to a continuous form

[m, n] = size(data);
comparison = data(1,1);
interval_no = 1;
for k=1:m
    if data(k,1)==comparison
        data(k,1) = interval_no;
    elseif data(k,1) > comparison
        comparison = data(k,1);
        interval_no = interval_no+1;
        data(k,1) = interval_no;
    end
end


%% Step2
% Calculate the bernoulli probability for each cell
% In the same time interval, if a cell has more than 
% one events, we only count one of them. Because we 
% are assuming an estimated bernoulli distribution for each 
% cell in this time interval
x_min = min(data(:,2));
x_max = max(data(:,2));
y_min = min(data(:,3));
y_max = max(data(:,3));

total_intervals = max(data(:,1));
map_aggregation = zeros(y_max-y_min+1, x_max-x_min+1);
[m_map, n_map] = size(map_aggregation);
%% Step not executed
% This part aims at that more than one pickup at the same cell in the same
%  time interval only count for 1. My computer can't create this large
%  3D arrays to store the info. However, maybe I can implement this code 
%  in other relatively small areas.
%
% 
% maps = zeros(m_map, n_map,total_intervals);
% 
% for k = 1:m
%     x_temp = y_max-data(k,3)+1;
%     y_temp = data(k,2)-x_min+1;
%     z_temp = data(k,1);
%     maps(x_temp, y_temp, z_temp) = 1;   
% end

%% Step3
% This step goes through the entire records and count events for each cell.

% for k = 1:m
%     x_temp = y_max-data(k,3)+1;
%     y_temp = data(k,2)-x_min+1;
%     map_aggregation(x_temp, y_temp) = map_aggregation(x_temp, y_temp)+1;
% end
map_flag = zeros(m_map,n_map);
comparison = 1;
for k = 1:m
    x_temp = y_max-data(k,3)+1;
    y_temp = data(k,2)-x_min+1;
    if data(k,1)==comparison && map_flag(x_temp, y_temp) == 0
        map_aggregation(x_temp, y_temp) = map_aggregation(x_temp, y_temp)+1;
        map_flag(x_temp, y_temp) = 1;
    elseif data(k,1) > comparison
        comparison = data(k,1);
        map_aggregation(x_temp, y_temp) = map_aggregation(x_temp, y_temp)+1;
        map_flag = zeros(m_map,n_map);
        map_flag(x_temp, y_temp) = 1;
    end
end

% The following code is based on that unexecuted step.
% for i = 1: m_map
%     for j = 1 : n_map
%         for interval_no = 1:total_intervals
%             map_aggregation(i,j) = map_aggregation(i,j)+ maps(i,j,interval_no);
%         end
%     end
% end

        