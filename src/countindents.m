%
% quick and dirty demonstration of using curvature to identify
% indentations in a lumpy binary image.
%
% matthew sottile / mjsottile@gmail.com
% jan. 2013
%
%
% input: 
%   - bw image, 
%   - filter size (e.g., 25 - how many Fourier components to 
%     toss out for crude LPF).
%   - threshold for curvature 0 crossing detection.  e.g., 0.001
%
% output: 
%   - number of indentations
%
function [n, k, filt_xs, filt_ys] = countindents(im, filtsize, thresh)

no_plotting = 1;

% find the boundary of the shape as a sequence of x,y values
[b,l] = bwboundaries(im,8);

% assume we only have one boundary
b1 = b{1};

% get x and y components
x = b1(:,2);
y = b1(:,1);

% take the fft of each component
xs = fft(x);
ys = fft(y);

% computing FFT-based derivative:
% http://www.mathworks.co.uk/matlabcentral/answers/16141
% and 
% http://math.mit.edu/~stevenj/fft-deriv.pdf
nx = length(xs);
hx = ceil(nx/2)-1;
ftdiff = (2i*pi/nx)*(0:hx);
ftdiff(nx:-1:nx-hx+1) = -ftdiff(2:hx+1);
ftddiff = (-(2i*pi/nx)^2)*(0:hx);
ftddiff(nx:-1:nx-hx+1) = ftddiff(2:hx+1);

% remove high frequency components with crude low pass filter.  high
% frequency components are bad since they are sensitive to the
% discretization of the curve around the shape.
if filtsize > 0 
    xs(filtsize:end-(filtsize-1)) = 0;
    ys(filtsize:end-(filtsize-1)) = 0;
end

% compute the derivative and second derivative of the curve using the
% fft-based derivative.
dx = real(ifft(xs.*ftdiff'));
dy = real(ifft(ys.*ftdiff'));
ddx = real(ifft(xs.*ftddiff'));
ddy = real(ifft(ys.*ftddiff'));

% approximate curvature:  http://en.wikipedia.org/wiki/Curvature
%k = sqrt((ddy.*dx - ddx.*dy).^2) ./ ((dx.^2 + dy.^2).^(3/2));
k = (ddy.*dx - ddx.*dy) ./ ((dx.^2 + dy.^2).^(3/2));

%
% plotting useful during debugging:
% 

% figure;
% plot(x,y,'r');
% hold on;
% plot(real(ifft(xs)),real(ifft(ys)),'g');
% hold off;
% 
% 
% figure;
% plot(real(ifft(xs)),real(ifft(ys)),'r');
% hold on;
% jmp = 2;
% quiver(b1(1:jmp:end,2),b1(1:jmp:end,1),dx(1:jmp:end).*100,dy(1:jmp:end).*100);
% quiver(b1(1:jmp:end,2),b1(1:jmp:end,1),ddx(1:jmp:end).*100,ddy(1:jmp:end).*100,'c');
% plot(real(ifft(xs)),real(ifft(ys)),'r');
% hold off;

filt_xs = real(ifft(xs));
filt_ys = real(ifft(ys));

if no_plotting ~= 1
    figure;

    sk = sign(k);
    pos = find(sk==1);
    neg = find(sk==-1);
    plot(filt_xs(pos),filt_ys(pos),'b.');
    hold on;
    plot(filt_xs(neg),filt_ys(neg),'r.');
    hold off;

    figure;
    for i = 1:length(k)

    subplot(1,2,1);
    plot(filt_xs,filt_ys,'b');
    hold on;
    plot(filt_xs(i),filt_ys(i),'ro');
    hold off;

    subplot(1,2,2);
    plot(k);
    set(gca,'XLim',[1 length(k)]);
    title('Curvature');
    xlabel('Position along curve');
    ylabel('k');
    hold on;
    plot(i,k(i),'ro');
    hold off;

    drawnow;
    end 
end

%% since curvature is not signed, assume when we get real close to zero,
%% that is a place where the curvature passes through zero in the signed
%% version.  this is a hack and should be fixed.
%pts = find(k < thresh);
%dpts = diff(pts);
%n = (length(find(abs(dpts) > 1))+1)/2;

% signed curvature -> look for sign changes
pts = sign(k);
dpts = diff(pts);
n = (length(find(abs(dpts) > 1)))/2;