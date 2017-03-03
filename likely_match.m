function [index,mini, loop] =  likely_match(DataPt, class_cell, norm_loopData, loops, data_cell,dist_measure)
%Number of the data pt, 
%class_cell, list of which type each data pt is. 
%norm_loopData, the data to be compared against.
%loops - the loops involved [loop of datapt,loop1 to compare,loop2 to compare]
%Distmeasure - 1 = dtw, 0 = uniformity

CurrentLoop = loops(1);
Event = norm_loopData{CurrentLoop}(DataPt,:);
EventClass = class_cell{CurrentLoop}(DataPt);
EventStartTime = datenum(data_cell{CurrentLoop}(DataPt));

if EventClass ~=2
    index = NaN;
    mini = NaN;
    loop = NaN;
    return 
end


if length(loops) == 1
    
    dist_list = [];
    
elseif length(loops) ==2
    if dist_measure
        dist_list = find_dtw(norm_loopData,Event,EventClass,loops(2),class_cell,EventStartTime, data_cell);
    else 
        dist_list = find_uni_list(norm_loopData,Event,EventClass,loops(2),class_cell,EventStartTime, data_cell);
    end
    [mini,index] = min(dist_list);
    loop = loops(2);
    
    %disp(dtw(Event, norm_loopData{loop}(index,:)))
 
elseif length(loops) ==3
    if dist_measure
        dist_list1 = find_dtw(norm_loopData,Event,EventClass,loops(2),class_cell, EventStartTime,data_cell);
        [min1,index1] = min(dist_list1);
        
        dist_list2 = find_dtw(norm_loopData,Event,EventClass,loops(3),class_cell,EventStartTime, data_cell);
        [min2,index2] = min(dist_list2);
    else 
        
        disp('WHAT THE FUCK');
        dist_list1 = find_uni_list(norm_loopData,Event,EventClass,loops(2),class_cell, EventStartTime,data_cell);
        [min1,index1] = min(dist_list1);
        
        dist_list2 = find_uni_list(norm_loopData,Event,EventClass,loops(3),class_cell,EventStartTime, data_cell);
        [min2,index2] = min(dist_list2);
    end
    if min1 < min2 
        index = index1;
        loop = loops(2);
        mini = min1;
    else 
        index = index2;
        loop = loops(3);
        mini = min2;
    end  
end

if mini == inf
    mini = NaN;
end
        
function dtw_list = find_dtw(norm_loopData,Event,EventClass,loop_num,class_cell, EventStartTime,data_cell)
 
    dtw_list= zeros(length(norm_loopData{loop_num}),1);
    
    %Loop through all Events in successor loop.
    for i=1:length(norm_loopData{loop_num})
       
        EventStartTime_test = datenum(data_cell{loop_num}(i));
        TestEvent = norm_loopData{loop_num}(i,:);
    
        if (class_cell{loop_num}(i) == EventClass) &&  EventStartTime < EventStartTime_test
            dtw_list(i) = dtw(Event,TestEvent);
        else
            dtw_list(i) = inf;
        end
    end
end

function uni_list = find_uni_list(norm_loopData,Event,EventClass,loop_num,class_cell, EventStartTime,data_cell)
 
    uni_list= zeros(length(norm_loopData{loop_num}),1);
    
    %Loop through all Events in successor loop.
    for i=1:length(norm_loopData{loop_num})
       
        EventStartTime_test = datenum(data_cell{loop_num}(i));
        TestEvent = norm_loopData{loop_num}(i,:);
    
        if (class_cell{loop_num}(i) == EventClass) &&  EventStartTime < EventStartTime_test
            uni_list(i) = find_uni(Event,TestEvent);
        else
            uni_list(i) = inf;
        end
    end
    
    
    function uni = find_uni(Event, TestEvent)
        
        uni = 0;
        for j=1:length(Event)
            uni = uni + min([Event(j),TestEvent(j)])/max([Event(j),TestEvent(j)]);
        end
        
        %To make a valid distance measure... i.e. smaller = closer
        uni = 1/uni;
    end
    
end
        


end




