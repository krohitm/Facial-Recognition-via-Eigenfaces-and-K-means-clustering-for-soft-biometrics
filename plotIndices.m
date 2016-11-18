function [] = plotIndices(DI,)

figure;
plot (1:10, DI(:,1));
title ('Dunn Index for various number of principal components');
xlabel ('Number of Principal Components');
ylabel ('Dunn Index');
set(axes1,'XTickLabel',{'10','20','30','40','50','60','70','80','90','100'});

figure;
plot (2:10, DBI(:,1));
title ('Davis - Bouldin Index for various number of clusters');
xlabel ('Number of Clusters');
ylabel ('Davis - Bouldin Index');