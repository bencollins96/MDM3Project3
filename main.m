%% The main code.

filename =  'Data/loop_data_20170206-1700to1800.csv';

%% Extract Data
% Extract as in first part of preprocessing then merge preprocessing and
% normalise together.

[prof_vals, str_params,num_params] = Extract(filename);

fprintf('Extracting the Data...\n');


%% Preprocessing, load up the data into a more friendly format.
%This is not normalised and in the form:
%   loopData(Parameter).LOOP{Datapoint}

[loopData,ord_num] = preprocessing(prof_vals,str_params,num_params);

fprintf('Processing the Data...\n');

%% Normalise the data into a more analysis friendly format.
% Now all data points are 100 long. 

norm_loopData = normalise(loopData); %Now its a cell array
fprintf('Normalising the Data...\n');


%% Classify the data so its easier to search through and less noisy.
% Decision Tree or PCA. Put in both and choose. These both work on the
% unnoormalised data.
PCA = 1;
if PCA
    Class = PrincipleComponentModel2(prof_vals,str_params,num_params);
    fprintf('Cla    ssifying buses and cars with PCA and KMeans..\n');
else 
    Class = decisionTreeModel2(prof_vals,str_params,num_params);
    fprintf('Classifying buses and cars with a Decision Tree...\n');
end

%Assign Classes to the loops.

disp(ord_num);

    


%% Find the most likely match for each event from our tidied up data.
% Based on : DTW, Uniformity + a weighting function for the time?

%% Plot the Time differences.
% look at the curve thing and see if it is better? if the average is closer
% to 20.