function [time_vec] = time_diff(loop_num,indices,data_cell)
%Loop number is the current loop,
%indices = [closest match, dtwvalue,  ]

time_diff = zeros(length(indices),1);

for i=1:length(indices)
    if isnan(indices(i,2))
        time_diff(i) = NaN;
    else 
        FirstDate = data_cell{loop_num}(i);
        FirstTime = datenum(FirstDate);
    
        SecondDate = data_cell{indices(i,3)}(indices(i,1));
        SecondTime = datenum(SecondDate);

        time_diff(i) = 60*60*24*(SecondTime -FirstTime);
    end
    
end

time_vec = time_diff;