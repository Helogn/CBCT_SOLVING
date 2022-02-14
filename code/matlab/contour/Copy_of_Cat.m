clear all
clc
% read file from path
P = 'Catch009';
Contour_path = strcat('D:\MRES\Label\', P ,'\contour.dcm');
PLAN_nii = strcat('D:\MRES\Label\', P ,'\PCT.nii');
save_path = strcat('D:\MRES\Label\' , P ,'\RLabel.nii');

PLAN_info = niftiinfo(PLAN_nii);
image = niftiread(PLAN_nii);

% process data
info = dicominfo(Contour_path);
rtContours = dicomContours(info);  
rtContours.ROIs
% plotContour(rtContours,26);
sz = size(image);

X = [-PLAN_info.Transform.T(4),-PLAN_info.Transform.T(4)-PLAN_info.Transform.T(1)*sz(1)];
Y = [-PLAN_info.Transform.T(8)-PLAN_info.Transform.T(6)*sz(2),-PLAN_info.Transform.T(8)];
Z = [PLAN_info.Transform.T(12),PLAN_info.Transform.T(12)+PLAN_info.Transform.T(11)*sz(3)];

referenceInfo = imref3d(PLAN_info.ImageSize,X,Y,Z);

%%
rtMask1 = createMask(rtContours, 25, referenceInfo);
% rtMask2 = createMask(rtContours, 10, referenceInfo);
rtMaskT = createMask(rtContours, 17, referenceInfo);
rtMask = rtMask1 - rtMaskT;
rtMask(rtMask==-1) = 0;
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

B = int16(rtMask);

data = load_untouch_nii(PLAN_nii);


data.img = B;
save_untouch_nii(data,save_path)
% niftiwrite(B,'D:\MRES\Label\Catch009\original\Label.nii',PLAN_info,'Version','NIfTI2');

