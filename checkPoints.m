% This function return the phase equilibrium pairs
% from the dataset derived from DFT 
% Parameters:
% - fp: filepath of dataset plain file in which data entries are separated by comma
% - epsilon: distance error threshold of chemical potential pairs.1e-2(default) 
% - omega: neighborhood radius of chemical potential pair. 5 (default)
% - delta: minimal interval of indices of chemical potential pairs in the sequentially ordered dataset. 3(default)
% - kappa: display the scatter plot if true(default)
% - kappa: display switch 

% The Output: indices of pairs.The first pair is the ideal one.

% author: Dr. Honglei Li
% ver: 1.0
% date: 2025.04.30


function pairs=checkPoints(fp,epsilon,omega,delta,kappa)  

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

    pairs =[];

    Pts =[];
    try
        Pts =readmatrix(fp);
    end
    % if read file error then return
    if size(Pts,1)<1 || size(Pts,2)<2
        
        return;
    end

    if kappa
        figure(3);
        clf;
        plot(Pts(:,1),Pts(:,2),'-o');     
        title("Chemical potential pairs");
        xlabel("Chemical potential 1");
        ylabel("Chemical potential 2");                       
        hold on;
        % mark the start
        scatter(Pts(1,1),Pts(1,2),20,'o','filled');
        hold on;
    end

    indX=[];
    indY=[];
    % the number of points
    N=size(Pts,1);
    if N<4
        pairs=[];
        return;
    end

    % chemical potential pairs
    MUs =Pts(:,1:2);

    % distances of chemical potential pairs excluding their delta neighborhood
    distances = pdist2(MUs,MUs);
    %distances(logical(eye(size(distances)))) = nan;
    for i=1:size(MUs,1)
        distances(i,[i:min(i+delta,size(MUs,1))])=nan;
        distances([i:min(i+delta,size(MUs,1))],i)=nan;
    end

    % filter out invalid chemical potential pairs
    [minDistance, index] = min(distances);    
    idxY=find(minDistance<epsilon);
    idxY=idxY(1:ceil(length(idxY)/2));
    idxX=index(idxY); 

    % longer interval priority
    [~,index] = sort(abs(idxX-idxY),'descend');
    
    idxY=idxY(index);
    idxX=idxX(index);

    if size(idxX,1)<1 
        return;
    end      

    for i=1:size(idxX,2)
        x1=idxX(i);
        y1=idxY(i);

        if abs(x1-y1)<delta
            continue;
        end

        found=false;
        for x2=max(x1-omega+1,1):min(x1+omega-1,size(MUs,1))
            if x2==x1 
                continue;
            end

            % 2 subsequences interlinked
            if (x2==y1) 
                break;
            end

            for y2=max(y1-omega+1,1):min(y1+omega-1,size(MUs,1))
                if y2==y1
                    continue;
                end

                % 2 subsequences overlapped
                if (min(x1,x2)<=y2 && y2<=max(x1,x2)) || (min(y1,y2)<=x2 && x2<=max(y1,y2))
                    break;
                end
                
                try
                    crossed=isCross(MUs(y1,:),MUs(y2,:),MUs(x1,:),MUs(x2,:),kappa);
                    if crossed 
                        found=true;
                        break;
                    end
                catch
                    found=false;
                end
            end
            if found
                break;
            end
        end
        
        if found 
           pairs=[pairs;[x1,y1]];                    
        end
    end
end