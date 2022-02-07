%% He Jiang

% mean
clear all
close all
clc

Data_path = "D:\MRES\Label\Catch011\";

Scan1_path = '20200528.nii';
Scan2_path = '20200610.nii';
Scan3_path = '20200617.nii';
Scan4_path = '20200626.nii';
% Scan5_path = '20200501.nii';


% read scans

Scan1 = niftiread(Data_path + Scan1_path);
Scan2 = niftiread(Data_path + Scan2_path);
Scan3 = niftiread(Data_path + Scan3_path);
Scan3(:,:,54) = -1000;
Scan4 = niftiread(Data_path + Scan4_path);
% Scan5 = niftiread(Data_path + Scan5_path);

Scan1_label =  niftiread(Data_path + 'R'+ Scan1_path);
Scan2_label =  niftiread(Data_path + 'R'+ Scan2_path);
Scan3_label =  niftiread(Data_path + 'R'+ Scan3_path);
Scan3_label(:,:,54) = 0;
Scan4_label =  niftiread(Data_path + 'R'+ Scan4_path);
% Scan5_label =  niftiread(Data_path + 'R'+ Scan5_path);
% 
Scan1(Scan1_label==0) = -1000;
Scan2(Scan2_label==0) = -1000;
Scan3(Scan3_label==0) = -1000;

Scan4(Scan4_label==0) = -1000;

%%
sz = size(Scan1_label);
Scan11 = zeros([4,sz(1),sz(2),sz(3)]);
Scan_label = zeros([4,sz(1),sz(2),sz(3)]);
Scan11(1,:,:,:) = Scan1;
Scan11(2,:,:,:) = Scan2;
Scan11(3,:,:,:) = Scan3;
Scan11(4,:,:,:) = Scan4;
% Scan(5,:,:,:) = Scan5;

Scan_label(1,:,:,:) = Scan1_label;
Scan_label(2,:,:,:) = Scan2_label;
Scan_label(3,:,:,:) = Scan3_label;
Scan_label(4,:,:,:) = Scan4_label;
% Scan_label(5,:,:,:) = Scan5_label;


clear Scan1_path Scan2_path Scan3_path Scan4_path Scan5_path 
clear Scan1 Scan2 Scan3 Scan4 Scan5 Scan1_label Scan2_label Scan3_label Scan4_label Scan5_label

Scan11(Scan_label == 0) = -1000;

%%
% figure()
% subplot(2,2,1)
% C1 = histogram(Subtract(1,:,:,:),[100:100:1200],'Normalization','probability');
% subplot(2,2,2)
% C2 = histogram(Subtract(2,:,:,:),[100:100:1200],'Normalization','probability');
% subplot(2,2,3)
% C3 = histogram(Subtract(3,:,:,:),[100:100:1200],'Normalization','probability');
% % subplot(2,2,4)
% % C4 = histogram(Subtract(4,:,:,:),[100:100:1200],'Normalization','probability');
% % Court = C1.Values;

%% 大于0的值 做直方图
% 
% range = [-20:20:300];
% sz = size(range);
% a = 1;
% SV = zeros([a,sz(2)-1]);
% figure()
% subplot(2,2,1)
% S1 = histogram(Scan11(1,:,:,:),range,'Normalization','probability');
% 
% SV(a,:) = S1.Values;
% SV(a,:) = SV(a,:)/sum(SV(a,:));
% title('2CT1')
% ylim([0 0.003])
% subplot(2,2,2)
% S2 = histogram(Scan11(2,:,:,:),range,'Normalization','probability');
% a = 2;
% SV(a,:) = S2.Values;
% SV(a,:) = SV(a,:)/sum(SV(a,:));
% ylim([0 0.003])
% title('2CT2')
% subplot(2,2,3)
% S3 = histogram(Scan11(3,:,:,:),range,'Normalization','probability');
% ylim([0 0.003])
% title('2CT3')
% subplot(2,2,4)
% a = 3;
% SV(a,:) = S3.Values;
% SV(a,:) = SV(a,:)/sum(SV(a,:));
% S4 = histogram(Scan11(4,:,:,:),range,'Normalization','probability');
% ylim([0 0.003])
% a = 4;
% SV(a,:) = S4.Values;
% SV(a,:) = SV(a,:)/sum(SV(a,:));
% title('2CT4')
% 
% 
% figure()
% XL = range(1:(sz(2)-1));
% y_max = max(SV,[],'a')+ 0.05;
% subplot(1,4,1)
% bar(XL,SV(1,:))
% title('Value-distribution-CT1-20201222')
% xlabel('Value of voxel ')
% ylabel('Percentage')
% ylim([0 y_max])
% 
% 
% subplot(1,4,2)
% bar(XL,SV(2,:))
% xlabel('Value of voxel ')
% title('Value-distribution-CT2-20201228')
% ylabel('Percentage')
% ylim([0 y_max])
% 
% subplot(1,4,3)
% bar(XL,SV(3,:))
% xlabel('Value of voxel ')
% title('Value-distribution-CT3-20201229')
% ylabel('Percentage')
% ylim([0 y_max])
% 
% subplot(1,4,4)
% bar(XL,SV(4,:))
% xlabel('Value of voxel ')
% title('Value-distribution-CT4-20201230')
% ylabel('Percentage')
% ylim([0 y_max])

%% MIP Label = 1   Background = 0
A = 3;
MIP1 = MIP(squeeze(Scan11(1,:,:,:)),squeeze(Scan_label(1,:,:,:)),A);
MIP2 = MIP(squeeze(Scan11(2,:,:,:)),squeeze(Scan_label(2,:,:,:)),A);
MIP3 = MIP(squeeze(Scan11(3,:,:,:)),squeeze(Scan_label(3,:,:,:)),A);
MIP4 = MIP(squeeze(Scan11(4,:,:,:)),squeeze(Scan_label(4,:,:,:)),A);
% MIP5 = MIP(squeeze(Scan(5,:,:,:)),squeeze(Scan_label(5,:,:,:)));

%
% clims = [-3.9e5,-3.3e5];
figure(1)
subplot(2,2,1)
% imagesc(Scan1(:,:,34))
% imagesc(MIP1,clims)
imagesc(MIP1)
colormap('gray')
title("Slice1-0528")
view(-90,90);


subplot(2,2,2)
% imagesc(Scan2(:,:,34))
% imagesc(MIP2,clims)
imagesc(MIP2)
title("Slice2-0610")
view(-90,90);

subplot(2,2,3)
% imagesc(MIP3,clims)
imagesc(MIP3)
% imagesc(Scan3(:,:,34))
title("Slice3-0617")
view(-90,90);

subplot(2,2,4)
% imagesc(MIP4,clims)
imagesc(MIP4)
title("Slice4-0626")
% colorbar
view(-90,90);

% subplot(2,3,5)
% imagesc(MIP5)
% % imagesc(Scan5(:,:,34))
% view(-90,90);

%%
T1 = cat(2,MIP1,MIP2);
T2 = cat(2,MIP3,MIP4);
T = cat (1,T1,T2);
imagesc(T)
colormap('gray')
view([-90 90])
% axis equal