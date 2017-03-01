function [index,mini, loop] =  likely_match(DataPt, class_cell, norm_loopData, loops, data_cell)
%Number of the data pt, 
%class_cell, list of which type each data pt is. 
%norm_loopData, the data to be compared against.
%loops - the loops involved [loop of datapt,loop1 to compare,loop2 to compare]

CurrentLoop = loops(1);
Event = norm_loopData{CurrentLoop}(DataPt,:);
EventClass = class_cell{CurrentLoop}(DataPt);
EventStartTime = datenum(data_cell{CurrentLoop}(DataPt));

if length(loops) == 1
    
    dtw_list = [];
    
elseif length(loops) ==2

    dtw_list = find_dtw(norm_loopData,Event,EventClass,loops(2),class_cell,EventStartTime, data_cell);
    
    [mini,index] = min(dtw_list);
    loop = loops(2);
    
    %disp(dtw(Event, norm_loopData{loop}(index,:)))
 
elseif length(loops) ==3

    dtw_list1 = find_dtw(norm_loopData,Event,EventClass,loops(2),class_cell, EventStartTime,data_cell);
    [min1,index1] = min(dtw_list1);
    dtw_list2 = find_dtw(norm_loopData,Event,EventClass,loops(3),class_cell,EventStartTime, data_cell);
    [min2,index2] = min(dtw_list2);
    
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
end




