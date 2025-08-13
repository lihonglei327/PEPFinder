% This function return the phase equilibrium pairs
% from the dataset derived from DFT 
% Parameters:
% - fp: filepath of dataset plain file in which data are separated by comma
% - epsilon: distance error threshold of chemical potential pairs 
% - omega: neighbor radius of chemical potential pairs
% - delta: minimal interval of indices of chemical potential pairs in the
% data sequence
% - kappa: display switch 

% The Output: indices of pairs.The first pair is the best one.

% author: Dr. Honglei Li
% ver: 1.0
% date: 2025.05.30


function pairs=checkPoints(fp,epsilon,omega,delta,kappa)  
    pairs =[];
    Pts =[];
    try
        Pts =readmatrix(fp);
        Pts =Pts(:,1:2);
    end
    % if read file error then return
    if size(Pts,1)<1 || size(Pts,2)<2        
        return;
    end

    % segment the pair data into subsequence in different direction
    seg_indices=segmentByTrend(Pts);
    if kappa
        figure(3);
        clf;
        for i=1:size(seg_indices,1)
            plot(Pts(seg_indices(i,1):seg_indices(i,2),1),Pts(seg_indices(i,1):seg_indices(i,2),2),'-o');        
            hold on;
        end
        % mark the start
        scatter(Pts(1,1),Pts(1,2),20,'o','filled');
        hold on;
    end

    if(~exist('epsilon','var'))
        epsilon=1e-2;
    end

    if(~exist('kappa','var'))
        kappa=false;
    end
    
    if(~exist('omega','var'))
        omega=5;
    end

    if(~exist('delta','var'))
        delta=3;
    end

    indX=[];
    indY=[];
    % the number of points
    N=size(Pts,1);
    if N<4
        pairs=[];
        return;
    end
    distances =NaN(size(Pts,1),size(Pts,1));
    N=size(seg_indices,1);
    for i=1:N-1
        start_point1=seg_indices(i,1);
        end_point1=seg_indices(i,2);
        MUs1 =Pts(start_point1:end_point1,1:2);
        for j=i+1:N
            start_point2=seg_indices(j,1);
            end_point2=seg_indices(j,2);
            MUs2 =Pts(start_point2:end_point2,1:2);

            if(isCross(MUs1,MUs2))
                dis= pdist2(MUs1,MUs2);
                dis(dis>=epsilon)=nan;
                distances(start_point1:end_point1,start_point2:end_point2)=dis;
            end
        end
    end
        
    [minDistance, index] = min(distances);    
    idxY=find(minDistance<epsilon);
    %idxY=idxY(1:ceil(length(idxY)/2));
    idxX=index(idxY); 

    % [idxX,idxY]=find(~isnan(distances));

    [~,index] = sort(abs(idxX-idxY),'descend');
    
    idxY=idxY(index);
    idxX=idxX(index);
    
    for i=1:size(idxX,2)
        x1=idxX(i);
        y1=idxY(i);
        pairs=[pairs;[x1,y1]];                    
        if kappa
            figure(3);
            scatter([Pts(x1,1),Pts(y1,1)],[Pts(x1,2),Pts(y1,2)],20,'o','filled');
            hold on;
        end
    end
end