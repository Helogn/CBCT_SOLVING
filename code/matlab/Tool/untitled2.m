 %%
clear all
% judge mip or sip
% Judge = 2;
% Aim = [6,7,8,9,11,12,13,14,18,19,20,21];
% Aim = [6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22];
Aim = [22];
sz1 = size(Aim);
% smooth for label
Time_of_smooth = 2;


for Judge = 1:2
    I = Aim(1)
    if I < 10
        A = 'Catch00';
    else
        A = 'Catch0';
    end
    num = strcat(A,num2str(I));
    path = strcat('D:\MRES\Label\',num,'\C\');
%     Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));


% -------------------------Jiang-------------------------
    Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
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
    end

    % MIP

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
    MIP0 = MIP(PCT,Label,Time_of_smooth,Judge);
    Image1 = MIP1;
%         eval(['Image2 = MIP',num2str(i+loop),');'])
    eval(['Image2 = MIP',num2str(loop),';']);

    % --------------------------------------------------------
    %plot image , if number of image > 6, we use two rows
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
            title(strcat('AIP: ',num))
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
            title(strcat('AIP: ',num))
        end
        daspect([1 3 1]);
        view([-90 90])
    
    end

    % ---------------------------------------------------------
    % ---------------- write image ----------------------------
    % Requires R2020a or later

        
    close all
end


%%
B = zeros(3,512,234);
B(1,:,:) = MIP1;
B(2,:,:) = MIP2;
B(3,:,:) = MIP3;

%%
C = PCA(B);

