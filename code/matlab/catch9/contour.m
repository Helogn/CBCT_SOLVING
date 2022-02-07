clear all
clc
% read file from path
Catch = "Catch009";
Contour_Information_path = 'D:\MRES\Label\' + Catch + '\contour.dcm';
PLAN_nii = 'D:\MRES\Label\'+ Catch + '\PCT.nii';
Aim_path = 'D:\MRES\Label\'+ Catch + '\Label.nii';
PLAN_info = niftiinfo(PLAN_nii);
image = niftiread(PLAN_nii);

% process data
info = dicominfo(Contour_Information_path);
rtContours = dicomContours(info);  
% rtContours.ROIs
% plotContour(rtContours,25);


%%

sz = size(image);
X = [-PLAN_info.Transform.T(4),-PLAN_info.Transform.T(4)-PLAN_info.Transform.T(1)*sz(1)];
Y = [-PLAN_info.Transform.T(8)-PLAN_info.Transform.T(6)*sz(2),-PLAN_info.Transform.T(8)];
Z = [PLAN_info.Transform.T(12),PLAN_info.Transform.T(12)+PLAN_info.Transform.T(11)*sz(3)];

%%
referenceInfo = imref3d(PLAN_info.ImageSize,X,Y,Z);
contourIndex = 24; 
rtMask = createMask(rtContours, contourIndex, referenceInfo);
volshow(rtMask);

%%

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
B = int16(rtMask1);
data = load_untouch_nii(PLAN_nii);

%%
B = int16(rtMask1);
data.img = B;
save_untouch_nii(data,Aim_path)
