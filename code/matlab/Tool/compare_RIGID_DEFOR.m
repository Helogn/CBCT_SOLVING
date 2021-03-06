% compare voxels between rigid and deforable in CBCT
clear ;clc;close all;

%%

% CBCT_index = [20,21,22,23,2gi4,25,26,28,29,30,31,32,33,35,36];
% CBCT_index = [8,10,11,12,13,14,18,19];
CBCT_index = [3,7,9,15,16];

sz_ind = size(CBCT_index);
start = -1000; aim = -100; increase = 10;
% sz_index = size(CBCT_index);
Time_of_smooth = 0;
Judge = 1;
% parameters of filter kernel
Length_of_kernel = 20;
sigma = 6;
jug3 = 1; % 1 = filter 2 = nonfiler
jug2 = 2; % 1 = mean 2 = var
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
        C_Path_CB = strcat("D:\MRES\Label\Catch",Catch,"\C\");
        
        % load PCT
        
        PlanCT = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\PCT.nii"));
        Label = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\RLabel.nii"));
    %     PCT(Label~=1) == -3000;
        size_of_label = size(Label);
        
        
        Dir = dir([Path_CB + "*.nii"]);
        Dir_C = dir([C_Path_CB + "*.nii"]);
        %   read each file
        size_of_dir = size(Dir);
        for jug3 = 1:1
            for Ind_of_CB = 1:size_of_dir(1)
                
                ori = 0; 
                curve_ind = 1;
                Ind_File = Dir(Ind_of_CB).name;
                Ind_File_C = Dir_C(Ind_of_CB).name;
                Ind_FilE = reverse(Ind_File);
                if Ind_FilE(9) ~= 'd'
                    Path_CBCT = strcat(Path_CB,Ind_File);
                    Path_CBCT_C = strcat(C_Path_CB,Ind_File_C);
        
                    % load data
                    DEF = niftiread(Path_CBCT);
                    RIGID = niftiread(Path_CBCT_C);
                    filter = DEF;
                    
                    if jug3 == 1
                        filter(DEF == 0) = -3000;
                        filter(Label == 0 ) = -3000;
                        filter(RIGID == 0) = -3000;
            
        %                 DEF = imgaussfilt3(DEF, sigma);
        %                 PCT = imgaussfilt3(PCT, sigma);
        %                 RIGID = imgaussfilt3(RIGID, sigma);
                        PCT = PlanCT;
                        DEF(filter == -3000) = -3000;
                        PCT(filter == -3000) = -3000;
                        RIGID(filter == -3000) = -3000;
                    end
                    
                    if jug3 == 2
        
                        PCT = PlanCT;
                        PCT(Label == 0) = -3000;
                        PCT(DEF == 0) = -3000;
        
                        DEF(DEF == 0) = -3000;
                        DEF(Label == 0) = -3000;
        
                    end
                    curve(Ind_of_CB) = sum(DEF-PCT,'all')/sum(DEF~=-3000,'all');
                    
                    if jug3 == 2
                        DEF(DEF == 0) = -3000;
                        DEF(Label == 0) = -3000;
                        PCT = PlanCT;
                        PCT(RIGID == 0) = -3000;
                        PCT(Label == 0) = -3000;
        
                        RIGID(RIGID == 0) = -3000;
                        RIGID(Label == 0) = -3000;
        
                    end
                    if jug2 == 1
                        curve_C(Ind_of_CB) = sum(RIGID-PCT,'all')/sum(RIGID ~= -3000,'all');
                        curve_C_DEF(Ind_of_CB) = sum(RIGID-DEF,'all')/sum(RIGID ~= -3000,'all');
                    elseif jug2 == 2
                        curve_C(Ind_of_CB) = var(double(RIGID-PCT),0,'all');
                        curve_C_DEF(Ind_of_CB) = var(double(RIGID-DEF),0,'all');
%                         result1 = ((RIGID-PCT).*(RIGID-PCT));
%                         curve_C(Ind_of_CB) = sum(result1,'all')/sum(result1~=0,'all');
%                         result2 = ((DEF-PCT).*(DEF-PCT));
%                         curve_C_DEF(Ind_of_CB) = sum(result2,'all')/sum(result2~=0,'all');
                    end

                end
            end
%             figure()
            xlabel("date order")
            ylabel("Intensity")
            
            plot(abs(curve),'DisplayName',strcat('Deforable-Case: ',num2str(ind)),'Color',[1-IND*0.1,0.5,0.5],'LineWidth',3);
            hold on 
            plot(abs(curve_C),'DisplayName',strcat('Rigid-Case: ',num2str(ind)),'Color',[0.5,0.5,IND*0.1 + 0.1],'LineWidth',3);
            jug3 = 3;
            if jug3 == 1
                title('filtered image')
            elseif jug3 == 2
                title('non filtered image')
            elseif jug3 == 3
                title('variance of subtraction between PCT and CBCT')
            end
            ylim([-100 2000])
            ylabel('variable of Intensity')
            xlabel('Date Index')
            hold on 
        %     plot(curve_C_DEF,'DisplayName',strcat('C - DEF-num: ',num2str(ind)));
%             hold off
            legend('location','Northeast')
        end
    
end











