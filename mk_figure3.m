%
% plotting commands to make plot of Gibbs phenomenon artifact
% due to bad low pass filter on square image
%
clear;

addpath('./test_images');

sq = make_square(400,200);

addpath('./src');

[numdents, curvature, xs, ys] = countindents(sq, 200, 0.1);
[numdents_nf, curvature_nf, xs_nf, ys_nf] = countindents(sq, -1, 0.1);

plot(xs,ys);
hold on;
plot(xs_nf, ys_nf,'r');
hold off;
set(gca,'XLim',[90, 220],'YLim',[299.8, 300.15]);
xlabel('X Position');
ylabel('Y Position');
title('Illustration of Gibbs phenomenon due to LPF');

set(gcf, 'PaperUnits', 'Inches', 'PaperPosition', [0 0 9 5]);
saveas(gcf, 'figures/fig3.png');
saveas(gcf, 'figures/fig3.eps');
close all;
