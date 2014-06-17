function out = lemost(im)
% To extract the starting point of the curve
[m,n] = size(im);
flag = 0;
for (j = 1:n)
    for (i = 1:m)
        if (im(i,j) == 0)
            out = [i,j];
            flag = 1;
            break;
        end
    end
    if (flag == 1)
        break;
    end
end