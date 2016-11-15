function[gallery_weights] = galleryWeightVectors(gallery, V, M)

gallery_weights = zeros(size(V,2), size(gallery, 2));
for i = 1:size(gallery, 2)
    for j=1:size(V,2)
        w = V(:, j).' * (gallery(:, i) - M);
        gallery_weights(j, i) = w;
    end;
end;