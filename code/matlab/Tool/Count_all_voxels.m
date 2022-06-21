% calculate number of voxels beyond each threshold
% 计算每个case 的平均保留像素数
% He Jiang 2022-6-5
clear all; clc % close all;

CBCT_index = [33];
% CBCT_index = [23,24,25,26,28,29,30,31,32];
% CBCT_index = [3,7,9,11,15,16,19,23,24,25,26,28,29,30,31,32];
con = [3,7,9,11,15,16];
sz_ind = size(CBCT_index);
start = -1000; aim = 0; increase = 50;
cal = start : increase: aim;
sz_cal = size(cal);
% sz_index = size(CBCT_index);
Time_of_smooth = 0;
Judge = 1;
% parameters of filter kernel
% Length_of_kernel = 20;
% sigma = 10;

% guassian parameters:
filter_size = 5;
gaussian_sigma = 0.8;

%% Path Part
% figure()
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
    
    
    Dir = dir([Path_CB + "*.nii"]);
    %   read each file
    size_of_dir = size(Dir);
    Index_of_CBCT = 1;
    IMG = zeros([size_of_dir(1),size_of_label(1),size_of_label(2),size_of_label(3)]);
    Comp = zeros([size_of_dir(1),size_of_label(1),size_of_label(2),size_of_label(3)]);
    arr_curve = zeros(size_of_dir(1),sz_cal(2));
    for Ind_of_CB = 1:size_of_dir(1)
        ori = 0;
        curve_ind = 1;
        Ind_File = Dir(Ind_of_CB).name;
        Ind_FilE = reverse(Ind_File);

        % 
        if Ind_FilE(9) ~= 'd'
            Path_CBCT = strcat(Path_CB,Ind_File);

            % load data
            
            IMG(Index_of_CBCT,:,:,:) = imgaussfilt3(niftiread(Path_CBCT),gaussian_sigma,'FilterSize',filter_size);
            
            % extract infor from Label
            MID = squeeze(IMG(Index_of_CBCT,:,:,:));
            MID(Label == 0) = -3000; 
            for level = start : increase : aim
                if ori == 0
%                     Base = MIP(MID, Label,Time_of_smooth,Judge,-3000);
%                     Base(Base <= -1000) = 0;
%                     Sum_base = sum(Base,'all');
                    Sum_base = sum((MID~=-3000),'all');
                    ori = 1;
%                     size_base = size(Base);
                    MIDD = MID;
                end
%                 level
% ---------------------------- AVE INENSITY -------------------------------
%                 MID(MID<=level) = -1000;
%                 Result = MIP(MID, Label,Time_of_smooth,Judge);
%                 Result(Result <= level) = 0;
%               
%                 arr_curve(Ind_of_CB,curve_ind) =  1 - sum(Base - Result,'all')/Sum_base;
% --------------------------- END -----------------------------------------

% ----------------------------Count Number of changed pixels --------------------------------
                MIDD(MIDD<=level) = -3000;
%                 Result = MIP(MIDD, Label,Time_of_smooth,Judge);
%                 Result(Result <= level) = 0;
                Jug_equal = sum((MIDD ~= -3000),'all')/Sum_base;
                arr_curve(Ind_of_CB,curve_ind) = Jug_equal;



% ----------------------------       END       ------------------------------------




                curve_ind = curve_ind + 1;
            end

            Index_of_CBCT = Index_of_CBCT + 1;
        end


    end
    mean_curve = mean(arr_curve,1);
    sz = size(mean_curve);
    jug_color = size(find(con == (CBCT_index(IND))));
    if jug_color ~= 0  
        plot(start + ((0:(sz(2)-1))*increase),mean_curve,'blue','DisplayName',strcat('Image:',num2str(CBCT_index(IND))))
        hold on
        legend
    else
        plot(start + ((0:(sz(2)-1))*increase),mean_curve,'black','DisplayName',strcat('Image:',num2str(CBCT_index(IND))))
        hold on
        legend
    end

%     clear arr_curve mean_curve

end
ylim([-0.1,1.1])



%%
xlabel('Threshold Value (HU)')
ylabel('Percentage: Result/Origin ')
title('Threshold Curve')








