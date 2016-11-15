function[images] = importProbes()

cd ('\\Client\H$\Documents\Courses\EMI\Project2\ProbeSet');
images = zeros(2500, 100);
for i = 1:100
    imageName = strcat('subject',num2str(i),'_img1.pgm');
    images(:,i) = reshape(imread(imageName), [2500,1]);
end;
images = double(images);
cd ('\\Client\H$\Documents\Courses\EMI\Project2');


        