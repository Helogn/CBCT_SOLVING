% Main script
clear all; close all; clc
%%

Aim_Index = [32];
sz_index = size(Aim_Index);
Time_of_smooth = 1;
Judge = 1;
% parameters of filter kernel
Length_of_kernel = 20;
sigma = 10;

%% Path Part

for N = 1 : sz_index(2)
    if Aim_Index(N) < 10
        A = 'Catch00';
    else
        A = 'Catch0';
    end

%         if I < 10
%             A = 'Catch_col_00';
%         else
%             A = 'Catch_col_0';
%         end

    num = strcat(A,num2str(Aim_Index(N)));
    CBCT_Path = strcat('D:\MRES\Label\',num,'\DEF\');
%     Aim_path = strcat('D:\MRES\Label\',num,'\erosion');
    Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
    PCT = Input(strcat('D:\MRES\Label\',num,'\PCT.nii'),Label);

% ------------------ Load Input images as Scan* ----------------
    list = dir([CBCT_Path + "*.nii"]);
    sz_of_list = size(list);
    for i = 1: sz_of_list(1)
        eval(['Scan',num2str(i),'=','Input(strcat(CBCT_Path,list(i).name),Label);']);
        eval(['B = Scan',num2str(i),';']);
        eval(['sz = size(B)'])
        eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',Length_of_kernel,sigma);'])
        eval(['Scan',num2str(i),'(B == -1000) = -1000;'])
        eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,Time_of_smooth,Judge);']);
        clear B
    end
% ------------------- MIP have been added to above part ---------
%     for i = 1:1:sz_of_list(1)
%         eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,Time_of_smooth,Judge);']);
%     end

% ------------------- Plot Part ---------------------------------
    if mod(sz_of_list(1),2) == 0
        % if number of CBCT is even
        loop = sz_of_list(1) / 2;
        eval(['Image2 = MIP',num2str(loop+1),';']);
    else
        % if number of CBCT is odd
        loop = floor(sz_of_list(1)/2) + 1;
        eval(['Image2 = MIP',num2str(loop+1),';']);
        if Judge == 2
            eval(['MIP',num2str(loop*2),' = zeros([sz(1),sz(3)]) + MIP1(1,1);']);
        elseif Judge == 1
            eval(['MIP',num2str(loop*2),' = zeros([sz(1),sz(3)]) -zeros([sz(1),sz(3)]);']);
        end
    end
    Image1 = MIP1;
    
    if sz_of_list(1) >= 6
        for i = 2:1:loop
            eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])
            eval(['Image2 = cat(1,Image2,','MIP',num2str(i+loop),');'])
        end
        Result = cat(2,Image2,Image1);
        figure()
        imagesc(Result)
        colormap('gray')
        colorbar()
        if Judge == 1
            title(strcat('MIP: ',num))
        elseif Judge == 2
            title(strcat('AIP: ',num))
        end
        daspect([1 3 1]);
        view([-90 90])
    else
        for i = 2:1:sz_of_list(1)
            eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])
        end

        figure()
        imagesc(Image1)
        colormap('gray')
        colorbar()
        if Judge == 1
            title(strcat('MIP: ',num))
        elseif Judge == 2
            title(strcat('AIP: ',num))
        end
        daspect([1 3 1]);
        view([-90 90])
    end
% ------------ save img -----------------------------------
    f = gcf;
    if Judge == 1
        exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\DEF\TMIP',num,'.png'),'Resolution',300)
    elseif Judge ==2
        exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\DEF\TAIP',num,'.png'),'Resolution',300)
    end

    close all
    clear loop

end











