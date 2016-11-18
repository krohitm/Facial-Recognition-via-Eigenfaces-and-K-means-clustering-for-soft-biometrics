function[result, accuracy, member_matrix, Kcentroids, WCSS] = runProgram()

%all the matrices represent features by samples form

gallery = importGallery();
[V, M] = findEig(gallery);
gallery_weights = galleryWeightVectors(gallery, V, M);
probes = importProbes();
probes_weights = probeWeightVectors(probes, V, M);
[result, accuracy] = testing(probes_weights, gallery_weights);
%accuracy = testingWOutReduction(probes, gallery);
%sampleCount = size(probes,2);
%[member_matrix, Kcentroids, WCSS] = clustering(probes_weights);