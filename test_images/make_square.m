function x = make_square(h,sh)

    x = zeros(h,h);
    lo = (h-sh)/2;
    hi = h-lo;
    x(lo:hi,lo:hi) = 1;
    
    