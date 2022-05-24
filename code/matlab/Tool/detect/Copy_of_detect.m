%test detect

clc
clear all
close all
load color.mat;

% 3,9,11,15,16,19
% Aim = 1:12;
% Aim = [3,9,11,15,16,19];
% Aim = [3];
% Aim = 1:12;
Aim = [1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22];
% Aim = [3,9,15,16,19];
sz1 = size(Aim);

Time_of_smooth = 1;
Numberofclass = 20;

for N = 1:sz1(2)
% for N = 1:1
    for Judge = 2:2
        I = Aim(N);

        if I < 10
            A = 'Catch00';
        else
            A = 'Catch0';
        end
%         if I < 10
%             A = 'Catch_col_00';
%         else
%             A = 'Catch_col_0';
%         end

        % define path of file
        num = strcat(A,num2str(I));
        path = strcat('D:\MRES\Label\',num,'\C\');
        Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
        size_of_img = size(Label);
        PCT = Input(strcat('D:\MRES\Label\',num,'\PCT.nii'),Label);

        list = dir([path +'*.nii']);
        sz_num_img = size(list);
        extract = ones([sz_num_img(1)-1,size_of_img(1),size_of_img(2),size_of_img(3)]);
    

        % Img1 - Img2
        for i = 1 : sz_num_img(1)-1
            eval(['extract(',num2str(i),',:,:,:) = Input(strcat(path,list(i+1).name),Label) - Input(strcat(path,list(i).name),Label);'])
%             eval(['B = extract(',num2str(i),',:,:,:);']);
%             eval(['Scan',num2str(i),'(B == -1000) = -1000;'])
%             clear B
        end

        sz = size(extract);


        % MIP
        for i = 1:1:sz_num_img(1)-1
            eval(['MIP',num2str(i),'=','(MIP(squeeze(extract(',num2str(i),',:,:,:)),Label,Time_of_smooth,Judge));']);
            %replace nan with 0 and calculate sum for a whole image;
            eval(['SumT=MIP',num2str(i),';']);
            SumT(isnan(SumT)) = 0;
            T(i) = sum(SumT,'all');
            clear SumT
%             eval(['MIP',num2str(i),'=','(MIP(squeeze(extract(',num2str(i),',:,:,:)),Label,Time_of_smooth,Judge));']);

        end



        %%
        if mod(sz(1),2) == 0
            loop = sz(1)/2;
            Image1 = MIP1;
            eval(['Image2 = MIP',num2str(sz(1)/2),';']);
            K =1;
            
        else
        %奇数
            loop = floor((sz(1))/2) + 1;
            Image1 = zeros(size(MIP1));
            eval(['MIP',num2str(sz(1)+1),' = zeros([sz(2),sz(4)]);' ])
            K =2;
        end
%         Image1 = MIP1;
%         eval(['Image2 = MIP',num2str(i+loop),');'])
        eval(['Image2 = MIP',num2str(loop),';']);
    
        % --------------------------------------------------------
        %plot image , if number of image > 6, we use two rows
        % number of num > 6
        if sz(1) >= 6
            if K == 1
                for i = 1:1:loop-1
                    eval(['Image1 = cat(1,Image1,','MIP',num2str(i+1),');'])
                    eval(['Image2 = cat(1,Image2,','MIP',num2str(i+loop+1),');'])
                end
                Result = cat(2,Image2,Image1);
            else
                Image1 = MIP1;
                eval(['Image2 = MIP',num2str((sz(1)+1)/2),';']);
                for i = 1:1:loop-1
                    eval(['Image1 = cat(1,Image1,','MIP',num2str(i+1),');'])
                    eval(['Image2 = cat(1,Image2,','MIP',num2str(i+loop+1),');'])
                end
                Result = cat(2,Image2,Image1);


            end

%             [Result,mi,mx] = classify(Result,Numberofclass);
            figure()
            subplot(2,1,1)
            imagesc(Result)
            colormap('gray')
            caxis([-1000,1000])
            colorbar()
            if Judge == 1
        
                title(strcat('MIP: ',num))
            elseif Judge == 2
                title(strcat('AIP: ',num))
            end
            daspect([1 3 1]);
            view([-90 90])
            subplot(2,1,2)
            plot(T)
            title('SUM of Intensity')
            xlabel('Index')
        
        else
            
            Image1 = MIP1;
            for i = 2:1:sz(1)
                eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])

            end

            figure()
            subplot(2,1,1)
%             [Result,mi,mx] = classify(Image1,Numberofclass);
            imagesc(Image1)
            caxis([-1000,1000])
            colormap('gray')
            colorbar()
            if Judge == 1
        
                title(strcat('SUBMIP: ',num))
            elseif Judge == 2

                title(strcat('SUBSIP: ',num))
            end
            daspect([1 3 1]);
            view([-90 90])
            subplot(2,1,2)
            plot(T)
            title('SUM of Intensity')
            xlabel('Index')
        
        end
        f = gcf;
    % Requires R2020a or later
        if Judge == 1
            exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\MIP\TMIP',num,'.png'),'Resolution',300)
        elseif Judge ==2
            exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\gray\SubSIP',num,'.png'),'Resolution',300)

%             exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\jet\Con_SubSIP',num,'.png'),'Resolution',300)
        end
        close all
        clear T



    end
end

