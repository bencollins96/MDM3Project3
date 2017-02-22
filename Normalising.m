function [A_mat, B_mat] = normalise()

%%Normalise profile Lengths.

load 'loopData56';

n =length(loopData(3).A);
A_mat(n,100) =0;
for i=1:n
    A_mat(i,:) = normal(loopData(3).A{i});
end
 
n =length(loopData(3).B);
B_mat(n,100) =0;
for i=1:n
    B_mat(i,:) = normal(loopData(3).B{i});
end

end


function [norm_data]  = normal(Data)
    
DataTime = 0.001*[0:1:length(Data)-1];
maxi = max(Data);
if maxi ~= 0
    Data = Data./maxi;
end

DataTime = DataTime./max(DataTime);

norm_data = interp1(DataTime,Data, linspace(0,1,100));
end

