function[F1] = Fmeasure(member_matrix)
%this function measures the F1 score of the kmeans clustering
%it is being used for external validity of clustering for different no of
%PCs

probe_count = size(member_matrix,2);
%cluster_num = size(member_matrix, 1);

Gender = importSoft();
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
more_members_class = ...
    out(floor(find(out == max(out(:,2)))/2), 1);
less_members_class = ...
    out(floor(find(out == min(out(:,2)))/2), 1);

%find which members belong to which cluster after k-means clustering
cluster1_member_indices = find(member_matrix(1,:));
cluster2_member_indices = find(member_matrix(2,:));

class1_member_indices = ...
    find(probe_clusters_actual == more_members_class);
class2_member_indices = ...
    find(probe_clusters_actual == less_members_class);

class1_in_cluster1 = ...
    sum(ismember(class1_member_indices, cluster1_member_indices));
class2_in_cluster1 = ...
    sum(ismember(class2_member_indices, cluster1_member_indices));
class1_in_cluster2 = ...
    sum(ismember(class1_member_indices, cluster2_member_indices));
class2_in_cluster2 = ...
    sum(ismember(class2_member_indices, cluster2_member_indices));

if class1_in_cluster1 > class1_in_cluster2    %cluster1 will have majority of class 1 members
    cluster_matrix = [class1_in_cluster1, class1_in_cluster2; ...
        class2_in_cluster1, class2_in_cluster2];
else if class1_in_cluster1 < class1_in_cluster2    %cluster 2 will have majority of class 1 members
    cluster_matrix = [class1_in_cluster2, class1_in_cluster1; ...
        class2_in_cluster2, class2_in_cluster1];
    else if class2_in_cluster1 > class2_in_cluster2
            cluster_matrix = [class2_in_cluster1, class2_in_cluster2; ...
                class1_in_cluster1, class1_in_cluster2];
        else
            cluster_matrix = [class1_in_cluster1, class1_in_cluster2; ...
        class2_in_cluster1, class2_in_cluster2];
        end;
    end;
end;

cluster1_size = sum(cluster_matrix(:,1));
cluster2_size = sum(cluster_matrix(:,2));

%all pairs that can be chosen from all the samples
all_pairs = nchoosek(probe_count, 2);   
%all pairable samples from the 2 clusters
all_positives = nchoosek(cluster1_size,2) + nchoosek(cluster2_size,2); 
%all pairable samples of same class in same cluster
TP = nchoosek(cluster_matrix(1,1), 2) + nchoosek(cluster_matrix(1,2), 2) ...
    + nchoosek(cluster_matrix(2,1), 2) + nchoosek(cluster_matrix(2,2), 2);
FP = all_positives - TP;    %all non-pairable samples of different classes in same cluster

all_negatives = all_pairs - all_positives;
FN = sum(prod(cluster_matrix, 2));

precision = TP/(TP + FP);
recall = TP/(TP + FN);
F1 = (precision*recall)/(precision + recall);