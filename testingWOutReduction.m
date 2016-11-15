function[accuracy] = testingWOutReduction(probes, gallery)

result = zeros(size(probes,2),1);
for i = 1:size(probes, 2)
    dmin = Inf;
    for j = 1:size(gallery, 2)
        d = abs((sum((probes(:,i) - gallery(:,j)).^2).^0.5));
        if d < dmin
            dmin = d;
            result(i,1) = ceil(j/2);
        end;
    end;
end;

actual = [1:100].';
check = (result == actual);
accuracy = size(result(check == 1),1);
accuracy = (accuracy/size(result,1))*100;