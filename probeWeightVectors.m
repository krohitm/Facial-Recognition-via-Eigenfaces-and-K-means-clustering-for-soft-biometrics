function [probes_weights] = probeWeightVectors(probes, V, M)

probes_weights = zeros(size(V,2), size(probes, 2));
for i = 1:size(probes, 2)
    for j=1:size(V,2)
        w = V(:, j).' * (probes(:, i) - M);
        probes_weights(j, i) = w;
    end;
end;