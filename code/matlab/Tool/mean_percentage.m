% Main caiculate mean change
% 计算图像在不同日期的像素平均值

% clear all;  clc
clear all; close all; clc
figure()
%%
% ----------------- positive date ----------------
% case 3
table = zeros(36,5,2);
table(3,1,1) = 5; table(3,1,2) = 1; % 1 = positive = red circle
table(7,1,1) = 3; table(7,1,2) = 1; % 1 = positive = red circle
table(11,1,1) = 12; table(11,1,2) = 1; % 1 = positive = red circle
table(11,2,1) = 13; table(11,2,2) = 1; % 1 = positive = red circle
table(15,1,1) = 4; table(15,2,2) = 1; % 1 = positive = red circle
table(16,1,1) = 6; table(16,1,2) = 1; % 1 = positive = red circle
table(16,2,1) = 8; table(16,2,2) = 2; % 1 = positive = red circle
table(24,1,1) = 1; table(24,1,2) = 2; % 1 = positive = red circle
table(24,2,1) = 3; table(24,2,2) = 1; % 1 = positive = red circle
table(24,3,1) = 4; table(24,3,2) = 1; % 1 = positive = red circle
table(29,1,1) = 1; table(29,1,2) = 2; % 1 = positive = red circle
table(29,2,1) = 5; table(29,2,2) = 1; % 1 = positive = red circle
table(33,1,1) = 7; table(33,1,2) = 1;
scatblue_ind = 0;
scatred_ind = 0;
test_blue = 0;
test_red = 0;
%%
% -------------------------------------------------

CBCT_index = [19];
% CBCT_index = [3,7,9,11,15,16,24,33];
% CBCT_index = [23,24,25,26,30,31,32];

% CBCT_index = [3,7,9,11,15,16,19];
sz_ind = size(CBCT_index);
Value = -200;
set_value = 1; % use < -650
set_scatter = 1;
% figure_title = strcat("23-32-Normal ",num2str(Value));
if set_value == 1
    figure_title = strcat("Percentage of Voxels around",num2str(Value),"-Threshold");
else
    figure_title = "Deformable-Mean--no-Threshold";
end 
% figure_title = "Average Intensity Curve";
filter_size = 5;
gaussian_sigma = 0.5;

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
%             IMG(Index_of_CBCT,:,:,:)  = APfilter(niftiread(Path_CBCT),20,10);
            IMG(Index_of_CBCT,:,:,:)  = niftiread(Path_CBCT);
%             IMG(Index_of_CBCT,:,:,:) = imgaussfilt3(niftiread(Path_CBCT),gaussian_sigma,'FilterSize',filter_size);
            
            
            % extract infor from Label
            MID = squeeze(IMG(Index_of_CBCT,:,:,:));
            MID(Label == 0) = 0;
            MIDD = MID;

            % set HU-650 to 0
            if set_value == 1
                MID(MID<Value-10) = 0;
                MID(MID>Value+10) = 0;
            end
            %             Cal_num = sum(MID~=0,'all');

            % calculate average value = sum / number
            AVG_IMG(Index_of_CBCT) = sum((MID~=0),'all')/sum((MIDD~=0),'all') * 100;

            Index_of_CBCT = Index_of_CBCT + 1;
        end

    end

    plot(AVG_IMG,'DisplayName',strcat("Case ",num2str(CBCT_index(IND))),'LineWidth',2,'Color',[1-IND / sz_ind(2),0.7,IND / sz_ind(2)]);
    hold on;
%     scatter(1:Ind_of_CB,AVG_IMG,'black','filled');    
    legend
%     legend(h,num2str(CBCT_index(IND)))
%     clear h
    hold on
    sz = size(AVG_IMG);

    if table(CBCT_index(IND),1,1) ~= 0
        for i = 1 : 5
            if table(CBCT_index(IND),i,1) ~= 0
                if table(CBCT_index(IND),i,2) == 1
                    scatred_ind = scatred_ind + 1;
                    scat_red(scatred_ind,1) = table(CBCT_index(IND),i,1);
                    scat_red(scatred_ind,2) = AVG_IMG(table(CBCT_index(IND),i,1));
%                         scat_red(scatred_ind,2) = table(CBCT_index(IND),i,2);
                    test_red = 1;

                    
                elseif table(CBCT_index(IND),i,2) == 2
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
        scatter(scat_blue(:,1),scat_blue(:,2),'h','blue','DisplayName','Negetive Date','LineWidth',3,'MarkerFaceColor','none')
    end
    if test_red == 1
        scatter(scat_red(:,1),scat_red(:,2),'red','h','DisplayName','Positive Date','LineWidth',3,'MarkerFaceColor','none')
    end
end
title(figure_title)
xlabel('Date Order')
% ylim([-900,-550])
ylabel('percentage of remaining voxels')
xlb=get(gca,'YTickLabel');%得到原本x轴的标注，是一列字符串不含百分号
n=length(xlb);%得到标注的个数，即长度
a='%';
per=repmat(a,n,1);%构造一个相同长度的%的列
new_xlb=[char(xlb),per];%把百分号加到原标注的后面，即两个列字符串拼起来
set(gca,'YTickLabel',new_xlb); %将新的标注设为当前x轴的标注
% 还有，为了简便，你画图前，最好把x都乘以100吧，最后标注%时就直接是百分数了