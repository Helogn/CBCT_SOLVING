% addpath(genpath('D:\github_repsitory\CBCT_SOLVING\code\matlab\Tool'))
a = folder_search('D:\MRES\Label\Catch010','nii')
%%
clear all
Data_path = "D:\MRES\Label\Catch010\C\C";
Label = niftiread("D:\MRES\Label\Catch010\Label");
Scan1_path = '20201005.nii';
Scan2_path = '20201006.nii';
Scan3_path = '20201007.nii';
Scan4_path = '20201008.nii';
Scan5_path = '20201009.nii';
Scan6_path = '20201012.nii';
Scan7_path = '20201013.nii';
Scan8_path = '20201014.nii';
Scan9_path = '20201015.nii';
Scan10_path = '20201016.nii';
N = 10;
for i = 1:1:10

    eval(['Scan',num2str(i),'=','Input(Data_path + Scan',num2str(i),'_path,Label);']);

end
A = 7;
sigma = 2;

for i = 1:1:N

    eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',A,sigma);']);

end
%%
A = 3;
for i = 1:1:10

    eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,A);']);

end



Result1 = cat(1,MIP1,MIP2,MIP3,MIP4,MIP5);
Result2 = cat(1,MIP6,MIP7,MIP8,MIP9,MIP10);
Result = cat(2,Result2,Result1);
imagesc(Result)
colormap('gray')
title('Catch10')
daspect([1 4 1]);
view([-90 90])

%%
% Sum1(1) = SumP(Scan1,Label);
for i = 1:1:10

    eval(['Sum(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);

end
%%
plot(Sum)
title('Catch010')
%%

