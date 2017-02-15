function [dtwdist] = analysis()
%%Loads in the tidied up data, which has been preprocessed.
%This comes in the format:
%   new_prof_vars: 1 by 1757 cell array in which
%                  each cell is the time series for that event. 
%   str_params: time data and loop ID in a 1757 by 2 matrix.
%   num_params: the max detuning and period in a 1757 by 2 matrix.

load('Copy of loop_data_20170207-0210to0310.mat');

new_prof_vals = sam_prof_vals; %Just a name change... 
time_stamp = str_params(:,1);
loop_id = str_params(:,2);
max_detuning = num_params(:,1);
profile_length = num_params(:,2);
sample_period = num_params(:,3);



%%Normalise the data

for i=1:length(new_prof_vals)
    if max(new_prof_vals{i}) ~= 0 %Normalise the data but watch for 0 data points
        new_prof_vals{i} = new_prof_vals{i}./max(new_prof_vals{i});
    end
end
    
    
%% Calculate pairwise dtw distance for all data
% Horrible, so many loops and if's.
dtwdist = zeros(length(new_prof_vals));
for i=1:length(new_prof_vals)
    for j = 1:length(new_prof_vals)
        if i== j
            dtwdist(i,j) = inf;
        else
            dtwdist(i,j) = dtw(new_prof_vals{i},new_prof_vals{j});
        end
    end
end

return

    %% Interpolating the profile values: MOVED INTO PREPROCESSING
    %  This may not be needed, its done under the assumption that we are
    %  missing datapoints between each profile value. So interpolating
    %  between with linear or spline interpolation could potentially give
    %  better results. This is something we should probably look at but
    %  whether or not its neccesary is another story... My guess would be
    %  that where there is only a low amount of profile values
    %  interpolation could be used to improve results
    
%     
%     time1 = 1:profile_length1;
%     interp_time1 = 1:(1/sample_period1):profile_length1;
%     interp_profile_values_1 = interp1(time1,profile_values_matrix1,interp_time1,'spline');
%       
%     % Plot to see whats changes 
%     figure
%     hold on;
%     plot(time1,profile_values_matrix1)
%     plot(time1,profile_values_matrix1,'o',interp_time1,interp_profile_values_1,':.');
%     title('Profile values plotted against its interpolated values')
    




