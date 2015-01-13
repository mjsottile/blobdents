d=dir('*.jpg');
for i=1:length(d)
    im{i}=imread(d(i).name);
end

g{1} = rgb2gray(im{1}) > 120;
g{2} = im{2}(:,:,3) > 120;
g{3} = im{3}(:,:,1) > 140;
g{4} = im{4}(:,:,1) > 150;
g{4}(255:260,1575:1700) = 0;
g{4}(260:300,1632:1640) = 0;
g{5} = rgb2gray(im{5}) > 120;

for i=1:5
    CC = bwconncomp(g{i});
    BW{i} = zeros(size(g{i}));
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [biggest,idx] = max(numPixels);
    BW{i}(CC.PixelIdxList{idx}) = 1;
    B = bwboundaries(BW{i});
    bd{i} = B{1};    
%    subplot(2,3,i);plot(bd{i}(:,2),bd{i}(:,1));
end

