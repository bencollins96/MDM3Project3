function [loopData] = preprocessing(filename)

%% Import data from text file.
% Script for importing data from the following text file:
%
%    loop_data_20170207-0210to0310.csv
%
% Auto-generated by MATLAB on 2017/02/11 15:24:31

%% Initialize variable. (may need to change filename)

file = 'loopData';
delimiter = ',';
startRow = 2;

%% Format for each line of text:
%   column1: text (%q)
%	column2: text (%q)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: text (%q)
% For more information, see the TEXTSCAN documentation.

formatSpec = '%q%q%f%f%f%q%[^\n\r]';

%% Open the text file and read columns of data according to the specified format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool. Then Close the file again.

fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);

%% Allocate imported array to column variable names
time_stamp = dataArray{:, 1};
loop_id = dataArray{:, 2};
sample_period = dataArray{:, 3};
profile_length = dataArray{:, 4};
max_detuning = dataArray{:, 5};
profile_values = dataArray{:, 6};

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% Use the previous code to convert the profile values into something more useable.
% These were in the format ['1','100','143',....].
new_prof_vals = {length(profile_values)};
for i = 1:length(profile_values)
    
    profile  = profile_values{i};
    profile  = regexprep(profile,'[','');
    profile  = regexprep(profile,']','');
    profile  = regexprep(profile,'''','');
    profile  = regexprep(profile,' '    , '');
    profile = strsplit(profile,',');
    result = cellfun(@str2num, profile, 'UniformOutput', false);
    result = cell2mat(result);
    new_prof_vals{i} = result;
end

%% Including the max-detuning.
%  Must multiply the prof_vals by the maximum detuning to obtain the
%  'real' profile values.

det_prof_vals = {length(new_prof_vals)};
for i = 1:length(new_prof_vals)
    det_prof_vals{i} = new_prof_vals{i}*max_detuning(i);
end

%% Include the sample period.
% This could be included in the loop above but for clarity and laziness
% sake, i'll leave it here. To take care of the sample period. I first
% made a vector increasing in jumps of the sample period so 0,4,8...
% Then i made the new one that it should be 0,1,2,3. And interpolated
% the real values for the new time. This makes each time series
% comparable.

sam_prof_vals={};

for i =1:length(new_prof_vals)
    old_time = [0:sample_period(i):(profile_length(i)-1)*sample_period(i)];
    new_time = [0:(profile_length(i)-1)*sample_period(i)];
    sam_prof_vals{i} = interp1(old_time, det_prof_vals{i}, new_time);
end

%% Demonstration (all data starts from 1 now too)
%  Passing the data out for usage. There might be a better way...
%
str_params = [time_stamp, loop_id];
num_params = [sample_period, profile_length, max_detuning];

    
%% Organising into simple labels and plotting seperately
% I've gotta apologise for the horrific coding... but i think it works
% out in the end. Potentially the best way to store the data???
% Just use it by loopData(n).Letter. E.g loopData(1).A gives all the
% num_params for A, whilst loopData(3).H gives cell array containing all
% the profile values for H.

    ord_num(length(sam_prof_vals)) = 0;
 
    for i =1:length(sam_prof_vals)
        
        if(strcmp(loop_id(i),'N07141A1'))
            ord_num(i) = 1;
            
        elseif(strcmp(loop_id(i),'N07151T1'))
             ord_num(i) = 2;
             
        elseif(strcmp(loop_id(i),'N07192C1'))
             ord_num(i) = 3;
            
        elseif(strcmp(loop_id(i),'N07191D1'))
             ord_num(i) = 4;
            
        elseif(strcmp(loop_id(i),'N07191I1'))
             ord_num(i) = 5;         
             
        elseif(strcmp(loop_id(i),'N07191B1'))
             ord_num(i) = 6;
             
        elseif(strcmp(loop_id(i),'N07175A1'))
             ord_num(i) = 7;
            
        elseif(strcmp(loop_id(i),'N07175A2'))
            ord_num(i) = 8;
            
        elseif(strcmp(loop_id(i),'N07151R1'))
            ord_num(i) = 9;
             
        elseif(strcmp(loop_id(i),'N07141B2'))
            ord_num(i) = 10;
            
        elseif(strcmp(loop_id(i),'N07141B1'))
            ord_num(i) = 11;
            
        elseif(strcmp(loop_id(i),'N07191E1'))
            ord_num(i) = 12;
            
        elseif(strcmp(loop_id(i),'N07191F1'))
             ord_num(i) = 13;
        end        
    end
    
% 1,2,3,4,... A,B,C,D....
 
values1 = {num_params(ord_num==1,:),str_params(ord_num==1,:),sam_prof_vals(ord_num ==1)};
field1 = 'A';

values2 = {num_params(ord_num==2,:),str_params(ord_num==2,:),sam_prof_vals(ord_num ==2)};
field2 = 'B';

values3 = {num_params(ord_num==3,:),str_params(ord_num==3,:),sam_prof_vals(ord_num ==3)};
field3 = 'C';

values4 = {num_params(ord_num==4,:),str_params(ord_num==4,:),sam_prof_vals(ord_num ==4)};
field4 = 'D';

values5 = {num_params(ord_num==5,:),str_params(ord_num==5,:),sam_prof_vals(ord_num ==5)};
field5 = 'E';

values6 = {num_params(ord_num==6,:),str_params(ord_num==6,:),sam_prof_vals(ord_num ==6)};
field6 = 'F';

values7 = {num_params(ord_num==7,:),str_params(ord_num==7,:),sam_prof_vals(ord_num ==7)};
field7 = 'G';

values8 = {num_params(ord_num==8,:),str_params(ord_num==8,:),sam_prof_vals(ord_num ==8)};
field8 = 'H';

values9 = {num_params(ord_num==9,:),str_params(ord_num==9,:),sam_prof_vals(ord_num ==9)};
field9 = 'I';

values10 = {num_params(ord_num==10,:),str_params(ord_num==10,:),sam_prof_vals(ord_num ==10)};
field10 = 'J';

values11 = {num_params(ord_num==11,:),str_params(ord_num==11,:),sam_prof_vals(ord_num ==11)};
field11 = 'K';

values12 = {num_params(ord_num==12,:),str_params(ord_num==12,:),sam_prof_vals(ord_num ==12)};
field12 = 'L';

values13 = {num_params(ord_num==13,:),str_params(ord_num==13,:),sam_prof_vals(ord_num ==13)};
field13 = 'M';

loopData = struct(field1,values1,field2,values2,field3,values3,field4,values4,...
    field5,values5,field6,values6,field7,values7,field8,values8,field9,values9,...
    field10,values10,field11,values11,field12,values12,field13,values13);

end
    



