%% The main code.

filename =  'Copy of loop_data_20170206-1400to1500.csv';

%% Extract Data
% Extract as in first part of preprocessing then merge preprocessing and
% normalise together.

fprintf('Extracting the Data...\n');
[prof_vals, str_params,num_params] = Extract(filename);

%% Preprocessing, load up the data into a more friendly format.
%This is not normalised and in the form:
%   loopData(Parameter).LOOP{Datapoint}

fprintf('Processing the Data...\n');
[loopData,ord_num] = preprocessing(prof_vals,str_params,num_params);

%% Normalise the data into a more analysis friendly format.
% Now all data points are 100 long. 

fprintf('Normalising the Data...\n');
norm_loopData = normalise(loopData); %Now its a cell array
%Do the same for the string data?



%% Classify the data so its easier to search through and less noisy.
% Decision Tree or PCA. Put in both and choose. These both work on the
% unnoormalised data.

PCA = 0;
if PCA
    fprintf('Classifying buses and cars with PCA and KMeans..\n');
    Class = PrincipleComponentModel2(prof_vals,str_params,num_params);
else
    fprintf('Classifying buses and cars with a Decision Tree...\n');
    Class = decisionTreeModel2(prof_vals,str_params,num_params);
end

%Assign Classes to the loops. So each cell contains all the classes for
%each loop.
[class_cell,data_cell] = Class2Loop(Class,ord_num, str_params);


%% Find the most likely match for each event from our tidied up data.
% Based on : DTW, Uniformity + a weighting function for the time?
%Lets do this tricky badger....

%Take a loop: A: search through A for closest match in B with correct
%class.

fprintf('Finding the likely Matches...\n');
loop_num = 5;

indices = zeros(length(norm_loopData{loop_num}),3);
% 1 - DTW 0 - Uniformity


%NOW I want to do this for just one class. means I have to know which class
%is which :( 

for i=1:length(norm_loopData{loop_num})
    
    [LM,mini,loop] = likely_match2(i,class_cell, [loop_num,successor(loop_num)],data_cell);
    %[LM,mini,loop] = likely_match(i,class_cell, norm_loopData, [loop_num,successor(loop_num)],data_cell,0);
    indices(i,:) = [LM,mini,loop];
    
end

%% Plot the Time differences.
% look at the curve thing and see if it is better? if the average is closer
% to 20.

time_vec = time_diff(loop_num,indices,data_cell);