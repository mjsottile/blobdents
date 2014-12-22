function n = bdtest(im)

  im = im > 0;
  indentsBinaryImage = double(bwconvhull(im)) - double(im);
  [lblIm, numIndent] = bwlabel(indentsBinaryImage);
  
  figure;
  imagesc(indentsBinaryImage);
  
  n = numIndent;