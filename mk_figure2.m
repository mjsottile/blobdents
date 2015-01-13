%
% figure 1 : simple example showing blob and curvature curve after
% basic LPFing
%

clear;

cd test_images/flowers;
blobber;
cd ../..;
addpath('./src');
[numdents, curvature, xs, ys] = countindents(BW{1}, 200, 0.1);
[numdents_nf, curvature_nf, xs_nf, ys_nf] = countindents(BW{1}, -1, 0.1);

bad_region_x = [640; 980];
bad_region_y = [960; 1200];

figure;
subplot(1,2,1);
imagesc(im{1});
set(gca,'XLim',bad_region_x,'YLim',bad_region_y);
set(gca,'XTick',[],'YTick',[]);

subplot(1,2,2);
plot(bd{1}(:,2),-bd{1}(:,1));
hold on;
plot(xs,-ys,'r');
hold off;
set(gca,'XLim',bad_region_x,'YLim',sort(-bad_region_y));
set(gca,'XTick',[],'YTick',[]);


set(gcf, 'PaperUnits', 'Inches', 'PaperPosition', [0 0 12 6]);
saveas(gcf, 'figures/fig2.png');
close all;

figure;
title('Curvature of filtered vs raw boundary');
plot(curvature_nf,'r');
hold on;
plot(curvature,'b');
hold off;
xlabel('Position on boundary');
ylabel('Curvature (\kappa)');
set(gca,'YLim',[-0.05,0.05],'XLim',[1,length(curvature)]);

set(gcf, 'PaperUnits', 'Inches', 'PaperPosition', [0 0 9 9]);
saveas(gcf, 'figures/fig2_curvature.png');
close all;
