function[gallery] = importGallery()

cd ('\\Client\H$\Documents\Courses\EMI\Project2\GallerySet');
gallery = zeros(2500, 100);
for i = 1:100
    imageName = strcat('subject',num2str(i),'_img1.pgm');
    gallery(:,i) = reshape(imread(imageName), [2500,1]);
end;
gallery = double(gallery);
cd ('\\Client\H$\Documents\Courses\EMI\Project2');