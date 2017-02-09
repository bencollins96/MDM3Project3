All = importdata('Data/3to4.csv',' ');

Headers = strsplit(All{1},',');
profile_values = {};

for i= 1:length(All)-1
    
    Line2 =  strsplit(All{i+1},'"');
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
