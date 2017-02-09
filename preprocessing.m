All = importdata('Data/3to4.csv',' ');

Headers = strsplit(All{1},',');

fprintf('\n');
for i =1:length(Headers)
    string = strcat(Headers{i},'\n');
    fprintf(string);
end



Line2 =  strsplit(All{2},'"');
profile  = Line2{2};
profile  = regexprep(profile,'[','');
profile  = regexprep(profile,']','');
profile  = regexprep(profile,'''','');
profile  = regexprep(profile,' ', '');
profile = strsplit(profile,',');

result = cellfun(@str2num, profile, 'UniformOutput', false);
result = cell2mat(result);