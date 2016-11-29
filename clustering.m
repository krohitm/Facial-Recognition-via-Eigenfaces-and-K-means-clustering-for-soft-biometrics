function[member_matrix, Kcentroids, WCSS, DI, FMI] = ...
    clustering(gallery_weights, probes_weights)   
%k-means clustering of data for soft biometric classification

sample_count = size(probes_weights, 2) + size(gallery_weights, 2);
image_weights = zeros(size(probes_weights, 1),sample_count);
j = 1;
k = 1;
for i = 1:sample_count
    if mod(i,3) == 1
        image_weights(:,i) = gallery_weights(:,j);
        j = j+1;
    else
        image_weights(:,i) = probes_weights(:, k);
        k = k+1;
    end;
end;
    
clusterCount = 2;   %dividing data into two clusters 
%sampleCount = size(probes_weights, 2);

WCSS = zeros(10,1);
DI = zeros(10,1);
FMI = zeros(10,1);
%WCSSmin = Inf;
for i=10:10:100     %clusters for various no. of PCs
    kindex = randsample(1:size(image_weights, 2), clusterCount);
    Kcentroids = image_weights(1:i,kindex);    %initiating random k means
    [member_matrix, Kcentroids, WCSS(i/10,1)] = updateAlgo...
        (image_weights(1:i,:), Kcentroids,clusterCount, sample_count);
    %if WCSS(i/10,1) < WCSSmin
    %    member_matrix_good = member_matrix;
    %end;
    DI(i/10,1) = DunnIndex(image_weights(1:i,:), member_matrix, ...
        Kcentroids,clusterCount, sample_count);
    FMI(i/10,1) = Fmeasure(member_matrix);
end;

axes1 = axes('Parent',figure);
set(gca,'fontsize',23);
hold on;
plot(1:size(WCSS,1),WCSS, 'LineWidth',2);
title('Within-Cluster-Sum of Squares for different number of principal components');
xlabel('Number of Principal Components');
ylabel('Within-Custer-Sum of Squares');
set(axes1,'XTickLabel',{'10','20','30','40','50','60','70','80','90','100'});