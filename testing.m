function [result, accuracy] = testing(probes_weights, gallery_weights)

result = zeros(size(probes_weights,2),1);
for numofPCs = 10:10:100
    for i = 1:size(probes_weights, 2)
        dmin = Inf;
        for j = 1:size(gallery_weights, 2)
            d = abs((sum((probes_weights(4:numofPCs+3,i) ...
                - gallery_weights(4:numofPCs+3,j)).^2).^0.5));
            if d < dmin
                dmin = d;
                result(i,numofPCs/10) = ceil(j/2);
            end;
        end;
    end;
end;

actual = [1:100].';
accuracy = zeros(size(result,2), 1);

for i=1:size(result,2)
    check = (result(:,i) == actual);
    accuracy(i,1) = size(result(check == 1),1);
    accuracy(i,1) = (accuracy(i,1)/size(result,1))*100;
end;

figure;
plot(1:10,accuracy);
title('Recognition rate for different principal components');
xlabel('Number of Principal Components');
ylabel('Recognition Rate');
%ticks = (1:10);
%xticks(ticks);
%xticklabels({10*xticks});
            