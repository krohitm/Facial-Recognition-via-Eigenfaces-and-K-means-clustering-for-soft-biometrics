function [member_matrix, Kcentroids, i, WCSS] = updateAlgo...
    (probes_weights, Kcentroids,clusterCount, sampleCount)
%running update algorithm for K-means clustering

member_matrix_prev = zeros(clusterCount, sampleCount);

for i = 1:50
    [member_matrix, Kcentroids, WCSS(i,1)] = ...
        memMat(probes_weights, Kcentroids, clusterCount, sampleCount);
    %Kcentroids = clusterMeans(member_matrix, probes_weights, ...
     %   clusterCount, featureCount);
    %WCSS(i,1) = objFunc(member_matrix, probes_weights, Kcentroids, ...
    %    clusterCount, sampleCount);
    if member_matrix_prev == member_matrix
        break;
    end;
    member_matrix_prev = member_matrix;
end;