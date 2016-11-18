function[member_matrix, Kcentroids, WCSS] = clustering(probes_weights)   

%k-means clustering of data for soft biometric classification
clusterCount = 2;   %dividing data into two genders 
sampleCount = size(probes_weights, 2);
for i=10     %clusters for various no. of PCs
    %featureCount = i;
    kindex = randsample(1:size(probes_weights, 2), clusterCount);
    Kcentroids = probes_weights(1:i,kindex);    %initiating random k means
    [member_matrix, Kcentroids, i, WCSS] = updateAlgo...
    (probes_weights(1:i,:), Kcentroids,clusterCount, sampleCount);
end;