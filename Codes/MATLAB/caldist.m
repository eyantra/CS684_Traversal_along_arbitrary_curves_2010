function disp = caldist(pts)
% To calculate the appropriate displacements by which the robot should move
% at various points along the curve. Takes an array of points as input and
% calculates the displacment
[m,n] = size(pts);
a = pts(2:m,:);
b = pts(1:m-1,:);
disp = zeros(m-1,1);
for i = 1:m-1
    disp(i) = sum((a(i,:)-b(i,:)).^2)^0.5;
end