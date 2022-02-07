clear all
close all
Data_path = "D:\MRES\Label\Catch021\";

Scan1_path = '20200608.nii';
Scan2_path = '20200610.nii';
Scan3_path = '20200612.nii';
Scan4_path = '20200615.nii';
Scan5_path = '20200617.nii';
Scan6_path = '20200623.nii';
% Scan7_path = '20200521.nii';
% Scan8_path = '20200528.nii';
% vars = []
% for i = 1:8
% 
%     vars{1,i} = ['Scan',num2str(i)]
%     eval([vars{1,i},'=',strcat("niftiread(Data_path" , "_path)")])
A = 6;
sigma = 6;
Scan1 = APfilter(niftiread(Data_path + Scan1_path),A,sigma);
Scan2 = APfilter(niftiread(Data_path + Scan2_path),A,sigma);
Scan3 = APfilter(niftiread(Data_path + Scan3_path),A,sigma);
Scan4 = APfilter(niftiread(Data_path + Scan4_path),A,sigma);
Scan5 = APfilter(niftiread(Data_path + Scan5_path),A,sigma);
Scan6 = APfilter(niftiread(Data_path + Scan6_path),A,sigma);
% Scan7 = niftiread(Data_path + Scan7_path);
% Scan8 = niftiread(Data_path + Scan8_path);




Scan1_label =  niftiread(Data_path +'R'+ Scan1_path);
Sum(1) = sum(Scan1_label,"all");
Scan2_label =  niftiread(Data_path +'R'+ Scan2_path);
Sum(2) = sum(Scan2_label,"all");
Scan3_label =  niftiread(Data_path +'R'+ Scan3_path);
Sum(3) = sum(Scan3_label,"all");
Scan4_label =  niftiread(Data_path +'R'+ Scan4_path);
Sum(4) = sum(Scan4_label,"all");
Scan5_label =  niftiread(Data_path +'R'+ Scan5_path);
Sum(5) = sum(Scan5_label,"all");
Scan6_label =  niftiread(Data_path +'R'+ Scan6_path);
% Scan6_label(:,323:512,:) = 0;
Sum(6) = sum(Scan6_label,"all");
% Scan7_label =  niftiread(Data_path +'R'+ Scan7_path);
% Sum(7) = sum(Scan7_label,"all");
% Scan8_label =  niftiread(Data_path +'R'+ Scan8_path);
% Sum(8) = sum(Scan8_label,"all");

% 
Scan1(Scan1_label==0) = -1000;
Scan2(Scan2_label==0) = -1000;
Scan3(Scan3_label==0) = -1000;
Scan4(Scan4_label==0) = -1000;
Scan5(Scan5_label==0) = -1000;
Scan6(Scan6_label==0) = -1000;

% Scan7(Scan7_label==0) = -1000;
% Scan8(Scan8_label==0) = -1000;




A = 4;
% MIPN(1) = MIP(Scan1,Scan1_label,A);
% MIPN(2) = MIP(Scan2,Scan2_label,A);
% MIPN(3) = MIP(Scan3,Scan3_label,A);
% MIPN(4) = MIP(Scan4,Scan4_label,A);
% MIPN(5) = MIP(Scan5,Scan5_label,A);
% MIPN(6) = MIP(Scan6,Scan6_label,A);
MIP1 = MIP(Scan1,Scan1_label,A);
MIP2 = MIP(Scan2,Scan2_label,A);
MIP3 = MIP(Scan3,Scan3_label,A);
MIP4 = MIP(Scan4,Scan4_label,A);
MIP5 = MIP(Scan5,Scan5_label,A);
MIP6 = MIP(Scan6,Scan6_label,A);
% MIP7 = MIP(Scan7,Scan7_label,A);
% MIP8 = MIP(Scan8,Scan8_label,A);
% figure()
B = [-1000,500];
figure()
subplot(2,3,1)
imagesc(MIP1,B)
colormap('gray')
title('Catch021')
view([-90 90])

subplot(2,3,2)
imagesc(MIP2,B)
view([-90 90])
colormap('gray')
view([-90 90])

subplot(2,3,3)
imagesc(MIP3,B)
colormap('gray')
view([-90 90])

subplot(2,3,4)
imagesc(MIP4,B)
colormap('gray')
view([-90 90])

subplot(2,3,5)
imagesc(MIP5,B)
colormap('gray')
view([-90 90])

subplot(2,3,6)
imagesc(MIP6,B)
view([-90 90])
colormap('gray')


% Result1 = cat(1,MIP1,MIP2);
% Result2 = cat(1,MIP3,MIP5);
% Result = cat(2,Result1,Result2);
% figure()
% imagesc(Result)
% colormap('gray')
% title('Catch022')
% daspect([1 4 1]);
% view([-90 90])

%%
Scan1(Scan1_label==0) = 0;
Scan2(Scan2_label==0) = 0;
Scan3(Scan3_label==0) = 0;
Scan4(Scan4_label==0) = 0;
Scan5(Scan5_label==0) = 0;
Scan6(Scan6_label==0) = 0;

N = 6;
for i = 1:N
    varient = ['Scan',num2str(i)];
    Sum_voxel(i) = sum (varient,'all')/Sum(i);
end

figure()
plot(1:N,(Sum_voxel(1:N)),'-V')
title('Catch021 Average Intensity')
set(gca,'xtick',1:1:N)  
xtickformat('%g Scan')

