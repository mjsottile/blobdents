im=imread('indent.png');

im=rgb2gray(im);

i1 = im(:,1:250);
i2 = im(:,251:550);
i3 = im(:,551:end);

%n1 = countindents(i1);

%n2 = countindents(i2);

n3 = countindents(i3);

% figure;
% subplot(1,3,1);
% imagesc(i1);colormap(bone);axis off;
% title(sprintf('Dents: %d',n1));
% subplot(1,3,2);
% imagesc(i2);colormap(bone);axis off;
% title(sprintf('Dents: %d',n2));
% subplot(1,3,3);
% imagesc(i3);colormap(bone);axis off;
% title(sprintf('Dents: %d',n3));
