function [class_cell, data_cell] = Class2Loop(Class,ord_num, str_params)

Class = Class';
class_cell = cell(13,1);


for i=1:length(Class)
   class_cell{ord_num(i)}= [class_cell{ord_num(i)},Class(i)];
end

data_cell = cell(13,1);

for i=1:length(Class)
    data_cell{ord_num(i)} = [data_cell{ord_num(i)}, str_params(i,1)]; 
end