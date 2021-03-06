%% He Jiang

% mean
clear all
close all
clc

Data_path = "D:\MRES\Label\Catch_col_001\";

Scan1_path = '20181004.nii';
Scan2_path = '20181010.nii';
Scan3_path = '20181019.nii';
Scan4_path = '20181026.nii';
% Scan5_path = '20200501.nii';


% read scans

Scan1 = niftiread(Data_path + Scan1_path);
Scan2 = niftiread(Data_path + Scan2_path);
Scan3 = niftiread(Data_path + Scan3_path);

Scan4 = niftiread(Data_path + Scan4_path);

Scan1_label =  niftiread(Data_path + 'R'+ Scan1_path);
Scan2_label =  niftiread(Data_path + 'R'+ Scan2_path);
Scan3_label =  niftiread(Data_path + 'R'+ Scan3_path);
Scan4_label =  niftiread(Data_path + 'R'+ Scan4_path);
% 
Scan1(Scan1_label==0) = -1000;
Scan2(Scan2_label==0) = -1000;
Scan3(Scan3_label==0) = -1000;
Scan4(Scan4_label==0) = -1000;


%%

sz = size(Scan1_label);
Scan_C_01 = zeros([4,sz(1),sz(2),sz(3)]);
Scan_label = zeros([4,sz(1),sz(2),sz(3)]);
Scan_C_01(1,:,:,:) = Scan1;
Scan_C_01(2,:,:,:) = Scan2;
Scan_C_01(3,:,:,:) = Scan3;
Scan_C_01(4,:,:,:) = Scan4;
% Scan(5,:,:,:) = Scan5;

Scan_label(1,:,:,:) = Scan1_label;
Scan_label(2,:,:,:) = Scan2_label;
Scan_label(3,:,:,:) = Scan3_label;
Scan_label(4,:,:,:) = Scan4_label;
% Scan_label(5,:,:,:) = Scan5_label;


clear Scan1_path Scan2_path Scan3_path Scan4_path Scan5_path 
clear Scan1 Scan2 Scan3 Scan4 Scan5 Scan1_label Scan2_label Scan3_label Scan4_label Scan5_label

Scan_C_01(Scan_label == 0) = -1000;



%% compare differences among these five images
Subtract = zeros([3,sz(1),sz(2),sz(3)]);
Subtract(1,:,:,:) = Scan_C_01(1,:,:,:) - Scan_C_01(2,:,:,:);
Subtract(2,:,:,:) = Scan_C_01(1,:,:,:) - Scan_C_01(3,:,:,:);
Subtract(3,:,:,:) = Scan_C_01(1,:,:,:) - Scan_C_01(4,:,:,:);
% Subtract(4,:,:,:) = Scan(1,:,:,:) - Scan(5,:,:,:);
Subtract = abs(Subtract);

%% MIP Label = 1   Background = 0
A = 3;
MIP1 = MIP(squeeze(Scan_C_01(1,:,:,:)),squeeze(Scan_label(1,:,:,:)),A);
MIP2 = MIP(squeeze(Scan_C_01(2,:,:,:)),squeeze(Scan_label(2,:,:,:)),A);
MIP3 = MIP(squeeze(Scan_C_01(3,:,:,:)),squeeze(Scan_label(3,:,:,:)),A);
MIP4 = MIP(squeeze(Scan_C_01(4,:,:,:)),squeeze(Scan_label(4,:,:,:)),A);
% MIP5 = MIP(squeeze(Scan(5,:,:,:)),squeeze(Scan_label(5,:,:,:)));

%
% clims = [-3.9e5,-3.3e5];
% figure(1)
% subplot(2,2,1)
% % imagesc(Scan1(:,:,34))
% % imagesc(MIP1,clims)
% imagesc(MIP1)
% colormap('gray')
% title("Slice1-0528")
% view(-90,90);
% 
% 
% subplot(2,2,2)
% % imagesc(Scan2(:,:,34))
% % imagesc(MIP2,clims)
% imagesc(MIP2)
% title("Slice2-0610")
% view(-90,90);
% 
% subplot(2,2,3)
% % imagesc(MIP3,clims)
% imagesc(MIP3)
% % imagesc(Scan3(:,:,34))
% title("Slice3-0617")
% view(-90,90);
% 
% subplot(2,2,4)
% % imagesc(MIP4,clims)
% imagesc(MIP4)
% title("Slice4-0626")
% % colorbar
% view(-90,90);

% subplot(2,3,5)
% imagesc(MIP5)
% % imagesc(Scan5(:,:,34))
% view(-90,90);


T1 = cat(2,MIP1,MIP3);
T2 = cat(2,MIP2,MIP4);
T = cat (1,T1,T2);
imagesc(T)
colormap('gray')
view([-90 90])
% axis equal