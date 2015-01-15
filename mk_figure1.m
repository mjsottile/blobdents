%
% figure 1 : simple example showing blob and curvature curve after
% basic LPFing
%

clear;

%% set up shape
% make a nice solid black and white blob
im=imfill(rgb2gray(imread('test_images/blob.png')) < 50,'holes');

%% call indentation counting code
addpath('./src');
[numdents, curvature, xs, ys] = countindents(im, 200, 0.1);

%% plotting

figure('Position',[1,1,800,400]);

% shape plot
subplot(1,2,1);
plot(xs,ys);
hold on;
plot(xs(1),ys(1),'ro');
hold off;
set(gca,'XTick',[],'YTick',[]);
title('Boundary of shape');

% curvature plot
subplot(1,2,2);
plot(curvature);
hold on;
plot(1:length(curvature),zeros(length(curvature),1),'r--');
hold off;
set(gca,'YLim',[-0.01, 0.01],'XLim',[1,length(curvature)]);
title('Curvature clockwise along boundary');
xlabel('Boundary point index');
ylabel('Signed curvature (\kappa)');
drawnow;

set(gcf, 'PaperUnits', 'Inches', 'PaperPosition', [0 0 12 6]);
saveas(gcf, 'figures/fig1.eps');
saveas(gcf, 'figures/fig1.png');
close all;