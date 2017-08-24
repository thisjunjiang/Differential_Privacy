%% Generate 100 copies of maps for each method.
%  store as three-dimensional matrices
x_start = 2712;
y_start = 860;

area = 1200;
medium = 40;
M = area/(medium*5);
N = M;
x_end = x_start+area/5-1;
y_end = y_start+area/5-1;
%%
ncopy = 100;
map_pb_100 = zeros(M,N,ncopy);
map_c_100 = zeros(M,N,ncopy);
map_b_100 = zeros(M,N,ncopy);
for i = 1:ncopy
    map_pb_100(:,:,i) = MapGenerate1(x_start, y_start, M, N, medium);
    map_c_100(:,:,i) = MapGenerate2(x_start, y_start, M, N, medium);
    map_b_100(:,:,i) = MapGenerate3(x_start, y_start, M, N, medium);
end

%% Generate a validation map from Sept with the same size.
map_flag = zeros(m_map,n_map);
sept_data = zeros(M,N,630);
comparison = 1;
for k = 1:m
    x_temp = y_max-data(k,3)+1;
    y_temp = data(k,2)-x_min+1;
    if x_temp >= x_start && x_temp <= x_end && y_temp >= y_start && y_temp <= y_end
        x_temp2 = floor((x_temp-x_start)/medium)+1;
        y_temp2 = floor((y_temp-y_start)/medium)+1;
        if data(k,1)==comparison && map_flag(x_temp, y_temp) == 0
            sept_data(x_temp2, y_temp2,comparison) = sept_data(x_temp2, y_temp2,comparison)+1;
            map_flag(x_temp, y_temp) = 1;
        elseif data(k,1) > comparison
            comparison = data(k,1);
            sept_data(x_temp2, y_temp2,comparison) = sept_data(x_temp2, y_temp2,comparison)+1;
            map_flag = zeros(m_map,n_map);
            map_flag(x_temp, y_temp) = 1;
        end
    end  
end


%% plot the qqplot
figure();
for i = 1:M
    for j = 1:N
        subplot(M,N,(i-1)*N+j);
        x_quantiles = map_pb_100(i,j,:);
        x_quantiles = x_quantiles(:);
        y_quantiles = sept_data(i,j,:);
        y_quantiles = y_quantiles(:);
        x_quantiles = x_quantiles + 0.1 * randn(100,1);
        qqplot(x_quantiles, y_quantiles);
        legend('poisson binomial');
        hold on;
        x_quantiles = map_c_100(i,j,:);
        x_quantiles = x_quantiles(:);
        y_quantiles = sept_data(i,j,:);
        y_quantiles = y_quantiles(:);
        x_quantiles = x_quantiles + 0.1 * randn(100,1);
        qqplot(x_quantiles, y_quantiles);
        legend('count');
        hold on;
        x_quantiles = map_b_100(i,j,:);
        x_quantiles = x_quantiles(:);
        y_quantiles = sept_data(i,j,:);
        y_quantiles = y_quantiles(:);
        x_quantiles = x_quantiles + 0.1 * randn(100,1);
        qqplot(x_quantiles, y_quantiles);
        legend('bernoulli');
    end  
end