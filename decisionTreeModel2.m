function[class] = decisionTreeModel2(sam_prof_vals,str_params,num_params)

%%Works only on the unnormalised data. Should probs convert but effort.


%%Restructure the data
    


    time_stamp = str_params(:,1);
    loop_id = str_params(:,2);
    sample_period = num_params(:,1);
    profile_length = num_params(:,2);
    max_detuning = num_params(:,3);
    
    
%%  Smoothing, Normalising and Feature extraction
    times                    = {length(loop_id)};       
    normalized_vals          = {length(loop_id)};
    normalized_smoothed_vals = {length(loop_id)};  
    % Features
    pos_max_peak        = zeros(size(loop_id));
    prominence_max_peak = zeros(size(loop_id));
    width_max_peak      = zeros(size(loop_id));
    min_peak_height     = zeros(size(loop_id));
    pos_first_peak      = zeros(size(loop_id));
    num_of_peaks        = zeros(size(loop_id));
    AUC                 = zeros(size(loop_id));
    average_peak_height = zeros(size(loop_id));
    
    for i =1:length(loop_id)   
           
        times{i} = [0:(profile_length(i)-1)*sample_period(i)];   
        
        if(max(times{i})>100) % avoid values < 100ms as tend to be noisey
            
            % normalise
            normalized_vals{i} = normal(sam_prof_vals{i});
            %smooth
            normalized_smoothed_vals{i} = smooth(normalized_vals{i},0.3,'loess');

            % Picking out some features
            [pks,locs,width,prominence] = (findpeaks(normalized_smoothed_vals{i},'MinPeakProminence',0.15));
            num_of_peaks(i) = numel(pks);
            AUC(i) = trapz(normalized_smoothed_vals{i});

            pos_first_peak_temp = min(locs);
            if(isempty(pos_first_peak_temp) == 1) %avoids erroneaous data with no peaks
                pos_first_peak(i) = 0;
                min_peak_height(i) = 0;
                width_max_peak(i) = 0;
                prominence_max_peak(i) = 0;
            else
                pos_first_peak(i) = min(locs);
                min_peak_height(i) = min(pks);
                [~,index_max_peak] = max(pks);
                width_max_peak(i) = width(index_max_peak);

                pos_max_peak(i) = locs(index_max_peak);
                prominence_max_peak(i) = prominence(index_max_peak);
                average_peak_height(i) = sum(pks)/num_of_peaks(i);
            end   
        end
    end


%% Decision Tree Model
% This is the important bit. This is the model from which we separate cars
% and buses.
    class = zeros(size(sam_prof_vals));

    for i =1:length(sam_prof_vals)   
        
        if(AUC(i)>70)
            class(i) = 3;
        else
            if num_of_peaks(i) == 0
                class(i) = 4;
            elseif num_of_peaks(i) >3
                class(i) = 6;
                
                
            else                
                if num_of_peaks(i) == 1
                    if pos_max_peak(i) >=40
                        if pos_max_peak(i) <= 60
                        
                            if width_max_peak(i) < 30
                                class(i) = 5;
                            else
                                class(i) = 1;
                            end
                        else
                            class(i) = 5;
                        end
                    else
                        if width_max_peak(i) < 30
                            class(i) = 4;
                        else
                            class(i) = 2;
                        end
                    end
                    
                    
                else
                    if pos_max_peak(i) > 70
                        class(i) = 5;
                    else
                        class(i) = 6;
                    end
                end
                

            end
        end         
    end





    %% Plot the time series from one loop dependent on its colour
    
%     colourList = {'r','b','g','k','c','m'};
% 
%     fSmooth = figure;
%     fRaw    = figure;
%     for i =1:length(sam_prof_vals)
%         if(max(times{i})>100)
%         %if(strcmp(loop_id(i),'N07141A1') == 1)
%             
%             if(class(i) == 1)
%                 set(0, 'CurrentFigure', fSmooth)
%                 S1 = subplot(3,2,1);
%                 hold on;
%                 plot(normalized_smoothed_vals{i},colourList{class(i)})
%                 
%                 set(0, 'CurrentFigure', fRaw)
%                 R1 = subplot(3,2,1);
%                 hold on;
%                 plot(sam_prof_vals{i},colourList{class(i)})
% 
%             elseif(class(i) == 2)
%                 set(0, 'CurrentFigure', fSmooth)
%                 S2 = subplot(3,2,2);
%                 hold on;
%                 plot(normalized_smoothed_vals{i},colourList{class(i)}) 
%                 
%                 set(0, 'CurrentFigure', fRaw)
%                 R2 = subplot(3,2,2);
%                 hold on;
%                 plot(sam_prof_vals{i},colourList{class(i)})
%                 
%             elseif(class(i) == 3)
%                 set(0, 'CurrentFigure', fSmooth)
%                 S3 = subplot(3,2,3);
%                 hold on;
%                 plot(normalized_smoothed_vals{i},colourList{class(i)})
%                 
%                 set(0, 'CurrentFigure', fRaw)
%                 R3 = subplot(3,2,3);
%                 hold on;
%                 plot(sam_prof_vals{i},colourList{class(i)})
% 
%             elseif(class(i) == 4)
%                 set(0, 'CurrentFigure', fSmooth)
%                 S4 = subplot(3,2,4);
%                 hold on;
%                 plot(normalized_smoothed_vals{i},colourList{class(i)})
%                 
%                 set(0, 'CurrentFigure', fRaw)
%                 R4 = subplot(3,2,4);
%                 hold on;
%                 plot(sam_prof_vals{i},colourList{class(i)})
%             
%             elseif(class(i) == 5)
%                 set(0, 'CurrentFigure', fSmooth)
%                 S5 = subplot(3,2,5);
%                 hold on;
%                 plot(normalized_smoothed_vals{i},colourList{class(i)})
%                 
%                 set(0, 'CurrentFigure', fRaw)
%                 R5 = subplot(3,2,5);
%                 hold on;
%                 plot(sam_prof_vals{i},colourList{class(i)})
%                 
%             elseif(class(i) == 6)
%                 set(0, 'CurrentFigure', fSmooth)
%                 S6 = subplot(3,2,6);
%                 hold on;
%                 plot(normalized_smoothed_vals{i},colourList{class(i)})
%                 
%                 set(0, 'CurrentFigure', fRaw)
%                 R6 = subplot(3,2,6);
%                 hold on;
%                 plot(sam_prof_vals{i},colourList{class(i)})
%             end
%             
%         end
%         %end
% 
%     end
%     
%     ylim(S1,[0,1]); 
%     ylim(S2,[0,1]);
%     ylim(S3,[0,1]); 
%     ylim(S4,[0,1]);
%     ylim(S5,[0,1]);
%     ylim(S6,[0,1]); 
%     
%     set(0, 'CurrentFigure', fSmooth)
%     set(gcf,'NextPlot','add');
%     axes;
%     h = title('Decision Tree Classification of Smoothed and Normalised Events');
%     set(gca,'Visible','off');
%     set(h,'Visible','on');
%     
%     set(0, 'CurrentFigure', fRaw)
%     set(gcf,'NextPlot','add');
%     axes;
%     h = title('Raw Events for each Decision Tree Class');
%     set(gca,'Visible','off');
%     set(h,'Visible','on');

 
function [norm_data]  = normal(Data)
    
DataTime = 0.001*[0:1:length(Data)-1];
maxi = max(Data);
if maxi ~= 0
    Data = Data./maxi;
end

DataTime = DataTime./max(DataTime);
norm_data = interp1(DataTime,Data, linspace(0,1,100));
end
    

    
end