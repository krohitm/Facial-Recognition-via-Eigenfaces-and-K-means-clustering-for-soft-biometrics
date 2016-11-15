function[images] = importGallery()

cd ('\\Client\H$\Documents\Courses\EMI\Project2\GallerySet');
images = zeros(2500, 200);
for i = 1:100
    for j = 1:2
        imageName = strcat('subject',num2str(i),'_img',num2str(j+1),'.pgm');
        images(:,i*2 - 2 + j) = reshape(imread(imageName), [2500,1]);
    end;
end;
images = double(images);
cd ('\\Client\H$\Documents\Courses\EMI\Project2');


        