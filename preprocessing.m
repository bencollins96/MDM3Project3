function [loopData] = preprocessing(sam_prof_vals,str_params,num_params)
    
%% Organising into simple labels and plotting seperately
% I've gotta apologise for the horrific coding... but i think it works
% out in the end. Potentially the best way to store the data???
% Just use it by loopData(n).Letter. E.g loopData(1).A gives all the
% num_params for A, whilst loopData(3).H gives cell array containing all
% the profile values for H.

loop_id = str_params(:,2);

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
    



