% addpath(genpath('D:\github_repsitory\CBCT_SOLVING\code\matlab\Tool'))
% a = folder_search('D:\MRES\Label\Catch012','nii')
%%
clear all
Data_path = "D:\MRES\Label\Catch014\C\C";
Label = niftiread("D:\MRES\Label\Catch014\Label");
Scan1_path = '20201104.nii';
Scan2_path = '20201109.nii';
Scan3_path = '20201112.nii';
Scan4_path = '20201116.nii';
Scan5_path = '20201117.nii';
Scan6_path = '20201119.nii';
Scan7_path = '20201123.nii';
Scan8_path = '20201125.nii';
Scan9_path = '20201127.nii';
Scan10_path = '20201130.nii';
N = 10;
for i = 1:1:N

    eval(['Scan',num2str(i),'=','Input(Data_path + Scan',num2str(i),'_path,Label);']);

end

%%
A = 1;
for i = 1:1:N

    eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,A);']);

end



Result1 = cat(1,MIP1,MIP2,MIP3,MIP4,MIP5);
% Result2 = cat(1,MIP6,MIP7,MIP8,MIP9,MIP10);
% Result = cat(2,Result2,Result1);
imagesc(Result1)
colormap('gray')
title('Catch14')
daspect([1 4 1]);
view([-90 90])

%%
% Sum1(1) = SumP(Scan1,Label);
for i = 1:1:N

    eval(['Sum(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);

end
%%
plot(Sum)
title('Catch013')
%%

