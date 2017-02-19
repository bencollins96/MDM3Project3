function [ind_list,time_list] = analysis()
%%Loads in the tidied up data, which has been preprocessed.
%This comes in the format:
%   new_prof_vars: 1 by 1757 cell array in which
%                  each cell is the time series for that event. 
%   str_params: time data and loop ID in a 1757 by 2 matrix.
%   num_params: the max detuning and period in a 1757 by 2 matrix.

load('loopData');

% num, str,prof.


% new_prof_vals = sam_prof_vals; %Just a name change... 
% time_stamp = str_params(:,1);
% loop_id = str_params(:,2);
% max_detuning = num_params(:,1);
% profile_length = num_params(:,2);

% sample_period = num_params(:,3);


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

%Compare one value in A with all in B. Dodgily incorporate time...
% DataPoint = 100;
% DataPointTime = datenum(loopData(2).A{DataPoint});
% DistVec = [length(loopData(3).B)];
% for i=1:length(loopData(3).B)
%     if DataPointTime < datenum(loopData(2).B{i})
%         DistVec(i) = dtw(loopData(3).A{DataPoint}, loopData(3).B{i});
%     else 
%         DistVec(i) = inf;
%     end
% end

ind_list(length(loopData(1).A)) = 0;
time_list(length(loopData(1).A)) = 0;

for i=length(loopData(1).A):length(loopData(1).A)
    
    [ind, time_diff] = find_min(loopData,i);
    ind_list(i) = ind;
    time_list(i) = time_diff;
end
    

daysecs = 60*60*24;
string1 = 'The closest match to event %d is event %d and they are %d secs apart\n';
%fprintf(string1,DataPoint,ind,time_diff*daysecs);

% hold on
% plot(loopData(3).A{DataPoint});
% plot(loopData(3).B{ind});
  
    
%% Calculate pairwise dtw distance for all data
% Horrible, so many loops and if's.
% dtwdist = zeros(length(new_prof_vals));
% for i=1:length(new_prof_vals)
%     for j = 1:length(new_prof_vals)
%         if i== j
%             dtwdist(i,j) = inf;
%         else
%             dtwdist(i,j) = dtw(new_prof_vals{i},new_prof_vals{j});
%         end
%     end
% end
% 
% return

end

function [ind, time_diff] = find_min(loopData,DataPoint)

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

time_diff = datenum(loopData(2).B{ind}) - DataPointTime;

end