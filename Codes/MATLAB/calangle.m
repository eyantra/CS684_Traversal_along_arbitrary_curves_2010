function th = calangle(pts)
% This function calculates the angles by which the robot is required to 
% turn at the successive points along its path. It takes an array of points
% as input and returns an array of angles.
[n, m] = size(pts);
z = zeros(n,1);
for i = 1:n
    theta = atan2(pts(rem(i,n)+1,2)-pts(i,2),pts(rem(i,n)+1,1)-pts(i,1));
    if theta < 0
        z(i) = theta + 2*pi;
    else
        z(i) = theta;
    end
end
ang = zeros(n+1,1);
ang(1) = 0;
for i = 2:n+1
    theta = z(rem(i-1,n)+1) - z(i-1);
    if theta > pi
        theta = theta - 2*pi;
    elseif theta < -pi
        theta = theta + 2*pi;
    end
    ang(i) = theta;
end
th = (180/pi)*ang(1:n-1);




end
