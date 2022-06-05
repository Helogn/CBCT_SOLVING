% Main caiculate mean change

clear all;  clc
% clear all; close all; clc
figure()
%%
% ----------------- positive date ----------------
% case 3
table = zeros(32,5,2);
table(3,1,1) = 5; table(3,1,2) = 1; % 1 = positive = red circle
table(7,1,1) = 3; table(3,1,2) = 1; % 1 = positive = red circle
table(11,1,1) = 12; table(3,1,2) = 1; % 1 = positive = red circle
table(11,2,1) = 13; table(3,2,2) = 1; % 1 = positive = red circle
table(15,1,1) = 4; table(3,2,2) = 1; % 1 = positive = red circle
table(16,1,1) = 6; table(3,2,2) = 1; % 1 = positive = red circle
table(16,2,1) = 8; table(3,2,2) = 2; % 1 = positive = red circle
table(24,1,1) = 1; table(3,2,2) = 2; % 1 = positive = red circle
table(24,2,1) = 3; table(3,2,2) = 1; % 1 = positive = red circle
table(24,3,1) = 4; table(3,2,2) = 1; % 1 = positive = red circle
table(29,1,1) = 1; table(3,2,2) = 2; % 1 = positive = red circle
table(29,2,1) = 5; table(3,2,2) = 1; % 1 = positive = red circle
scatblue_ind = 0;
scatred_ind = 0;
test_blue = 0;
test_red = 0;
%%
% -------------------------------------------------

% CBCT_index = [24,29];
% CBCT_index = [30];
% CBCT_index = [23,24,25,26,28,29,30,31,32];

CBCT_index = [3,7,9,11,15,16,19,24];
sz_ind = size(CBCT_index);
Value = -650;
set_value = 1; % use < -650
set_scatter = 1;
figure_title = "Normal without-650";


%%
for IND = 1 : sz_ind(2)
    ind = CBCT_index(IND);
    if ind >= 10
        Catch = strcat('0',num2str(ind));
    else
        Catch = strcat('00',num2str(ind));
    end
    Path_CB = strcat("D:\MRES\Label\Catch",Catch,"\DEF\");
    
    % load PCT
    
    PCT = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\PCT.nii"));
    Label = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\RLabel.nii"));
    size_of_label = size(Label);
    avg_label = sum(Label,"all");
    

    Dir = dir([Path_CB + "*.nii"]);
%   read each file
    size_of_dir = size(Dir);
    Index_of_CBCT = 1;
    IMG = zeros([size_of_dir(1),size_of_label(1),size_of_label(2),size_of_label(3)]);
    for Ind_of_CB = 1:size_of_dir(1)    
        Ind_File = Dir(Ind_of_CB).name;
        Ind_FilE = reverse(Ind_File);
        if Ind_FilE(9) ~= 'd'
            Path_CBCT = strcat(Path_CB,Ind_File);

            % load data
            IMG(Index_of_CBCT,:,:,:) = niftiread(Path_CBCT);

            
            % extract infor from Label
            MID = squeeze(IMG(Index_of_CBCT,:,:,:));
            MID(Label == 0) = 0;

            % set HU-650 to 0
            if set_value == 1
                MID(MID<Value) = 0;
            end
            %             Cal_num = sum(MID~=0,'all');


            AVG_IMG(Index_of_CBCT) = sum(MID,'all')/sum(MID~=0,'all');

            Index_of_CBCT = Index_of_CBCT + 1;
        end

    end
%     figure()
%     mx = max(AVG_IMG);
%     mi = min(AVG_IMG);
%     AVG_IMG = (AVG_IMG-mi) /(mx-mi);
%     AVE = mean(AVG_IMG);
%     h = plot(AVG_IMG,'LineWidth',3);
    plot(AVG_IMG,'DisplayName',num2str(CBCT_index(IND)),'LineWidth',3);
    legend
%     legend(h,num2str(CBCT_index(IND)))
%     clear h
    hold on
    sz = size(AVG_IMG);

    if table(CBCT_index(IND),1,1) ~= 0
        for i = 1 : 5
            if table(CBCT_index(IND),i,1) ~= 0
                if table(CBCT_index(IND),i,2) ~= 1
                    scatred_ind = scatred_ind + 1;
                    scat_red(scatred_ind,1) = table(CBCT_index(IND),i,1);
                    scat_red(scatred_ind,2) = AVG_IMG(table(CBCT_index(IND),i,1));
%                         scat_red(scatred_ind,2) = table(CBCT_index(IND),i,2);
                    test_red = 1;

                    
                elseif table(CBCT_index(IND),i,2) ~= 2
                    scatblue_ind = scatblue_ind + 1;
                    scat_blue(scatblue_ind,1) = table(CBCT_index(IND),i,1);
                    scat_blue(scatblue_ind,2) = AVG_IMG(table(CBCT_index(IND),i,1));
                    test_blue = 1;

                    
                end
            end
        end
    end


    clear AVG_IMG 
end

% title('-650-23-32 C')
%%
if set_scatter == 1
    if test_blue == 1
        scatter(scat_blue(:,1),scat_blue(:,2),'blue','DisplayName','Negetive Date')
    end
    if test_red == 1
        scatter(scat_red(:,1),scat_red(:,2),'red','DisplayName','Positive Date')
    end
end
title(figure_title)
