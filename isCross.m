% this function checks whether segment(p1,p2) is intersected with segment(p3,p4)
% Parameters:
% - p1,p2,p3,p4: chemical potential pairs
% - kappa: display switch 
% Return 1 if intersected else 0.

% author: Dr. Honglei Li
% ver: 1.0
% date: 2025.04.30

function f=isCross(p1,p2,p3,p4,kappa)
    f=0;
    x1=p1(1);
    y1=p1(2);
    x2=p2(1);
    y2=p2(2);
    x3=p3(1);
    y3=p3(2);
    x4=p4(1);
    y4=p4(2);

    if(~exist('eps','var'))
        eps=1e-6;
    end
    t=nan;
    s=nan;
    p0=[];
    d=nan;
    cosine=nan;
    try
        t=((x3-x1)*(y4-y3)-(y3-y1)*(x4-x3))/((x2-x1)*(y4-y3)-(y2-y1)*(x4-x3));
        s=((x3-x1)*(y2-y1)-(y3-y1)*(x2-x1))/((x2-x1)*(y4-y3)-(y2-y1)*(x4-x3));
        
        if t>0 && t<1 && s>=0 && s<=1
            %[t,s]
            p0=[x1+t*(x2-x1),y1+t*(y2-y1)];
            %判断焦点的共线
            x0=p0(1);
            y0=p0(2);
            
            cosine=abs((p1-p0)*(p3-p0)'/norm(p1-p0)/norm(p3-p0));
            d=min(pdist2(p0,[p1;p2;p3;p4]));

            if cosine<0.9 && d>eps
                f=1;
                if kappa 
                    figure(3);
                    scatter([x1,x2],[y1,y2],100,'o','filled');
                    title("Chemical potential pairs");
                    xlabel("Chemical potential 1");
                    ylabel("Chemical potential 2");                    
                    hold on;
                    scatter([x3,x4],[y3,y4],50,'o','filled');
                    hold on;
                    % mark the intersect
                    scatter(x0,y0,100,'^','filled');
                    hold on;                    
                    drawnow;
                end
            end
        end
    catch
        f=0;
    end    
end
