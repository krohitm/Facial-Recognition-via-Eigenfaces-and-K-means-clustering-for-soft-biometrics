function[member_matrix, Kcentroids, WCSS, DI, FMI, accuracy, ...
    direct_accuracy] = runProgram()

%all the matrices represent features by samples form

gallery = importGallery();
[V, M] = findEig(gallery);
gallery_weights = galleryWeightVectors(gallery, V, M);
probes = importProbes();
probes_weights = probeWeightVectors(probes, V, M);
%[result, accuracy] = ...
accuracy = testing(probes_weights, gallery_weights);
direct_accuracy = testingWOutReduction(probes, gallery);
[member_matrix, Kcentroids, WCSS, DI, FMI] = clustering(probes_weights);

plotIndices(DI, FMI);