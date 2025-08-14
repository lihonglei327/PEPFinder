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

        %shrink the observing zone
        bounds=[max([bounds1(1,:);bounds2(1,:)]);min([bounds1(2,:);bounds2(2,:)])];
        
        %shrink the sequences
        s1=s1(s1(:,1)>=bounds(1,1)  & s1(:,1)<=bounds(2,1) ,:);
        s2=s2(s2(:,1)>=bounds(1,1)  & s2(:,1)<=bounds(2,1) ,:);
        
        %refresh the bounds of sequences
        bounds1=[min(s1);max(s1)];
        bounds2=[min(s2);max(s2)];
       
        x_cross=min(bounds1(:,1))-max(bounds2(:,1))<0 && min(bounds2(:,1))-max(bounds1(:,1))<0;
        y_cross=prod(bounds2(:,2)-bounds1(:,2))<0;

        f=y_cross*x_cross;
    catch
        f=0;
    end    
end
