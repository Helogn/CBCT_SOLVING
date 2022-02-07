% buid MIP for catch 001
clear all
close all
clc

File_Path = "D:\MRES\DATASETS\CATCH_0009\";
Mask_path = 'seg.nii';
% Plan_path = 'PLAN.nii';
Label_image1_path = 'R20200406.nii';
Label_image2_path = 'R20200413.nii';
Label_image3_path = 'R20200420.nii';
Label_image4_path = 'R20200430.nii';
Label_image5_path = 'R20200501.nii';

% image
image1_path = '20200406.nii';
image2_path = '20200413.nii';
image3_path = '20200420.nii';
image4_path = '20200430.nii';
image5_path = '20200501.nii';

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
% colormap('gray')
title('SUM-CBCT20200406')
% title('MIP-CBCT20200406')
view(-90,90);

subplot(2,2,2)
imagesc(Image5)
% colormap('gray')
% title('MIP-CBCT20201223')
title('SUM-CBCT20201223')
view(-90,90);

subplot(2,2,3)
imagesc(Image3)
% colormap('gray')
title('SUM-CBCT20200420')
% title('MIP-CBCT20200420')
view(-90,90);


subplot(2,2,4)
imagesc(Image4)
% colormap('gray')
% title('MIP-CBCT20200430')
title('SUM-CBCT20200430')
view(-90,90);
%%


