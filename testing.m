function [accuracy] = testing(probes_weights, gallery_weights)
%this function is to get the PCA project of data for different no of PCs,
%and test the recognition rate for different no of PCs used for projections

result = zeros(size(probes_weights,2),1);
for numofPCs = 10:10:100
    for i = 1:size(probes_weights, 2)   %checking for all probes
        dmin = Inf;
        for j = 1:size(gallery_weights, 2)  %to compare each probe with complete gallery
            d = abs((sum((probes_weights(1:numofPCs,i) ...
                - gallery_weights(1:numofPCs,j)).^2).^0.5));
            if d < dmin
                dmin = d;
                match = j;
            end;
        end;
        if match == ceil(i/2)        %checking if probe subject matching with same gallery subject
            result(i, numofPCs/10) = 1;
        else
            result(i, numofPCs/10) = 0;
        end;
    end;
end;

accuracy = zeros(size(result,2), 1);

for i=1:size(result,2)
    accuracy(i,1) = (sum(result(:,i))/size(probes_weights,2))*100;
end;

axes1 = axes('Parent',figure);
set(gca,'fontsize',23);
hold on;
plot(1:size(accuracy,1),accuracy, 'LineWidth',2);
title('Recognition rate for different principal components');
xlabel('Number of Principal Components');
ylabel('Recognition Rate');
set(axes1,'XTickLabel',{'10','20','30','40','50','60','70','80','90','100'});