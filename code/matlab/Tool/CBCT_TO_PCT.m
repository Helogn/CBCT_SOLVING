% addpath(genpath('D:\github_repsitory\CBCT_SOLVING\code\matlab\Tool'))
% a = folder_search('D:\MRES\Label\Catch012','nii')
%%
% clear all
% path = 'D:\MRES\Label\Catch018\C\';
% label = 'D:\MRES\Label\Catch012\RLabel.nii';
% list = dir([path +'*.nii']);
% sz = size(list)
% for i = 1 : sz(1)
%     eval(['Scan',num2str(i),'=','Input(strcat(path,list(i).name)',',label);']);
% end
%%
clear all
num = '20';
path = strcat('D:\MRES\Label\Catch0',num,'\C\');
Label = niftiread(strcat('D:\MRES\Label\Catch0',num,'\RLabel.nii'));
list = dir([path +'*.nii']);
sz = size(list)
A = 7;
sigma = 3;
for i = 1 : sz(1)
    eval(['Scan',num2str(i),'=','Input(strcat(path,list(i).name),Label);']);
    eval(['B = Scan',num2str(i),';']);
    eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',A,sigma);'])
    eval(['Scan',num2str(i),'(B == -1000) = -1000;'])
    clear B

%     eval(['Scan',num2str(i),'=','APfilter(Input(strcat(path,list(i).name),Label),A,sigma);']);
end


A = 3;
for i = 1:1:sz(1)
    eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,A);']);
end

if mod(sz(1),2) == 0
    loop = sz(1)/2;
else
%奇数
    loop = floor((sz(1) - 1)/2);
end



Image1 = MIP1;
eval(['Image2 = MIP',num2str((1+loop)),';']);
for i = 2:1:loop

    eval(['Image1 = cat(1,Image1,','MIP',num2str(i),');'])
    eval(['Image2 = cat(1,Image2,','MIP',num2str(i+loop),');'])
end

Result = cat(2,Image2,Image1);
imagesc(Result)
colormap('gray')
title(num)
daspect([1 3 1]);
view([-90 90])

f = gcf;
% Requires R2020a or later
exportgraphics(f,strcat('D:\github_repsitory\CBCT_SOLVING\code\matlab\png\',num,'.png'),'Resolution',300)
close all

%%
% Sum1(1) = SumP(Scan1,Label);
for i = 1:1:sz(1)

    eval(['Sum(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);

end

plot(1:sz(1),Sum)
title(num)
%%


