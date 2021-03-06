% calculate_single file in one sheet
% hejiang 2022-7-8

% calculate HU threshold for a single file
% He Jiang 2022-6-5

clear ;close all;clc
N = 100;
N1 = -1000;
N2 = 0;
vertical_point = 100;
% CBCT_index = [3,5:26,28:33,35];
% CBCT_index = [3,7,9,11,15,16,24,33];
% CBCT_index = [3,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,35];
CBCT_index = [21];

sz_ind = size(CBCT_index);
start = -1000; aim = -200; increase = 30;
% filename = 'CBCT600_500.xlsx';
filename = strcat('Case3CBCT',num2str(start),num2str(aim),'.xlsx');
% if exist(filename) == 2
%     delete filename
% end

m = start  : increase : aim;
sz_of_table = size(m);
curve = zeros(sz_ind(2),sz_of_table(2));

Time_of_smooth = 0;
Judge = 1;
% parameters of filter kernel
Length_of_kernel = 20;
sigma = 10;
totol_row = 1;
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
    SE = strel('cube',3);
    Label = imerode(Label,SE);
    
    
    Dir = dir([Path_CB + "*.nii"]);
    %   read each file
    size_of_dir = size(Dir);
    Index_of_CBCT = 1;
    %IMG = zeros([size_of_dir(1),size_of_label(1),size_of_label(2),size_of_label(3)]);
    %Comp = zeros([size_of_dir(1),size_of_label(1),size_of_label(2),size_of_label(3)]);
    mid_arr = zeros(size_of_dir(1),sz_of_table(2));
    his = zeros(size_of_dir(1),N);
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
            A(A==0) = -3000;
%             IMG(Index_of_CBCT,:,:,:) = A;
           
            
            % extract infor from Label
            MID = A;
%             MID = squeeze(IMG(Index_of_CBCT,:,:,:));
            MID(Label == 0) = -3000; 
%             for level = start  : increase : aim
%                 level;
%                 if ori == 0
%                     Sum_base = sum((MID~=-3000),'all');
%                     ori = 1;
%                     MIDD = MID;
%                 end
% 
%                 MIDD(MIDD<level) = -3000; 
% 
% %                 curve(curve_ind) =  sum((MIDD ~= -3000),'all');
% 
%                 mid_arr(Ind_of_CB,curve_ind) =  sum((MIDD ~= -3000),'all')/Sum_base;
%                 
% 
%                 curve_ind = curve_ind + 1;
%             end
        end
%         mid_arr;
    figure(1)
    b = histogram(MID,N,'BinLimits',[N1,N2],'DisplayName',strcat('Date ',num2str(Ind_of_CB)));
%     alpha(0.5)
%     title(strcat('Histogram nbin = ',num2str(N)))
%     xlabel('Threshold/HU')
%     ylabel('Number')
%     legend()
% %     legend(strcat('Case ',num2str(Ind_of_CB)))
%     hold on 
    his(Ind_of_CB,:) = b.Values;
    figure(2)
    plot( linspace(N1,N2,N),his(Ind_of_CB,:),'DisplayName',Ind_File(4:11),'Linewidth',2,'Color',[Ind_of_CB/size_of_dir(1),0.5,0.5])
%     legend(strcat('Case ',num2str(Ind_of_CB)))
    legend()
    title(strcat('Catch ',num2str(ind),'  Histogram nbin = ',num2str(N)))
    xlabel('Threshold/HU')
    ylabel('Number')
    hold on 
%     figure(3)
%     plot( linspace(-1000,aim,N),his(Ind_of_CB,:)/sum(his(Ind_of_CB,:),'all'),'DisplayName',strcat('Date ',num2str(Ind_of_CB)),'Linewidth',2,'Color',[Ind_of_CB/size_of_dir(1),0.5,0.5])
% %     legend(strcat('Case ',num2str(Ind_of_CB)))
%     legend()
%     title(strcat('Catch ',num2str(ind),'  Histogram(Percentage) nbin = ',num2str(N)))
%     xlabel('Threshold/HU')
%     ylabel('Pertencage')
%     hold on 
%     
    end
%     ma = max(mid_arr,[],1);
%     mi = min(mid_arr,[],1);
%     mm = (ma-mi)./ma;
%     st = std(mid_arr,1);
    
%     if IND == 1
%     
%         writematrix(m,filename,'Sheet',1,'Range',strcat('C',num2str(totol_row)),"AutoFitWidth",false);
%         totol_row = totol_row + 1;
%     end
%     a = {'name',CBCT_index(IND)};
%     writecell(a,filename,'Sheet',1,'Range',strcat('A',num2str(totol_row)),"AutoFitWidth",false);
%     totol_row = totol_row + 1;
%     writematrix(mid_arr,filename,'Sheet',1,'Range',strcat('C',num2str(totol_row)),"AutoFitWidth",false);
%     totol_row = totol_row + Ind_of_CB;
%     writematrix(st,filename,'Sheet',1,'Range',strcat('C',num2str(totol_row)),"AutoFitWidth",false);
%     totol_row = totol_row + 1;
    f = gcf;
% 
    exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\histogram1\Catch',num2str(ind),'nbin=',num2str(N),'range ',num2str(N1),'-',num2str(N2),'.png'),'Resolution',300)
    close all
    clear  mid_arr a ma mi
end



%%
% figure()
% imagesc(ou2)

