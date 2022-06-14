% test HU threshold for a single file
% He Jiang 2022-6-5
clear all; close all;clc

CBCT_index = [11];
% CBCT_index = [3,7,9,15,16];
sz_ind = size(CBCT_index);
start = -700; aim = 0; increase = 50;
% sz_index = size(CBCT_index);
Time_of_smooth = 0;
Judge = 1;
% parameters of filter kernel
Length_of_kernel = 20;
sigma = 10;

%% Path Part
figure()
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

    for Ind_of_CB = 1:size_of_dir(1)
        
        ori = 0;
        curve_ind = 1;
        Ind_File = Dir(Ind_of_CB).name;
        Ind_FilE = reverse(Ind_File);
        if Ind_FilE(9) ~= 'd'
            Path_CBCT = strcat(Path_CB,Ind_File);

            % load data
            IMG(Index_of_CBCT,:,:,:) = niftiread(Path_CBCT);
            
            % extract infor from Label
            MID = squeeze(IMG(Index_of_CBCT,:,:,:));
            MID(Label == 0) = 0; 
            for level = start +increase : increase : aim
                if ori == 0
                    Base = MIP(MID, Label,Time_of_smooth,Judge);
                    Base(Base <= -1000) = 0;
%                     Base = Base  + 1000;
                    Sum_base = sum(Base,'all');
                    ori = 1;
                end

                MID(MID<=level) = -1000;
                Result = MIP(MID, Label,Time_of_smooth,Judge);
                Result(Result <= -1000) = 0;
%                 Result = Result + 1000;
%                 if level == -500 
%                     ou1 = Result;
%                 end
%                 if  level == -700
%                     ou2 = Result;
%                 end                
                curve(curve_ind) =  1 - sum(Base - Result,'all')/Sum_base;
                curve_ind = curve_ind + 1;
            end
            sz = size(curve);
            figure(1)
            plot((1:sz(2))*increase,curve,'DisplayName',strcat('Image:',num2str(CBCT_index(IND)),'--Num ',num2str(Ind_of_CB)))
            hold on
            legend
            Index_of_CBCT = Index_of_CBCT + 1;
        end

    end
    ylim([-0.1,1.1])
%     title(num2str(ind))
%     hold off
end




%%
% figure()
% imagesc(ou2)
