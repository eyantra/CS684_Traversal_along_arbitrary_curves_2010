function [ list ] = coord( pixlist, siz )
% Calculates the coordinates of the points from the pixellist generated by
% the bwconncomp function
m = siz(1);
n = siz(2);
[k, l] = size(pixlist);
list = zeros(k,2);
for i = 1:k
    y = ceil(pixlist(i)/m);
    x = rem(pixlist(i),m);
    if (x == 0)
        x = m;
    end
    list(i,:) = [x,y];
end
end

