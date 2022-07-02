% order for each threshold for a single file
% He Jiang 2022-7-2

clear all;close all;clc

vertical_point = 100;

% CBCT_index = [8,10,11,12,13,14,18,19,];
CBCT_index = [24,25,26,28,29,30,31,32,33,35,36];
use_fix = 0;
con = [2,5];
% CBCT_index = [3,7,9,15,16];
sz_ind = size(CBCT_index);
start = -1000; aim = 0; increase = 50;
% sz_index = size(CBCT_index);
Time_of_smooth = 0;
Judge = 1;
% parameters of filter kernel
Length_of_kernel = 20;
sigma = 10;
% create matrix for order



%% Path Part

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
    order = zeros(size_of_dir(1),((increase - aim)/increase+1));
    for Ind_of_CB = 1:size_of_dir(1)
        
        ori = 0;
        curve_ind = 1;
        Ind_File = Dir(Ind_of_CB).name;
        Ind_FilE = reverse(Ind_File);
        if Ind_FilE(9) ~= 'd'
            Path_CBCT = strcat(Path_CB,Ind_File);

            % load data
            A = niftiread(Path_CBCT);
            A(A<-1000) = -1000;
            A(A==0) = -1000;
%             IMG(Index_of_CBCT,:,:,:) = A;
           
            
            % extract infor from Label
            MID = A;
%             MID = squeeze(IMG(Index_of_CBCT,:,:,:));
            MID(Label == 0) = -3000; 
            for level = start  : increase : aim
                level;
                if ori == 0
                    Sum_base = sum((MID~=-3000),'all');
                    ori = 1;
                    MIDD = MID;
                end

                MIDD(MIDD<level) = -3000; 

%                 curve(curve_ind) =  sum((MIDD ~= -3000),'all');
                order(Ind_of_CB,curve_ind) =  sum((MIDD ~= -3000),'all')/Sum_base;
                curve_ind = curve_ind + 1;
            end
            
            Index_of_CBCT = Index_of_CBCT + 1;
        end

    end
    sequence(order,start,increase);
    title(strcat('Num ',num2str(ind)));
%     plot(ones(1,10)*vertical_point,0.1:0.1:1)
% 
    f = gcf;
    exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\order\Catch',num2str(ind),'.png'),'Resolution',300)
    close all

end


