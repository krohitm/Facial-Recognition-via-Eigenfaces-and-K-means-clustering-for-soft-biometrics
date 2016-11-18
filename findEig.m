function [V, M] = findEig(gallery)

M = mean(gallery,2);
A = gallery - repmat(M,1,size(gallery, 2));
S = cov(A.');
[V,D] = eig(S);
%eigval = diag(D);
%eigval = eigval(end:-1:1);
V = fliplr(V);
for i=1:3
    imageDemo = reshape(V(:,i), [50,50]);
    figure;
    imagesc(imageDemo);
    title({strcat('Principal component',num2str(i))});
    colorbar
end;