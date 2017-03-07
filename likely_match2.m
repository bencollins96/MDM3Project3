%%Likely match 2!

function [index,mini, loop] =  likely_match2(DataPt, class_cell, loops, data_cell)
%Number of the data pt, 
%class_cell, list of which type each data pt is. 
%norm_loopData, the data to be compared against.
%loops - the loops involved [loop of datapt,loop1 to compare,loop2 to compare]
%Distmeasure - 1 = dtw, 0 = uniformity

CurrentLoop = loops(1);
EventClass = class_cell{CurrentLoop}(DataPt);
EventStartTime = datenum(data_cell{CurrentLoop}(DataPt));

if EventClass ~=2   
    index = NaN;
    mini = NaN;
    loop = NaN;
    return 
end



if length(loops) == 1
    index = NaN;
    mini = NaN;
    loop = NaN;
elseif length(loops) == 2
    
    time_l = zeros(length(class_cell{loops(2)}),1);
    
    for i=1:length(class_cell{loops(2)})
        right_class = (class_cell{loops(2)}(i) == 2);
        time_diff = (datenum(data_cell{loops(2)}(i)) - EventStartTime);

        if right_class && ((time_diff) > 0)
            time_l(i) = time_diff;
        else 
            time_l(i) = NaN;
        end
    end
    [mini,index] = min(time_l);

else 
    time_l1 = zeros(length(class_cell{loops(2)}),1);
    
    for i=1:length(class_cell{loops(2)})
        right_class = (class_cell{loops(2)}(i) == 2);
        time_diff = (datenum(data_cell{loops(2)}(i)) - EventStartTime);
   
        
        if (right_class && (time_diff > 0))
            %fprintf('Time difference %d, and class %d\n',time_diff,right_class);
            
            time_l1(i) = time_diff;
            
        else 
            time_l1(i) = NaN;
        end
    end
    
    time_l2 = zeros(length(class_cell{loops(3)}),1);
    
    for i=1:length(class_cell{loops(3)})
        right_class = (class_cell{loops(3)}(i) == 2);

        time_diff = (datenum(data_cell{loops(3)}(i)) - EventStartTime);
        
        if right_class && ((time_diff) > 0)
            %fprintf('2... Time difference %d, and class %d\n',time_diff,right_class);
            time_l2(i) = time_diff;
        else 
            time_l2(i) = NaN;
        end
    end
        
    [mini1,index1] = min(time_l1);
    [mini2,index2] = min(time_l2);
    
    if mini1 < mini2
        mini = mini1;
        
        index = index1;
        loop = loops(2);
    else 
        mini = mini2;
        index = index2;
        loop = loops(3);
    end


    
end



            
            
            
        



