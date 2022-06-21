% Main caiculate mean change

clear all; close all; clc
figure()
%%
% CBCT_index = [3,7,9,11,15,16];
CBCT_index = [33];
% CBCT_index = [23,24,25,26,28,29,30,31,32];
sz_ind = size(CBCT_index);
Value = -650;
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
    avg_label = sum(Label,"all");
    

    Dir = dir([Path_CB + "*.nii"]);
%   read each file
    size_of_dir = size(Dir);
    Index_of_CBCT = 1;
    for Ind_of_CB = 1:size_of_dir(1)    
        Ind_File = Dir(Ind_of_CB).name;
        Ind_FilE = reverse(Ind_File);
        if Ind_FilE(9) ~= 'd'
            Path_CBCT = strcat(Path_CB,Ind_File);

            % load data

            eval(['IMG', num2str(Index_of_CBCT),' = niftiread(Path_CBCT);'])
            
            % extract infor from Label
            eval(['IMG', num2str(Index_of_CBCT),'(Label == 0) = 0;'])

            % set HU-650 to 0
            eval(['IMG', num2str(Index_of_CBCT),'(IMG',num2str(Index_of_CBCT),' < Value) = 0;'])

            % calculate aveage of label
            eval(['AVG_IMG(Index_of_CBCT)= sum(IMG', num2str(Index_of_CBCT),',"all")/avg_label;'])
            eval(['clear IMG',num2str(Index_of_CBCT),';'])
            Index_of_CBCT = Index_of_CBCT + 1;
        end

    end
%     figure()
    AVE = mean(AVG_IMG);
    plot(AVG_IMG,'DisplayName',num2str(CBCT_index(IND)),'LineWidth',3)
    hold on
%     sz = size(AVG_IMG);
%     plot(1:sz(2),(ones(1,sz(2)))*AVE)

%     title(num2str(CBCT_index(IND)))

%     clear AVG_IMG 
    legend
end
% title('-650-23-32 C')
%%
% legend(CBCT_index)
