function [DI] = DunnIndex(probes_weights, member_matrix, Kcentroids,...
    clusterCount, sampleCount)

minDelta = Inf;
for i=1:(clusterCount - 1)
    for j=(i+1):clusterCount
        delta = (sum((Kcentroids(:,i) - Kcentroids(:,j)).^2)).^0.5;
        if delta < minDelta
            minDelta = delta;
        end;
    end;
end;

maxScatter = 0;
for i=1:clusterCount
    scatter = (member_matrix(i,:) * (sum(((probes_weights - ...
        repmat(Kcentroids(:,i), 1, sampleCount)).^2),1).^0.5).')...
        ./sum(member_matrix(i,:));
    if scatter > maxScatter
        maxScatter = scatter;
    end;
end;

DI = minDelta/maxScatter;