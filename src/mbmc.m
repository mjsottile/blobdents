function n = mbmc(im)

    dt = 0.96;
    
    w = 11;
    [xs,ys] = ndgrid(1:w,1:w);
    
    xs = xs - (ceil(w/2));
    ys = ys - (ceil(w/2));
    
    x = sqrt(xs.^2 + ys.^2);
    
    kern = (1/(4*pi*dt)).*exp((-1/4*dt) .* (x.^2));
    
    i=0;
    keepGoing = 1;
    while (keepGoing == 1)
        imold = im;
        imnew = conv2(double(im),kern,'same');
        im = imnew > 0.5;
        if (sum(im(:)-double(imold(:))) == 0)
            keepGoing = 0;
        end
        imagesc(im);
        drawnow;
        pause(0.1)
        i=i+1;
    end
    