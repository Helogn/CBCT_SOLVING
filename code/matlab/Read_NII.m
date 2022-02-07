% HE JIANG
% 2021/12/5
% read nii file
clear all
close all
clc

Path_PLAN = 'D:\MRES\Registered_nii\CATCH001\PLAN.nii';
Path_image1 = 'D:\MRES\Registered_nii\CATCH001\2_CBCT1_20201222.nii';
Path_image2 = 'D:\MRES\Registered_nii\CATCH001\2_CBCT2_20201228.nii';
Path_image3 = 'D:\MRES\Registered_nii\CATCH001\2_CBCT4_20201230.nii';

Plan = niftiread(Path_PLAN);
image1 = niftiread(Path_image1);
image2 = niftiread(Path_image2);
image3 = niftiread(Path_image3);
%%
% image1 = smooth3(image1);
% image2 = smooth3(image2);
% image3 = smooth3(image3);
%% show normal images

N = 107;
figure(1)
subplot(2,2,1)
imagesc(Plan(:,:,N))
title('2020-1208-PlanCT')
view(-90,90);
colormap('gray')
subplot(2,2,2)
imagesc(image1(:,:,N))
title('2020-1222-CBCT')
view(-90,90);
colormap('gray')
subplot(2,2,3)
imagesc(image2(:,:,N))
title('2020-1228-CBCT')
view(-90,90);
colormap('gray')
subplot(2,2,4)
imagesc(image3(:,:,N))
title('2020-1230-CBCT')
view(-90,90);
colormap('gray')


%% subtract
N = 107;
Plan = double(Plan);
IP1 = image1(:,:,N) - Plan(:,:,N);
IP1(IP1<0)=0;
% IP1(IP1==-1000)=0;
I12 = image2(:,:,N) - image1(:,:,N);
I12(I12<0)=0;
% I12(I12==-1000)=0;
I23 = image3(:,:,N) - image2(:,:,N);
I23(I23<0)=0;
% I23(I23==-1000)=0;

figure(2)
subplot(2,2,1)
imagesc(Plan(:,:,N))
title('PlanCT1208')
view(-90,90);
colorbar
% colormap('gray')


subplot(2,2,2)
imagesc(IP1)
title('CBCT1222 - PlanCT')
colorbar
view(-90,90);
% colormap('gray')


subplot(2,2,3)
imagesc(I12)
title('CBCT1228 - PlanCT')
view(-90,90);
colorbar
% colormap('gray')


subplot(2,2,4)
imagesc(I23)
title('CBCT1230 - PlanCT')
view(-90,90);
colormap('gray')
% caxis([-1020 500])
colorbar

%% Subtract
N = 107;
IP1 = image1(:,:,N) - Plan(:,:,N);
IP1(IP1<0)=0;
IP1(IP1>750)=0;
I12 = image2(:,:,N) - Plan(:,:,N);
I12(I12<0)=0;
I12(I12>750)=0;
I23 = image3(:,:,N) - Plan(:,:,N);
I23(I23<0)=0;
I23(I23>750)=0;

figure(2)
subplot(2,2,1)
imagesc(Plan(:,:,N))
title('PlanCT1208')
view(-90,90);
colorbar
% colormap('gray')


subplot(2,2,2)
imagesc(IP1)
title('CBCT1222 - PlanCT')
colorbar
view(-90,90);
% colormap('gray')


subplot(2,2,3)
imagesc(I12)
title('CBCT1228 - PlanCT')
view(-90,90);
colorbar
% colormap('gray')


subplot(2,2,4)
imagesc(I23)
title('CBCT1230 - PlanCT')
view(-90,90);
colormap('gray')
% caxis([-1020 500])
colorbar