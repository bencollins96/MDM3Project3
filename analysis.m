function [] = analysis( )

%Loads in the tidied up data, which has been preprocessed.
%This comes in the format:
%   new_prof_vars: 1 by 1757 cell array in which
%       each cell is the time series for that event. 
%   str_params: time data and loop ID in a 1757 by 2 matrix.
%   num_params: the max detuning and period in a 1757 by 2 matrix.

load('Copy of loop_data_20170207-0210to0310.mat');

time_stamp = str_params(:,1);
loop_id = str_params(:,2);
max_detuning = num_params(:,1);
profile_length = num_params(:,2);
sample_period = num_params(:,3);


%% Detuning and interpolation a specific example
    % this should be easyish to loop through and do for all but I wanted to
    % see if its correct before doing that.
    
    % grabbing two data points and the other values needed
    datapoint1 = 137;
    profile_values_matrix1 = cell2mat(new_prof_vals(datapoint1));
    sample_period1 = sample_period(datapoint1);
    profile_length1 = profile_length(datapoint1);
    max_detuning1 = max_detuning(datapoint1);
    
    datapoint2 = 30;
    profile_values_matrix2 = cell2mat(new_prof_vals(datapoint2));
    sample_period2 = sample_period(datapoint2);
    profile_length2 = profile_length(datapoint2);
    max_detuning2 = max_detuning(datapoint2);
    
    
    %plot to get an idea of what they originally look like (0-255)
%     figure;
%     hold on;
%     dtw(profile_values_matrix1,profile_values_matrix2);
    
    %% Detune the profile values 
    % assumes going from range 0-255 to 0-maxdetune
    profile_values_matrix1 = (profile_values_matrix1.*max_detuning1)./255;
    profile_values_matrix2 = (profile_values_matrix2.*max_detuning2)./255;
    
    
    % plot the detuned values to see whats changed (0-maxdetune)
%     figure;
%     hold on;
%     dtw(profile_values_matrix1,profile_values_matrix2);
    
    %% Interpolating the profile values
    %  This may not be needed, its done under the assumption that we are
    %  missing datapoints between each profile value. So interpolating
    %  between with linear or spline interpolation could potentially give
    %  better results. This is something we should probably look at but
    %  whether or not its neccesary is another story... My guess would be
    %  that where there is only a low amount of profile values
    %  interpolation could be used to improve results
    
    time1 = 1:profile_length1;
    interp_time1 = 1:(1/sample_period1):profile_length1;
    interp_profile_values_1 = interp1(time1,profile_values_matrix1,interp_time1,'spline');
    
    % Plot to see whats changes 
    figure
    hold on;
    plot(time1,profile_values_matrix1)
    plot(time1,profile_values_matrix1,'o',interp_time1,interp_profile_values_1,':.');
    title('Profile values plotted against its interpolated values')
    

end

