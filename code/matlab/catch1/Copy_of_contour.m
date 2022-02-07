%% load info
clear all
clc
path = 'D:\MRES\Label\Catch001\contour.dcm';
% path1 = 'C:\Users\Jiang\Downloads\CATCH_0001\scans\4-OT1-unknown\resources\secondary\files\RS.1.2.246.352.221.4824350009557528179.1760959865329803176.dcm';
% nii = 'D:\MRES\DATASETS\CATCH_0001\4-CT1\Nii\Contouring_2_0_RTP_Body_FC17.nii';
nii = 'D:\MRES\Label\Catch001\PLAN.nii';
path_slice = 'D:\MRES\DATASETS\CATCH_0001\3\DICOM';
% [V,spatial,dim] = dicomreadVolume(path_slice);
nii2 = niftiinfo(nii);
image = niftiread(nii);
dims = nii2.PixelDimensions;
info = dicominfo(path);
rtContours = dicomContours(info);  
rtContours.ROIs
plotContour(rtContours,8);
%extract the dimension limits


%% coordinate
sz = size(image);
X = [-nii2.Transform.T(4),-nii2.Transform.T(4)-nii2.Transform.T(1)*sz(1)];

Y = [nii2.Transform.T(8),nii2.Transform.T(8)+nii2.Transform.T(6)*sz(2)];
Z = [nii2.Transform.T(12),nii2.Transform.T(12)+nii2.Transform.T(11)*sz(3)];
% X = -nii2.Transform.T(1);
% Y = nii2.Transform.T(6);
% Z = nii2.Transform.T(11);

% X(2) = X(2)-(1)
% A = -nii2.Transform.T(1);
% B = nii2.Transform.T(6);
% C = nii2.Transform.T(11);


%%
% % referenceInfo = imref3d([512,512,98],xlim,ylim,zlim);
referenceInfo = imref3d(nii2.ImageSize,X,Y,Z);
% referenceInfo = imref3d([512,512,195],xlim,ylim,zlim);
% referenceInfo = imref3d(nii2.ImageSize);
contourIndex = 8;  
% rtMask = createMask(rtContours, contourIndex, spatial);
rtMask = createMask(rtContours, contourIndex, referenceInfo);
volshow(rtMask);



%% select A from Mask
nii = 'D:\MRES\Label\Catch001\PLAN.nii';
% path_slice = 'D:\MRES\DATASETS\CATCH_0001\3\DICOM';
% [V,spatial,dim] = dicomreadVolume(path_slice);
nii2 = niftiinfo(nii);
V = niftiread(nii);



% path = 'D:\MRES\DATASETS\CATCH_0001\contour.dcm';
% info = dicominfo(path);

V(rtMask==0) = 0;
V(rtMask==1) = 1;

A = V;
sz = size(A);

for i = 1: sz(1)
    for j = 1:sz(2)
        for k = 1:sz(3)
            A(i,sz(2)+1-j,k) = V(j,i,k);
        end
    end
end

% niftiwrite(A,'D:\MRES\DATASETS\CATCH_0001\Label1.nii',nii2);



%% plot image and mask
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

%% load info

B = int16(rtMask1);

Contour_path = 'D:\MRES\Label\Catch001\PCT.nii';
data = load_untouch_nii(Contour_path);

%% write nii
B = int16(rtMask1);
data.img = B;
save_untouch_nii(data,'D:\MRES\Label\Catch001\Label.nii')
