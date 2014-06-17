function [ out, nv ] = newnext( a, start, v )
% Calculates the next point of the path from the image data
m = start(1);
n = start(2);
v(m,n) = 1;
complete = start(3);
for i = 1:4
    if (a(m+1,n+1) == 0 && v(m+1,n+1) == 0)
        m = m + 1;
        n = n + 1;
        v(m,n) = 1;
    elseif (a(m,n+1) == 0 && v(m,n+1) == 0)
        m = m;
        n = n+1;
        v(m,n) = 1;
    elseif (a(m-1,n+1) == 0 && v(m-1,n+1) == 0)
        m = m - 1;
        n = n + 1;
        v(m,n) = 1;
    elseif (a(m+1,n) == 0 && v(m+1,n) == 0)
        m = m + 1;
        n = n;
        v(m,n) = 1;
    elseif (a(m+1,n-1) == 0 && v(m+1,n-1) == 0)
         m = m + 1;
         n = n - 1;
         v(m,n) = 1;
    elseif (a(m,n-1) == 0 && v(m,n-1) == 0)
         m = m;
         n = n-1;
         v(m,n) = 1;
    elseif (a(m-1,n-1) == 0 && v(m-1,n-1) == 0)
         m = m - 1;
         n = n - 1;
         v(m,n) = 1;
    elseif (a(m-1,n) == 0 && v(m-1,n) == 0)
         m = m - 1;
         n = n;
         v(m,n) = 1;
    else
        complete = 1;
        break;
    end
end
out = [m, n, complete];
nv = v;

end

