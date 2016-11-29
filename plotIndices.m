function [] = plotIndices(DI,FMI)

axes1 = axes('Parent',figure);
set(gca,'fontsize',23);
hold on;
plot (1:10, DI(:,1), 'LineWidth',2);
title ('Dunn Index for various number of principal components');
xlabel ('Number of Principal Components');
ylabel ('Dunn Index');
set(axes1,'XTickLabel',{'10','20','30','40','50','60','70','80','90','100'});

axes1 = axes('Parent',figure);
set(gca,'fontsize',23);
hold on;
plot (1:10, FMI(:,1), 'LineWidth',2);
title ('F - measure Index for various number of clusters');
xlabel ('Number of Principal Components');
ylabel ('F - measure Index');
set(axes1,'XTickLabel',{'10','20','30','40','50','60','70','80','90','100'});