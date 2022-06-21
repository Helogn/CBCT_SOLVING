% calculate subtraction image between closed images.
% Jiang He 2022-6-19

%% Load images and set arguments
clear all; close all; clc
ind = 3;
Length_of_kernel = 20; Time_smooth = 0;
sigma = 10;

if ind >= 10
    Catch = strcat('0',num2str(ind));
else
    Catch = strcat('00',num2str(ind));
end




% Path
Path_CBCT = strcat("D:\MRES\Label\Catch",Catch,"\C\");
PCT = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\PCT.nii"));
Label = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\RLabel.nii"));

%% dictory CBCT
Dir = dir([Path_CBCT + "*.nii"]);
sz_of_list = size(Dir);
sz = size(PCT);
Scan = zeros(sz_of_list(1),sz(1),sz(2),sz(3));
for i = 1: sz_of_list(1)
%     imgaussfilt3(niftiread(Path_CBCT),gaussian_sigma,'FilterSize',filter_size);
            
    Scan(i,:,:,:) = Input(strcat(Path_CBCT,Dir(i).name),Label);
    B = squeeze(Scan(i,:,:,:));
    T = APfilter(Scan(i,:,:,:),Length_of_kernel,sigma);
    T(B == -1000) = -1000;
    Scan(i,:,:,:) = T;
end

%% subtraction part
Subtraction = zeros(sz_of_list(1)-1,sz(1),sz(3));
for i = 1: sz_of_list(1)-1

    Subtraction(i,:,:) = MIP(squeeze(Scan(i,:,:,:) - Scan(i + 1,:,:,:)),Label,Time_smooth,3);

end
%% imagesc 
% ------------------- Plot Part ---------------------------------
Judge = 2;
if mod(sz_of_list(1)-1,2) == 0
    % if number of CBCT is even
    loop = (sz_of_list(1)-1) / 2;
%     eval(['Image2 = MIP',num2str(loop+1),';']);
    Image2 = squeeze(Subtraction(loop+1,:,:));
else
    % if number of CBCT is odd
    loop = floor(sz_of_list(1)/2) + 1;
    Image2 = squeeze(Subtraction(loop+1,:,:));
%     eval(['Image2 = MIP',num2str(loop+1),';']);
    if Judge == 2
        Subtraction(loop*2,:,:) = zeros([sz(1),sz(3)]) + Subtraction(1,1);
%         eval(['MIP',num2str(loop*2),' = zeros([sz(1),sz(3)]) + Subtraction(1,1);']);
    elseif Judge == 1
        eval(['MIP',num2str(loop*2),' = zeros([sz(1),sz(3)]) -1000;']);
    end
end
Image1 = squeeze(Subtraction(1,:,:));

if sz_of_list(1) >= 6
    for i = 2:1:loop
        Image1 = cat(1,Image1,squeeze(Subtraction(i,:,:)));
        Image2 = cat(1,Image2,squeeze(Subtraction(i+loop,:,:)));
%         eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])
%         eval(['Image2 = cat(1,Image2,','MIP',num2str(i+loop),');'])
    end
    Result = cat(2,Image2,Image1);
    figure()
    imagesc(Result)
    colormap('gray')
    colorbar()
    if Judge == 1
        title(strcat('MIP: ',ind))
    elseif Judge == 2
        title(strcat('AIP: ',ind))
    end
    daspect([1 3 1]);
    view([-90 90])
else
    for i = 2:1:sz_of_list(1)
%         eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])
        Image1 = cat(1,Image1,squeeze(Subtraction(i,:,:)));
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



