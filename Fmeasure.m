function[F1] = Fmeasure(member_matrix)


probe_count = size(member_matrix,2);
cluster_num = size(member_matrix, 1);

[ID, Gender] = importSoft();
keySet = unique(Gender);
valueSet = [1:size(keySet,1)];
mapObj  = containers.Map(keySet, valueSet);
clusters = cell2mat(values( mapObj, Gender));

%actual clusters for probe images
probe_clusters_actual = zeros(probe_count, 1);
for i = 1:probe_count
    probe_clusters_actual(i,1) = clusters(ceil(i/2),1);
end;

%class with more members in actual clusters
out = [valueSet.',histc(probe_clusters_actual(:),valueSet.')];
more_members_class = out(floor(find(out == max(out(:,2)))/2), 1);
less_members_class = out(floor(find(out == min(out(:,2)))/2), 1);

%find which members belong to which cluster after k-means clustering
cluster1_member_indices = find(member_matrix(1,:));
cluster2_member_indices = find(member_matrix(2,:));
kmeans_clusters = zeros(probe_count, 1);

clusterTemp = 
if length(cluster1_member_indices) > length(cluster2_member_indices)
    kmeans_clusters(cluster1_member_indices,1) = more_members_class;
    kmeans_clusters(cluster2_member_indices,1) = less_members_class;
else
    kmeans_clusters(cluster2_member_indices,1) = more_members_class;
    kmeans_clusters(cluster1_member_indices,1) = less_members_class;
end;
    


%cluster_matrix = zeros(length(valueSet), cluster_num); 

%pos = find (cluster_matrix == max(cluster_matrix(:)));
%if pos == 2 || pos == 3
%    cluster_matrix = fliplr(cluster_matrix);
%end;

cluster_matrix = confusionmat(probe_clusters_actual, kmeans_clusters);

TP = cluster_matrix(1,1);
TN = cluster_matrix(2,2);
FN = cluster_matrix(1,2);
FP = cluster_matrix(2,1);
precision = TP/(TP + FP);
recall = TP/(TP + FN);
F1 = (precision*recall)/(precision + recall);
        
%no. of members in each kmeans cluster
%for i=1:probe_count
%   if member_matrix(1,:) == 1
        
%cluster1_count = sum(member_matrix(1,:));
%cluster2_count = sum(member_matrix(2,:));
%no of members in actual cluster
%cluster1_member_indices_actual = ...
%    find(probe_clusters_actual == valueSet(1,1));
%cluster1_members_count = ...
%    length(find(probe_clusters_actual == valueSet(1,1)));
%cluster2_member_indices_actual = ...
%    find(probe_clusters_actual == valueSet(2,1));
%cluster2_members_count = ...
%    length(find(probe_clusters_actual == valueSet(2,1)));

