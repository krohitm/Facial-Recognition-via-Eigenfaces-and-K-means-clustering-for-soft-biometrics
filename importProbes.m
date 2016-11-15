function[probes] = importProbes()

cd ('\\Client\H$\Documents\Courses\EMI\Project2\ProbeSet');
probes = zeros(2500, 200);
for i = 1:100
    for j = 1:2
        imageName = strcat('subject',num2str(i),'_img',num2str(j+1),'.pgm');
        probes(:,i*2 - 2 + j) = reshape(imread(imageName), [2500,1]);
    end;
end;
probes = double(probes);
cd ('\\Client\H$\Documents\Courses\EMI\Project2');


        