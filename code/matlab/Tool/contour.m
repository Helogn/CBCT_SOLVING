clear all
clc
% read file from path
Catch = 'Catch_col_019';
Contour_Information_path = strcat('D:\MRES\Label\' , Catch , '\contour.dcm');
PLAN_nii =strcat('D:\MRES\Label\', Catch, '\PCT.nii');
% Aim_path = strcat('D:\MRES\Label\', Catch , '\RLabel.nii');
Aim_path = strcat('D:\MRES\Label\', Catch , '\PTV.nii');
PLAN_info = niftiinfo(PLAN_nii);
pct = niftiread(PLAN_nii);
image = niftiread(PLAN_nii);

% process data
% info = dicominfo(Contour_Information_path,'UseVRHeuristic',false);
info = dicominfo(Contour_Information_path,"UseVRHeuristic",false);
rtContours = dicomContours(info);  
rtContours.ROIs
%%
contourIndex = 17; 
plotContour(rtContours,contourIndex);


%%

sz = size(image);
X = [-PLAN_info.Transform.T(4),-PLAN_info.Transform.T(4)-PLAN_info.Transform.T(1)*sz(1)];
Y = [-PLAN_info.Transform.T(8)-PLAN_info.Transform.T(6)*sz(2),-PLAN_info.Transform.T(8)];
Z = [PLAN_info.Transform.T(12),PLAN_info.Transform.T(12)+PLAN_info.Transform.T(11)*sz(3)];

referenceInfo = imref3d(PLAN_info.ImageSize,X,Y,Z);
rtMask1 = createMask(rtContours,18, referenceInfo);
% rtMask2 = createMask(rtContours,14, referenceInfo);
rtMaskT = createMask(rtContours,4, referenceInfo);
% rtMaskonly = createMask(rtContours,16, referenceInfo);
% % rtMask1 = createMask(rtContours, 10, referenceInfo);
% rtMask2 = createMask(rtContours,16, referenceInfo);
% rtMaskT = createMask(rtContours,4, referenceInfo);
% rtMask = rtMask1  + rtMask2 - rtMaskT;
rtMask = rtMask1 ;%  - rtMaskT;
% rtMask = rtMaskonly;
% rtMask = rtMaskT;
rtMask(rtMask == -1) = 0;
volshow(rtMask);

%%
close all
sz = size(image);
A = zeros(sz);

for i = 1: sz(1)
    for j = 1:sz(2)
        for k = 1:sz(3)          
            A(j,sz(1)+1-i,k) = rtMask(i,j,k);
        end
    end
end

% rtMask = image;

rtMask1 = A;
figure(1)
subplot(2,2,1)
imagesc(squeeze(rtMask1(:,200,:)))
view([-90 90])
% xlabel("x")
% ylabel("Y")
title('Lung Mask slice created from contour')
subplot(2,2,2)
imagesc(squeeze(image(:,200,:)))
view([-90 90])
colormap('gray')
% xlabel("x")
% ylabel("Y")
title('PCT slice')
subplot(2,2,3)
imagesc(rtMask1(:,:,70))
view([-90 90])
% xlabel("x")
% ylabel("Y")
title('Lung Mask created from contour')
subplot(2,2,4)
imagesc(image(:,:,70))
% xlabel("Y")
colormap('gray')
view([-90 90])
title('PCT slice')
%%
pct(A == 0) = -1000;
SE = strel('cube',3);
pct = imerode(pct,SE);
%%
% hhh = 'D:\MRES\Label\Catch001\PCT.nii';
close all
% Aim_path = 'D:\MRES\Label\Catch_col_019\PPT.nii';
data = load_untouch_nii(PLAN_nii);
B = int16(A);
data.img = B;
save_untouch_nii(data,Aim_path)
finish = 0