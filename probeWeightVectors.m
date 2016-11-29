function [probes_weights] = probeWeightVectors(ignore_eig, probes, V, M)
%this function finds the weight vectors of the probes vectors by
%projecting the zero mean vectors on to the Principal Components

V = V(:,(ignore_eig+1):size(V,2));   %ignoring first three principal components because of noise
probes_weights = zeros(size(V,2), size(probes, 2));
for i = 1:size(probes, 2)
    for j=1:size(V,2)
        w = V(:, j).' * (probes(:, i) - M);
        probes_weights(j, i) = w;
    end;
end;