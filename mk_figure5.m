%
% examples
%

clear;

cd test_images/flowers;
blobber;
cd ../..;
addpath('./src');

cd test_images;
examples{1} = imfill(rgb2gray(imread('blob.png')) < 50,'holes');
examples{2} = imread('twodents.png')>200;
cd ..;

examples{3} = BW{1};
examples{4} = BW{2};
examples{5} = BW{4};
examples{6} = BW{5};

figure;

for i=1:length(examples)
    subplot(3,2,i);
    [n, k, xs, ys, k_mask] = countindents(examples{i},50,0.001,[0;1],1);
    plot(xs,ys);
    hold on;
    plot(xs(find(k_mask)),ys(find(k_mask)),'ro');
    hold off;
    set(gca,'XTick',[],'YTick',[]);
    title(sprintf('%d indentations',n));
end

set(gcf, 'PaperUnits', 'Inches', 'PaperPosition', [0 0 4 12]);
saveas(gcf, 'figures/fig5.eps');
saveas(gcf, 'figures/fig5.png');
close all;