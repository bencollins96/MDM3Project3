function [ind_list,time_list] = analysis()
%%Loads in the tidied up data, which has been preprocessed.
%This comes in the format:
%   new_prof_vars: 1 by 1757 cell array in which
%                  each cell is the time series for that event. 
%   str_params: time data and loop ID in a 1757 by 2 matrix.
%   num_params: the max detuning and period in a 1757 by 2 matrix.

load('loopData56.mat');

%% Lets try to analyse cars going from A to B:
% Step1. Normalise A, B Data in max detuning.
% step2. Seach forwards in time. Gotta convert time to some other number to
% directly compare it.

%Normalise A
for i=1:length(loopData(3).A)
    if max(loopData(3).A{i}) ~=0
        loopData(3).A{i} = loopData(3).A{i}./max(loopData(3).A{i});
    end
end

%Normalise B
for i=1:length(loopData(3).B)
    if max(loopData(3).B{i}) ~=0
        loopData(3).B{i} = loopData(3).B{i}./max(loopData(3).B{i});
    end
end


ind_list(length(loopData(1).A)) = 0;
time_list(length(loopData(1).A)) = 0;

for i=1:length(loopData(1).A)
    
    [ind, time_diff] = find_min(loopData,i);

    ind_list(i) = ind;
    time_list(i) = time_diff;
end
    
string1 = 'The closest match to event %d is event %d and they are %d secs apart\n';
%fprintf(string1,DataPoint,ind,time_diff*daysecs);

% hold on
% plot(loopData(3).A{DataPoint});
% plot(loopData(3).B{ind});
  
end

function [ind, time_diff] = find_min(loopData,DataPoint)
daysecs = 60*60*24;
DataPointTime = datenum(loopData(2).A{DataPoint});
DistVec = [length(loopData(3).B)];

for i=1:length(loopData(3).B)
    if DataPointTime < datenum(loopData(2).B{i})
        DistVec(i) = dtw(loopData(3).A{DataPoint}, loopData(3).B{i});
    else
        DistVec(i) = inf;
    end
end

[~,ind] = min(DistVec);

time_diff =daysecs*(datenum(loopData(2).B{ind}) - DataPointTime);

end