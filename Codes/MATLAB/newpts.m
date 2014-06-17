function [ out ] = newpts( pts )
% This is to scale the number of data points by a scale factor to discard
% extraneous points.
[n,m] = size(pts);
n = floor(n/3);
out = zeros(n,2);
m = 1;
for i = 1:n
    out(i,:) = pts(m,:);
    m = m + 3;
end

end

