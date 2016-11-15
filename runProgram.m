function[result, accuracy] = runProgram()

gallery = importGallery();
[V, M] = findEig(gallery);
gallery_weights = galleryWeightVectors(gallery, V, M);
probes = importProbes();
probes_weights = probeWeightVectors(probes, V, M);
[result, accuracy] = testing(probes_weights, gallery_weights);
%accuracy = testingWOutReduction(probes, gallery);