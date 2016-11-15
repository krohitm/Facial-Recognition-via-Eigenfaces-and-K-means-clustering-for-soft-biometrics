function[accuracy] = testingWOutReduction(probes, gallery)

result = zeros(size(probes,2),1);

for i = 1:size(probes, 2)
    dmin = Inf;
    for j = 1:size(gallery, 2)
        d = abs((sum((probes(:,i) - gallery(:,j)).^2).^0.5));
        if d < dmin
            dmin = d;
            match = j;
        end;
    end;
    if match == ceil(i/2)        %checking if probe subject matching with same gallery subject
        result(i, 1) = 1;
    else
        result(i, 1) = 0;
    end;
end;

accuracy = (sum(result)/size(probes,2))*100;