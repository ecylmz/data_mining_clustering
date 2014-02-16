function [ data ] = Dataset( which )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here

switch which
    case 1
        %dataset1
        data_n = 400;
        data = rand(data_n, 2);
        % === cluster 1
        dist1 = distfcm([0.2 0.2], data);
        index1 = (dist1 < 0.15)';
        % === cluster 2
        dist2 = distfcm([0.7 0.7], data);
        index2 = (dist2 < 0.25)';
        % === cluster 3
        index3 = data(:,1) - data(:, 2) - 0.1 < 0;
        index4 = data(:,1) - data(:, 2) + 0.1 > 0;
        index5 = data(:,1) + data(:, 2) - 0.4 > 0;
        index6 = data(:,1) + data(:, 2) - 1.4 < 0;
        % === final data
        data(find((index1|index2|(index3&index4&index5&index6)) ...
            == 0), :) = [];

    case 2
        %dataset2
        data_n = 100;
        % === cluster 1
        c1 = [0.6 0.2]; radius1 = 0.2;
        data1 = randn(data_n, 2)/10 + ones(data_n, 1)*c1;
        % === cluster 2
        c2 = [0.2 0.6]; radius2 = 0.2;
        data2 = randn(data_n, 2)/10 + ones(data_n, 1)*c2;
        % === cluster 3
        c3 = [0.8 0.8]; radius3 = 0.2;
        data3 = randn(data_n, 2)/10 + ones(data_n, 1)*c3;
        % === final data
        data = [data1; data2; data3];
        index = (min(data')>0) & (max(data')<1);
        data(find(index == 0), :) = [];

    case 3
        %dataset3
        data_n = 100;
        k = 10;
        c1 = [0.125 0.25];
        data1 = randn(data_n, 2)/k + ones(data_n, 1)*c1;
        c2 = [0.625 0.25];
        data2 = randn(data_n, 2)/k + ones(data_n, 1)*c2;
        c3 = [0.375 0.75];
        data3 = randn(data_n, 2)/k + ones(data_n, 1)*c3;
        c4 = [0.875 0.75];
        data4 = randn(data_n, 2)/k + ones(data_n, 1)*c4;
        data = [data1; data2; data3; data4];
        index = (min(data')>0) & (max(data')<1);
        data(find(index == 0), :) = [];
    case 4
        N = 1000;    
        N = round(N/8) * 8;    
        scale = 10;   
        gapwidth = 2;    
        cornerwidth = 2;
        perCorner = N/4;
 
        xplusmin = [ones(perCorner,1); -1*ones(perCorner,1); ones(perCorner,1); -1*ones(perCorner,1)];
        yplusmin = [ones(perCorner,1); -1*ones(2*perCorner,1); ones(perCorner,1)];
    
        horizontal = [xplusmin(1:2:end) * gapwidth + xplusmin(1:2:end) * scale .* rand(N/2,1), ...
                  yplusmin(1:2:end) * gapwidth + cornerwidth * yplusmin(1:2:end) .* rand(N/2,1), ...
                  floor((0:N/2-1)'/(perCorner*.5))];
       
        vertical = [xplusmin(2:2:end) * gapwidth + cornerwidth * xplusmin(2:2:end) .* rand(N/2,1), ...
                yplusmin(2:2:end) * gapwidth + yplusmin(2:2:end) * scale .* rand(N/2,1), ...
                floor((0:N/2-1)'/(perCorner*.5))];
    
        data=  [horizontal; vertical];         

    case 5
        N = 2000;   
        degrees = 570;    
        start = 90;    
        noise = 0.2;  
        deg2rad = (2*pi)/360;
        start = start * deg2rad;
 
        N1 = floor(N/2);
        N2 = N-N1;
    
        n = start + sqrt(rand(N1,1)) * degrees * deg2rad;   
        d1 = [-cos(n).*n + rand(N1,1)*noise sin(n).*n+rand(N1,1)*noise zeros(N1,1)];
    
        n = start + sqrt(rand(N1,1)) * degrees * deg2rad;      
        d2 = [cos(n).*n+rand(N2,1)*noise -sin(n).*n+rand(N2,1)*noise ones(N2,1)];
    
        data = [d1;d2];

    case 6
        N = 1000;
 
        N = N + 1;
        minx = -20;
 
        r1 = 20;
 
        r2 = 35;
 
        noise = 4;
 
        ratio = 0.6;
        phi1 = rand(N/2,1) * pi;
        inner = [minx + r1 * sin(phi1) - .5 * noise  + noise * rand(N/2,1) r1 * ratio * cos(phi1) - .5 * noise + noise * rand(N/2,1) ones(N/2,1)];
    
        phi2 = rand(N/2,1) * pi;
        outer = [minx + r2 * sin(phi2) - .5 * noise  + noise * rand(N/2,1) r2 * ratio * cos(phi2) - .5 * noise  + noise * rand(N/2,1) zeros(N/2,1)];
 
        data = [inner; outer];
    case 7
        data=[randn(30,2)*.4;randn(40,2)*.5+ones(40,1)*[4 4]];
end

