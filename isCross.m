% this function checks whether two sequences are intersected
% Parameters:
% - s1,s2: two sequences
% Return 1 if intersected else 0.

% author: Dr. Honglei Li
% ver: 1.0
% date: 2025.05.13

function f=isCross(s1,s2)
    f=0;
    try
        bounds1=[min(s1);max(s1)];
        bounds2=[min(s2);max(s2)];
        y_cross=prod(bounds2(:,2)-bounds1(:,2))<0;
        x_cross=min(bounds1(:,1))-max(bounds2(:,1))<0 && min(bounds2(:,1))-max(bounds1(:,1))<0;
        f=y_cross*x_cross;
    catch
        f=0;
    end    
end
