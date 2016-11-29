function[WCSS, DI, FMI, accuracy, direct_accuracy] = runProgram()

%all the matrices represent features by samples form

gallery = importGallery();
[V, M] = findEig(gallery);
ignore_eig = 6;
gallery_weights = galleryWeightVectors(ignore_eig, gallery, V, M);
probes = importProbes();
probes_weights = probeWeightVectors(ignore_eig, probes, V, M);
%[result, accuracy] = ...
accuracy = testing(probes_weights, gallery_weights);
direct_accuracy = testingWOutReduction(probes, gallery);
[member_matrix, Kcentroids, WCSS, DI, FMI] = ...
    clustering(gallery_weights, probes_weights);

plotIndices(DI, FMI);