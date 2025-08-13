% This function return the segments of chemical potential pairs in
% different trends
% Parameters:
% - Pts: chemical potential pairs 
% The Output: the list of first and last indices in the segmented sub-sequences of chemical potential pairs

% author: Dr. Honglei Li
% ver: 1.0
% date: 2025.05.30
function seg_indices = segmentByTrend(Pts)
    direction=diff(Pts,1,1);
    direction(direction>=0)=1;
    direction(direction<0)=-1;
    start=1;
    seg_indices=[];
    for i=2:size(direction,1)
        if isequal(direction(start,:),direction(i,:))
            continue;
        else
            seg_indices=[seg_indices;[start,i]];
            start=i;
        end
    end
    seg_indices=[seg_indices;[start,i+1]];
    seg_indices(2:end,1)=seg_indices(2:end,1)+1;
end