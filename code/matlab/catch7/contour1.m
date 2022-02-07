clear all
close all
clc
path = 'D:\MRES\DATASETS\CATCH_0007\15\secondary\RS.1.2.246.352.221.46592183080787827654679458152475611047.dcm';
% path1 = 'C:\Users\Jiang\Downloads\CATCH_0001\scans\4-OT1-unknown\resources\secondary\files\RS.1.2.246.352.221.4824350009557528179.1760959865329803176.dcm';
% nii = 'D:\MRES\DATASETS\CATCH_0001\4-CT1\Nii\Contouring_2_0_RTP_Body_FC17.nii';
% nii = 'D:\MRES\Registered_nii\CATCH001\PLAN.nii';
% path_slice = 'D:\MRES\DATASETS\CATCH_0001\3\DICOM';
% [V,spatial,dim] = dicomreadVolume(path_slice);
% nii2 = niftiinfo(nii);
% image = niftiread(nii);
% dims = nii2.PixelDimensions;
info = dicominfo(path);
rtContours = dicomContours(info);  
rtContours.ROIs
plotContour(rtContours,25)

%%
sz = size(image);
% X = [-nii2.Transform.T(4),-nii2.Transform.T(4)-nii2.Transform.T(1)*sz(1)];

% Y = [nii2.Transform.T(8),nii2.Transform.T(8)+nii2.Transform.T(6)*sz(2)];
% Z = [nii2.Transform.T(12),nii2.Transform.T(12)+nii2.Transform.T(11)*sz(3)];
X = -nii2.Transform.T(1);
Y = nii2.Transform.T(6);
Z = nii2.Transform.T(11);

% X(2) = X(2)-(1)
% A = -nii2.Transform.T(1);
% B = nii2.Transform.T(6);
% C = nii2.Transform.T(11);


%%
% % referenceInfo = imref3d([512,512,98],xlim,ylim,zlim);
% referenceInfo = imref3d(nii2.ImageSize,X,Y,Z);
% referenceInfo = imref3d(nii2.ImageSize);
contourIndex = 'BODY';  
rtMask = createMask(rtContours, contourIndex, spatial);
volshow(rtMask);



%%
Z = 100;
% rotate(image,[0,0,0],90);
subplot(2,2,1)
imagesc(squeeze(image(:,:,Z)))
colormap('gray')

subplot(2,2,2)
imagesc(squeeze(rtMask(:,:,Z)))
% imagesc(squeeze(rtMask(300,:,:)))

image2 = image;
image2(rtMask == 0) = -1000;
subplot(2,2,3)
imagesc(squeeze(image2(:,:,Z)))
%%
subplot(2,2,1)
imagesc(squeeze(rtMask(200,:,:)))
subplot(2,2,2)
imagesc(squeeze(rtMask(:,190,:)))
subplot(2,2,3)
imagesc(rtMask(:,:,60))
