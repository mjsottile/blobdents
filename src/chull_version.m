% code for blob dent counting using convex hull stuff
function n = chull_version(im)

    % make sure no holes in image
    fim = imfill(im, 'holes');

    % calculate convex hull of filled image
    imhull = bwconvhull(fim);
    
    % calculate difference
    difference = imhull - fim;
    
    subplot(1,3,1);
    imagesc(fim);
    subplot(1,3,2);
    imagesc(imhull);
    subplot(1,3,3);
    imagesc(difference);

end
