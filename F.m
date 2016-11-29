function[F_cluster12, F_cluster21] = F(member_matrix)
%this function measures the F1 score of the kmeans clustering
%it is being used for external validity of clustering for different no of
%PCs

image_count = size(member_matrix,2);
%cluster_num = size(member_matrix, 1);

Gender = importSoft();
keySet = unique(Gender);
valueSet = [1:size(keySet,1)];
mapObj  = containers.Map(keySet, valueSet);
clusters = cell2mat(values( mapObj, Gender));

%actual clusters for images
image_clusters_actual = zeros(image_count, 1);
for i = 1:image_count
    image_clusters_actual(i,1) = clusters(ceil(i/3),1);
end;

%class with more members in actual clusters
out = [valueSet.',histc(image_clusters_actual(:),valueSet.')];
more_members_class = ...    %let class with more members be class 1
    out(floor(find(out == max(out(:,2)))/2), 1);
less_members_class = ...
    out(floor(find(out == min(out(:,2)))/2), 1);

%find which members belong to which cluster after k-means clustering
cluster1_member_indices = find(member_matrix(1,:));
cluster2_member_indices = find(member_matrix(2,:)); 

%no. of members in each CLUSTER
cluster1_size = length(cluster1_member_indices);
cluster2_size = length(cluster2_member_indices);

class1_member_indices = ... %objects in class 1
    find(image_clusters_actual == more_members_class);
class2_member_indices = ... %object in class 2
    find(image_clusters_actual == less_members_class);

%no. of objects in each class
class1_size = length(class1_member_indices);
class2_size = length(class2_member_indices);

class2_in_cluster1 = ...    %class 2 objects in cluster 1
    sum(ismember(class2_member_indices, cluster1_member_indices));
class1_in_cluster2 = ...    %class 1 objects in cluster 2
    sum(ismember(class1_member_indices, cluster2_member_indices));

%recall and precision of class i in cluster j as recallij and precisionij
recall12 = class1_in_cluster2/class1_size;
precision12 = class1_in_cluster2/cluster2_size;

recall21 = class2_in_cluster1/class2_size;
precision21 = class2_in_cluster1/cluster1_size;

%f measure of class i and cluster j as F_clusterij
F_cluster12 = (2*precision12*recall12)/(precision12 + recall12);
F_cluster21 = (2*precision21*recall21)/(precision21 + recall21);