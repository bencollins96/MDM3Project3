function [norm_loopData] = normalise(loopData)

%%Normalise profile Lengths.



n =length(loopData(3).A);
A_mat(n,100) =0;
for i=1:n
    A_mat(i,:) = normal(loopData(3).E{i});
end
 
n =length(loopData(3).B);
B_mat(n,100) =0;
for i=1:n
    B_mat(i,:) = normal(loopData(3).B{i});
end

n =length(loopData(3).C);
C_mat(n,100) =0;
for i=1:n
    C_mat(i,:) = normal(loopData(3).C{i});
end
 
n =length(loopData(3).D);
D_mat(n,100) =0;
for i=1:n
    D_mat(i,:) = normal(loopData(3).D{i});
end

n =length(loopData(3).E);
E_mat(n,100) =0;
for i=1:n
    E_mat(i,:) = normal(loopData(3).E{i});
end
 
n =length(loopData(3).F);
F_mat(n,100) =0;
for i=1:n
    F_mat(i,:) = normal(loopData(3).F{i});
end

n =length(loopData(3).G);
G_mat(n,100) =0;
for i=1:n
    G_mat(i,:) = normal(loopData(3).G{i});
end
 
n =length(loopData(3).H);
H_mat(n,100) =0;
for i=1:n
    H_mat(i,:) = normal(loopData(3).H{i});
end

n =length(loopData(3).I);
I_mat(n,100) =0;
for i=1:n
    I_mat(i,:) = normal(loopData(3).I{i});
end
 
n =length(loopData(3).J);
J_mat(n,100) =0;
for i=1:n
    J_mat(i,:) = normal(loopData(3).J{i});
end

n =length(loopData(3).K);
K_mat(n,100) =0;
for i=1:n
    K_mat(i,:) = normal(loopData(3).K{i});
end
 
n =length(loopData(3).L);
L_mat(n,100) =0;
for i=1:n
    L_mat(i,:) = normal(loopData(3).L{i});
end

n =length(loopData(3).M);
M_mat(n,100) =0;
for i=1:n
    M_mat(i,:) = normal(loopData(3).M{i});
end
 
norm_loopData = {A_mat,B_mat,C_mat,D_mat,E_mat,F_mat,G_mat,H_mat,...
    I_mat,J_mat,K_mat,L_mat,M_mat};





%% Calculate Uniformity Values:
%E --- 160


Uniformity =0;
for i=1:100
    Uniformity = Uniformity + (min(E_mat(160,i),H_mat(100,i)))/(max(E_mat(160,i),H_mat(100,i)));
end


%% DTW Comparison

dtw_list(length(loopData(1).H)) = 0;
for i=1:length(loopData(1).H)
    dtw_list(i) = dtw(E_mat(160,:),H_mat(i,:));
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

