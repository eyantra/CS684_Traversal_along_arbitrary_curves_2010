function [ out ] = extractpath(im)
%This function extracts the connected points from a given image
% im and outputs an array of points as output.
out = [];
nim = ~im;
nim = bwmorph(nim,'thin',Inf);
im = ~nim;
t = lemost(im);
t = [t, 0];
v = zeros(size(im));
while (t(3) ~= 1)
    [t, v] = newnext(im, t, v);
    s = [t(1), t(2)];
    out = [out; s];
end
end

