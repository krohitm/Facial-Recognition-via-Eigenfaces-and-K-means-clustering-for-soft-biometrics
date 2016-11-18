function [member_matrix, Kcentroids, WCSS] = ...
    memMat(probes_weights, Kcentroids, clusterCount, sampleCount)

member_matrix = zeros(clusterCount,sampleCount);
Distance = zeros(clusterCount, 1);

%calculating membership matrix
turn = 1;
for i = 1:sampleCount
    for j = 1:clusterCount
        Distance(j,1) = ...
            abs((sum((probes_weights(:,i) - Kcentroids(:,j)).^2).^0.5));
    end;
    Dmin = min(Distance);
    commonClusters = find(Dmin == Distance);
    if length(commonClusters) > 1
        clusterIndex = mod(turn,3);
        turn = turn + 1;
        if clusterIndex == 0
            clusterIndex = 1;
        end;
    else
        clusterIndex = commonClusters;
    end;
    member_matrix(min(size(member_matrix,1),clusterIndex), i) = 1;
end;

%finding new K centroids
for i=1:clusterCount
    Kcentroids(:,i) = ...
        (member_matrix(i,:)*probes_weights.').'./(sum(member_matrix(i,:)));
end;

%finding within-cluster-sum-square
WCSS = 0;
for i = 1:clusterCount
    WCSS = ...
        WCSS + (member_matrix(i,:) * (sum(((probes_weights - ...
        repmat(Kcentroids(:,i), 1, sampleCount)).^2),2)).');
end;