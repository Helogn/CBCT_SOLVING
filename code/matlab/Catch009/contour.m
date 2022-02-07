clear all
clc
% read file from path
Contour_path = 'D:\MRES\Label\Catch011\contour.dcm';
% PLAN_nii1 = "D:\MRES\Label\Catch009\original\20200406";
PLAN_nii = 'D:\MRES\Label\Catch011\PCT.nii';

PLAN_info = niftiinfo(PLAN_nii);
image = niftiread(PLAN_nii);

% process data
info = dicominfo(Contour_path);
rtContours = dicomContours(info);  
rtContours.ROIs
% plotContour(rtContours,26);


%%

sz = size(image);
% X = [-PLAN_info.Transform.T(4),-PLAN_info.Transform.T(4)-PLAN_info.Transform.T(1)*sz(1)];
% Y = [PLAN_info.Transform.T(8),PLAN_info.Transform.T(8)+PLAN_info.Transform.T(6)*sz(2)];
% Z = [PLAN_info.Transform.T(12),PLAN_info.Transform.T(12)+PLAN_info.Transform.T(11)*sz(3)];

X = [-PLAN_info.Transform.T(4),-PLAN_info.Transform.T(4)-PLAN_info.Transform.T(1)*sz(1)];
Y = [-PLAN_info.Transform.T(8)-PLAN_info.Transform.T(6)*sz(2),-PLAN_info.Transform.T(8)];
Z = [PLAN_info.Transform.T(12),PLAN_info.Transform.T(12)+PLAN_info.Transform.T(11)*sz(3)];

%%
referenceInfo = imref3d(PLAN_info.ImageSize,X,Y,Z);
% referenceInfo = imref3d([328,328,50],X,Y,Z);

% contourIndex = 'Lung_Opt';  
 
% rtMask = createMask(rtContours, contourIndex, spatial);
rtMask1 = createMask(rtContours, 2, referenceInfo);
rtMask2 = createMask(rtContours, 3, referenceInfo);
rtMask = rtMask1 + rtMask2;
volshow(rtMask);



%%

% clear V A 

% V = niftiread(PLAN_nii);



% path = 'D:\MRES\DATASETS\CATCH_0001\contour.dcm';
% info = dicominfo(path);
% 
% V(rtMask==0) = 0;
% V(rtMask==1) = 1;
sz = size(image);

A = zeros(sz);

for i = 1: sz(1)
    for j = 1:sz(2)
        for k = 1:sz(3)
%             
            A(j,sz(1)+1-i,k) = rtMask(i,j,k);
%             A(i,j,k) = rtMask(i,j,k);
        end
    end
end

% rtMask = image;
%
rtMask1 = A;
figure(1)
subplot(2,2,1)
imagesc(squeeze(rtMask1(:,200,:)))
subplot(2,2,2)
imagesc(squeeze(image(:,200,:)))
xlabel("x")
title('image')
subplot(2,2,3)
imagesc(rtMask1(:,:,70))
subplot(2,2,4)
imagesc(image(:,:,70))
title('image')

%%
% figure(1)
% subplot(2,2,1)
% imagesc(squeeze(rtMask1(:,200,:)))
% subplot(2,2,2)
% imagesc(squeeze(image(:,200,:)))
% xlabel("x")
% title('image')
% subplot(2,2,3)
% imagesc(rtMask1(:,:,70))
% subplot(2,2,4)
% imagesc(image(:,:,70))
% title('image')

%%
B = int16(rtMask1);

Contour_path = 'D:\MRES\Label\Catch011\PCT.nii';
data = load_untouch_nii(Contour_path);

%%
B = int16(rtMask1);
data.img = B;
save_untouch_nii(data,'D:\MRES\Label\Catch011\Label.nii')
% niftiwrite(B,'D:\MRES\Label\Catch009\original\Label.nii',PLAN_info,'Version','NIfTI2');


%%

% clc
% clear all
% hh = 'PCT.nii';
% PLAN_nii = "D:\MRES\DATASETS\CATCH_0009\" + hh;
% PLAN_info = niftiinfo(PLAN_nii);
% image = niftiread(PLAN_nii);
% % delete "D:\MRES\Label\Catch009\" + hh;
% niftiwrite(image,"D:\MRES\Label\Catch009\" + hh,PLAN_info);