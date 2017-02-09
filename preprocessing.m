function [profile_values] = preprocessing()

AllData = importdata('Data/3to4.csv',' ');
profile_values = {};

for i= 1:length(AllData)-1
    
    Line2 =  strsplit(AllData{i+1},'"');
    profile  = Line2{2};
    profile  = regexprep(profile,'[','');
    profile  = regexprep(profile,']','');
    profile  = regexprep(profile,'''','');
    profile  = regexprep(profile,' '    , '');
    profile = strsplit(profile,',');
    result = cellfun(@str2num, profile, 'UniformOutput', false);
    result = cell2mat(result);
    profile_values{i} = result;
    
end

for i = 1:length(AllData)-1
    hold on 
    plot(profile_values{i});
end

end



