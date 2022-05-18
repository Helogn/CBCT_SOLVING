 %%
 clc
clear all
% judge mip or sip
% Judge = 2;
% Aim = [6,7,8,9,11,12,13,14,18,19,20,21];
% Aim = [6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
% Aim = [2,3,5,6,7,8,9,10];
% Aim = [11,12,13,14,15,16,17,18,19,20,21,22];
Aim = 3
sz1 = size(Aim);
% smooth for label
Time_of_smooth = 1;

for N = 1:sz1(2)
    for Judge = 1:2
        I = Aim(N);
        if I < 10
            A = 'Catch00';
        else
            A = 'Catch0';
        end
        num = strcat(A,num2str(I));
        path = strcat('D:\MRES\Label\',num,'\C\');
        Aim_path = strcat('D:\MRES\Label\',num,'\erosion');
    %     Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
    % -------------------------Jiang-------------------------
        Label = niftiread(strcat('D:\MRES\Label\',num,'\erosion.nii'));
%         sz = size(Label);
%         t = zeros(sz);
%         for x = 1:sz(1)
%             for y = 1 :sz(2)
%                 for z = 1 : sz(3)
%                     t(x,y,z) = Label(x,sz(2)+1-y,z);
%                 end
%             end
%         end
%         Label = t;
%         clear t
    %------------------------------------------------
        PCT = Input(strcat('D:\MRES\Label\',num,'\PCT.nii'),Label);
    
        list = dir([path +'*.nii']);
        sz = size(list);
        A = 20;
        sigma = 10;
    
        for i = 1 : sz(1)
            eval(['Scan',num2str(i),'=','Input(strcat(path,list(i).name),Label);']);
            eval(['B = Scan',num2str(i),';']);
            eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',A,sigma);'])
            eval(['Scan',num2str(i),'(B == -1000) = -1000;'])
            clear B
        
        %     eval(['Scan',num2str(i),'=','APfilter(Input(strcat(path,list(i).name),Label),A,sigma);']);
        end


        for i = 1:1:sz(1)
            eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,Time_of_smooth,Judge);']);
        end
        
        if mod(sz(1),2) == 0
            loop = sz(1)/2;
        else
        %奇数
            loop = floor((sz(1))/2) + 1;
        end
    
        % combine
        % MIP0 = PCT
        [MIP0,ero_img] = Out_erosion(PCT,Label,Time_of_smooth,Judge);
        Image1 = MIP0;
%         eval(['Image2 = MIP',num2str(i+loop),');'])
        eval(['Image2 = MIP',num2str(floor((sz(1)+1)/2)-1),';']);
    
        % --------------------------------------------------------
        % number of num > 6
        if sz(1) >= 6

            for i = 1:1:loop-1
            
                eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])
                eval(['Image2 = cat(1,Image2,','MIP',num2str(i+loop),');'])
            end
            
            Result = cat(2,Image2,Image1);
            figure()
            imagesc(Result)
            colormap('gray')
            if Judge == 1
        
                title(strcat('MIP: ',num))
            elseif Judge == 2
                title(strcat('SIP: ',num))
            end
            daspect([1 3 1]);
            view([-90 90])
        
        else

            for i = 1:1:sz(1)
                eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])

            end

            figure()
            imagesc(Image1)
            colormap('gray')
            if Judge == 1
        
                title(strcat('MIP: ',num))
            elseif Judge == 2
                title(strcat('SIP: ',num))
            end
            daspect([1 3 1]);
            view([-90 90])
        
        end

        % ---------------------------------------------------------
        % ---------------- write image ----------------------------
        f = gcf;
        % Requires R2020a or later
        if Judge == 1
            exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\MIP\TMIP',num,'.png'),'Resolution',300)
        elseif Judge ==2
            exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\AIP\TAIP',num,'.png'),'Resolution',300)
        end
%             
        close all
%         data = load_untouch_nii(strcat('D:\MRES\Label\',num,'\PCT.nii'));
%         B = int16(ero_img);
%         data.img = B;
%         save_untouch_nii(data,Aim_path)
    end
end
%%

%%

