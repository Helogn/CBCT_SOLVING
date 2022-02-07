% buid MIP for catch 001
clear all
close all
clc

File_Path = "D:\MRES\Registered-12-12\";
Mask_path = 'Mask.nii';
% Plan_path = 'PLAN.nii';
Label_image1_path = 'R2-CT1.nii';
Label_image2_path = 'R2-CT2.nii';
Label_image3_path = 'R2-CT3.nii';
Label_image4_path = 'R2-CT4.nii';
Label_image5_path = 'R2-CT5.nii';

% label
image1_path = '2-CT1.nii';
image2_path = '2-CT2.nii';
image3_path = '2-CT3.nii';
image4_path = '2-CT4.nii';
image5_path = '2-CT5.nii';

% Read nii 

CBCT1 = niftiread(File_Path + image1_path);
CBCT2 = niftiread(File_Path + image2_path);
CBCT3 = niftiread(File_Path + image3_path);
CBCT4 = niftiread(File_Path + image4_path);
CBCT5 = niftiread(File_Path + image5_path);

% Read mask

Mask_CBCT1 = niftiread(File_Path + Label_image1_path);
Mask_CBCT2 = niftiread(File_Path + Label_image2_path);
Mask_CBCT3 = niftiread(File_Path + Label_image3_path);
Mask_CBCT4 = niftiread(File_Path + Label_image4_path);
Mask_CBCT5 = niftiread(File_Path + Label_image5_path);

%% erode
% sz = size(Mask);
% Mask_o = ones(sz(1),sz(2), sz(3));
% Mask_o(Mask==2) = 0;
% SE = strel('cube',3);
% Mask1 = imerode(Mask_o,SE);

%%
% subplot(2,1,1)
% imagesc(Mask_o(:,:,100));
% title('not erode')
% subplot(2,1,2)
% imagesc(Mask1(:,:,100));


%%

Image1 = MIP(CBCT1,Mask_CBCT1);
Image2 = MIP(CBCT2,Mask_CBCT2);
Image3 = MIP(CBCT3,Mask_CBCT3);
Image4 = MIP(CBCT4,Mask_CBCT4);
Image5 = MIP(CBCT5,Mask_CBCT5);

subplot(2,2,1)
imagesc(Image1)
colormap('gray')
% title('SUM-CBCT20201222')
title('MIP-CBCT20201222')
view(-90,90);

subplot(2,2,2)
imagesc(Image5)
colormap('gray')
title('MIP-CBCT20201223')
% title('SUM-CBCT20201223')
view(-90,90);

subplot(2,2,3)
imagesc(Image3)
colormap('gray')
% title('SUM-CBCT20201229')
title('MIP-CBCT20201229')
view(-90,90);


subplot(2,2,4)
imagesc(Image4)
colormap('gray')
title('MIP-CBCT20201230')
% % title('SUM-CBCT20201230')
view(-90,90);
%%


