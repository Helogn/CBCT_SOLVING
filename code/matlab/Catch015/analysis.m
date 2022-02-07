%% He Jiang
% mean
clear all
close all
clc

Data_path = "D:\MRES\Label\Catch015\";

Scan1_path = '20201229.nii';
Scan2_path = '20201231.nii';
Scan3_path = '20210104.nii';
Scan4_path = '20210108.nii';
% Scan5_path = '20200501.nii';


% read scans

Scan1 = niftiread(Data_path + Scan1_path);
Scan2 = niftiread(Data_path + Scan2_path);
Scan3 = niftiread(Data_path + Scan3_path);
Scan4 = niftiread(Data_path + Scan4_path);
% Scan5 = niftiread(Data_path + Scan5_path);

Scan1_label =  niftiread(Data_path + 'R'+ Scan1_path);
Scan2_label =  niftiread(Data_path + 'R'+ Scan2_path);
Scan3_label =  niftiread(Data_path + 'R'+ Scan3_path);
Scan4_label =  niftiread(Data_path + 'R'+ Scan4_path);
% Scan5_label =  niftiread(Data_path + 'R'+ Scan5_path);
% 
Scan1(Scan1_label==0) = -1000;
Scan2(Scan2_label==0) = -1000;
Scan3(Scan3_label==0) = -1000;
Scan4(Scan4_label==0) = -1000;
% Scan5(Scan5_label==0) = -1000;

%%



% sz = size(Scan1_label);
% Scan = zeros([4,sz(1),sz(2),sz(3)]);
% Scan_label = zeros([5,sz(1),sz(2),sz(3)]);
% Scan(1,:,:,:) = Scan1;
% Scan(2,:,:,:) = Scan2;
% Scan(3,:,:,:) = Scan3;
% Scan(4,:,:,:) = Scan4;
% % Scan(5,:,:,:) = Scan5;
% 
% Scan_label(1,:,:,:) = Scan1_label;
% Scan_label(2,:,:,:) = Scan2_label;
% Scan_label(3,:,:,:) = Scan3_label;
% Scan_label(4,:,:,:) = Scan4_label;
% % Scan_label(5,:,:,:) = Scan5_label;
% 
% 
% clear Scan1_path Scan2_path Scan3_path Scan4_path Scan5_path 
% clear Scan1 Scan2 Scan3 Scan4 Scan5 Scan1_label Scan2_label Scan3_label Scan4_label Scan5_label
% 
% Scan(Scan_label == 0) = -1000;


%% MIP 
A = 5;
MIP1 = MIP(squeeze(Scan1(:,:,:)),squeeze(Scan1_label(:,:,:)),A);
MIP2 = MIP(squeeze(Scan2(:,:,:)),squeeze(Scan2_label(:,:,:)),A);
MIP3 = MIP(squeeze(Scan3(:,:,:)),squeeze(Scan3_label(:,:,:)),A);
MIP4 = MIP(squeeze(Scan4(:,:,:)),squeeze(Scan4_label(:,:,:)),A);

%

figure(1)
subplot(2,2,1)
% imagesc(Scan1(:,:,34))
imagesc(MIP1)
title ('20201229');
colormap('gray')
view(-90,90);


subplot(2,2,2)
% imagesc(Scan2(:,:,34))
imagesc(MIP2)
title ('20201231');
view(-90,90);

subplot(2,2,3)
imagesc(MIP3)
title ('20210104');
% imagesc(Scan3(:,:,34))
view(-90,90);

subplot(2,2,4)
imagesc(MIP4)
title ('20210108');
% imagesc(Scan4(:,:,34))
view(-90,90);

%%
