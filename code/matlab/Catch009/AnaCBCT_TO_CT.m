clear all
Data_path = "D:\MRES\Label\Catch009\CBCT_TO_PCT\C";
PCT_path = "D:\MRES\Label\Catch009\Label.nii";

Scan1_path = '20200406.nii';
Scan2_path = '20200407.nii';
Scan3_path = '20200413.nii';
Scan4_path = '20200420.nii';
Scan5_path = '20200430.nii';
Scan6_path = '20200501.nii';

Label = niftiread(PCT_path);

A = 20;
sigma = 3;


Scan1 = APfilter(niftiread(Data_path + Scan1_path),A,sigma);
Scan2 = APfilter(niftiread(Data_path + Scan2_path),A,sigma);
Scan3 = APfilter(niftiread(Data_path + Scan3_path),A,sigma);
Scan4 = APfilter(niftiread(Data_path + Scan4_path),A,sigma);
Scan5 = APfilter(niftiread(Data_path + Scan5_path),A,sigma);
Scan6 = APfilter(niftiread(Data_path + Scan6_path),A,sigma);

Scan1(Label==0) = -1000;
Scan2(Label==0) = -1000;
Scan3(Label==0) = -1000;
Scan4(Label==0) = -1000;
Scan5(Label==0) = -1000;
Scan6(Label==0) = -1000;
Scan1(Scan1==0) = -1000;
Scan2(Scan2==0) = -1000;
Scan3(Scan3==0) = -1000;
Scan4(Scan4==0) = -1000;
Scan5(Scan5==0) = -1000;
Scan6(Scan6==0) = -1000;




%%

A = 1;
MIP1 = MIP(Scan1,Label,A);
MIP2 = MIP(Scan2,Label,A);
MIP3 = MIP(Scan3,Label,A);
MIP4 = MIP(Scan4,Label,A);
MIP5 = MIP(Scan5,Label,A);
MIP6 = MIP(Scan6,Label,A);

Result1 = cat(1,MIP1,MIP2,MIP3);
Result2 = cat(1,MIP4,MIP5,MIP6);
Result = cat(2,Result1,Result2);
figure()
imagesc(Result)
title('Catch009')
colormap('gray')
daspect([1 4 1]);
view([-90 90])

%% 

subplot(1,2,1)
imagesc(Label(:,:,50))
subplot(1,2,2)
imagesc(Scan1(:,:,50))
view([-90 90])
xlabel('sss')


%% subtraction
A = 1;
MIP1 = MIP(Scan1-Scan2,Label,A);
MIP2 = MIP(Scan2-Scan3,Label,A);
MIP3 = MIP(Scan3-Scan4,Label,A);
MIP4 = MIP(Scan4-Scan5,Label,A);
MIP5 = MIP(Scan5-Scan6,Label,A);
% MIP6 = MIP(Scan6,Label,A);

Result1 = cat(1,MIP1,MIP2,MIP3);
% Result2 = cat(1,MIP4,MIP5,MIP6);
% Result = cat(2,Result1,Result2);
% figure()
imagesc(Result1)
title('Catch009')
colormap('gray')
daspect([1 4 1]);
view([-90 90])

%%
A = Scan3 - Scan4;
subplot(1,3,1)
imagesc(Scan1(:,:,50))
subplot(1,3,2)
imagesc(Scan4(:,:,50))
subplot(1,3,3)
imagesc(A(:,:,50))