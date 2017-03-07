function [ind_list,time_list,loop_list] = analysis()
%%Loads in the tidied up data, which has been preprocessed.
%This comes in the format:
%   new_prof_vars: 1 by 1757 cell array in which
%                  each cell is the time series for that event. 
%   str_params: time data and loop ID in a 1757 by 2 matrix.
%   num_params: the max detuning and period in a 1757 by 2 matrix.

load('2-4data/processed23.mat');

%% Lets try to analyse cars going from E to G & H
% Step1. Normalise A, B Data in max detuning.
% step2. Seach forwards in time. Gotta convert time to some other number to
% directly compare it.

%Normalise E
for i=1:length(loopData(3).E)
    if max(loopData(3).E{i}) ~=0
        loopData(3).E{i} = loopData(3).E{i}./max(loopData(3).E{i});
    end
end

%Normalise G
for i=1:length(loopData(3).G)
    if max(loopData(3).G{i}) ~=0
        loopData(3).G{i} = loopData(3).G{i}./max(loopData(3).G{i});
    end
end

%Normalise H
for i=1:length(loopData(3).H)
    if max(loopData(3).H{i}) ~=0
        loopData(3).H{i} = loopData(3).H{i}./max(loopData(3).H{i});
    end
end


ind_list1(length(loopData(1).E)) = 0;
time_list1(length(loopData(1).E)) = 0;
min_list1(length(loopData(1).E)) = 0;
loop_list()

for i=1:length(loopData(1).E)
    
    [ind, time_diff,mini] = find_minH(loopData,i);

    ind_list1(i) = ind;
    time_list1(i) = time_diff;
    min_list1(i) = mini;
end

ind_list2(length(loopData(1).E)) = 0;
time_list2(length(loopData(1).E)) = 0;
min_list2(length(loopData(1).E)) = 0;

for i=1:length(loopData(1).E)
    
    [ind, time_diff,mini] = find_minG(loopData,i);

    ind_list2(i) = ind;
    time_list2(i) = time_diff;
    min_list2(i) = mini;
end

ind_list(length(loopData(1).E)) = 0;
time_list(length(loopData(1).E)) = 0;
min_list(length(loopData(1).E)) = 0;

for i=1:length(loopData(1).E)
    
    if min_list1(i) < min_list(i)
        min_list(i) = min_list1(i);
        ind_list(i) = ind_list1(i);
        time_list(i) = time_list1(i);
    else
        
        min_list(i) = min_list2(i);
        ind_list(i) = ind_list2(i);
        time_list(i) = time_list2(i);
    end
        


end
end

function [ind, time_diff, mini] = find_minH(loopData,DataPoint)

daysecs = 60*60*24;
DataPointTime = datenum(loopData(2).E{DataPoint});
DistVec = [length(loopData(3).E)];

for i=1:length(loopData(3).H)
    if DataPointTime < datenum(loopData(2).H{i})
        DistVec(i) = dtw(loopData(3).E{DataPoint}, loopData(3).H{i});
    else
        DistVec(i) = inf;
    end
end



[mini,ind] = min(DistVec);
   
time_diff =daysecs*(datenum(loopData(2).H{ind}) - DataPointTime);

end

function [ind, time_diff, mini] = find_minG(loopData,DataPoint)

daysecs = 60*60*24;
DataPointTime = datenum(loopData(2).E{DataPoint});
DistVec = [length(loopData(3).E)];

for i=1:length(loopData(3).G)
    if DataPointTime < datenum(loopData(2).G{i})
        DistVec(i) = dtw(loopData(3).E{DataPoint}, loopData(3).G{i});
    else
        DistVec(i) = inf;
    end
end



[mini,ind] = min(DistVec);
   
time_diff =daysecs*(datenum(loopData(2).G(ind)) - DataPointTime);

end