function[gallery_weights] = galleryWeightVectors(ignore_eig, gallery, V, M)
%this function finds the weight vectors of the gallery vectors by
%projecting the zero mean vectors on to the Principal Components

V = V(:,(ignore_eig+1):size(V,2));   %ignoring first 3 principal components because of noise
gallery_weights = zeros(size(V,2), size(gallery, 2));
for i = 1:size(gallery, 2)
    for j=1:size(V,2)
        w = V(:, j).' * (gallery(:, i) - M);
        gallery_weights(j, i) = w;      %features by samples
    end;
end;