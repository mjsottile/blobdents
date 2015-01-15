%
% convex hull example
%

clear;

cd test_images/flowers;
blobber;
cd ../..;
addpath('./src');

figure;
subplot(2,2,1);
imagesc(im{2});
set(gca,'XTick',[],'YTick',[]);
xlabel('(a)');

subplot(2,2,2);
[fim, hull, difference] = chull_version(BW{2});
imagesc(fim+hull);
set(gca,'XTick',[],'YTick',[]);
colormap gray;
xlabel('(b)');

subplot(2,2,3);
imagesc(difference);
set(gca,'XTick',[],'YTick',[]);
colormap(gray);
xlabel('(c)');

subplot(2,2,4);
imagesc(difference);
colormap(gray);
set(gca,'XLim',[1100,1400],'YLim',[400,800]);
set(gca,'XTick',[],'YTick',[]);
xlabel('(d)');

set(gcf, 'PaperUnits', 'Inches', 'PaperPosition', [0 0 12 12]);
saveas(gcf, 'figures/fig4.eps');
saveas(gcf, 'figures/fig4.png');
close all;