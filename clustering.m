function[member_matrix, Kcentroids, WCSS, DI, FMI] = clustering(probes_weights)   

%k-means clustering of data for soft biometric classification
clusterCount = 2;   %dividing data into two genders 
sampleCount = size(probes_weights, 2);

WCSS = zeros(10,1);
DI = zeros(10,1);
%WCSSmin = Inf;
for i=10:10:100     %clusters for various no. of PCs
    kindex = randsample(1:size(probes_weights, 2), clusterCount);
    Kcentroids = probes_weights(1:i,kindex);    %initiating random k means
    [member_matrix, Kcentroids, WCSS(i/10,1)] = updateAlgo...
        (probes_weights(1:i,:), Kcentroids,clusterCount, sampleCount);
    %if WCSS(i/10,1) < WCSSmin
    %    member_matrix_good = member_matrix;
    %end;
    DI(i/10,1) = DunnIndex(probes_weights(1:i,:), member_matrix, ...
        Kcentroids,clusterCount, sampleCount);
    FMI(i/10,1) = Fmeasure(member_matrix);
end;