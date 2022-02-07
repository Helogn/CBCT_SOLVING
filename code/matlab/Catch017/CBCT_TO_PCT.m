% addpath(genpath('D:\github_repsitory\CBCT_SOLVING\code\matlab\Tool'))
% a = folder_search('D:\MRES\Label\Catch012','nii')
%%
clear all
Data_path = "D:\MRES\Label\Catch017\C\C";
Label = niftiread("D:\MRES\Label\Catch017\Label");
Scan1_path = '20200406.nii';
Scan2_path = '20200407.nii';
Scan3_path = '20200408.nii';
Scan4_path = '20200409.nii';
Scan5_path = '20200410.nii';
Scan6_path = '20200413.nii';
Scan7_path = '20200416.nii';
Scan8_path = '20200423.nii';
% Scan9_path = '20201228.nii';
% Scan10_path = '20201228.nii';
N = 8;
for i = 1:1:N

    eval(['Scan',num2str(i),'=','Input(Data_path + Scan',num2str(i),'_path,Label);']);

end

%%
A = 4;
for i = 1:1:N
    eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,A);']);
end

Result1 = cat(1,MIP1,MIP2,MIP3,MIP4);
Result2 = cat(1,MIP5,MIP6,MIP7,MIP8);
Result = cat(2,Result2,Result1);
imagesc(Result)
colormap('gray')
title('Catch17')
daspect([1 4 1]);
view([-90 90])

%%
% Sum1(1) = SumP(Scan1,Label);
for i = 1:1:N

    eval(['Sum(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);

end
%%
plot(Sum)
title('Catch017')
%%

