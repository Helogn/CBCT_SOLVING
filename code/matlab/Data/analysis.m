%% He Jiang

% mean
clear all
close all
clc

load Catch12.mat
Scan = Scan
%% compare differences among these five images
% Subtract = zeros([3,sz(1),sz(2),sz(3)]);
% Subtract(1,:,:,:) = Scan_C_01(1,:,:,:) - Scan_C_01(2,:,:,:);
% Subtract(2,:,:,:) = Scan_C_01(1,:,:,:) - Scan_C_01(3,:,:,:);
% Subtract(3,:,:,:) = Scan_C_01(1,:,:,:) - Scan_C_01(4,:,:,:);
% % Subtract(4,:,:,:) = Scan(1,:,:,:) - Scan(5,:,:,:);
% Subtract = abs(Subtract);

%% MIP Label = 1   Background = 0
A = 3;
MIP1 = MIP(squeeze(Scan(1,:,:,:)),squeeze(Scan_label(1,:,:,:)),A);
MIP2 = MIP(squeeze(Scan(2,:,:,:)),squeeze(Scan_label(2,:,:,:)),A);
MIP3 = MIP(squeeze(Scan(3,:,:,:)),squeeze(Scan_label(3,:,:,:)),A);
MIP4 = MIP(squeeze(Scan(4,:,:,:)),squeeze(Scan_label(4,:,:,:)),A);
% MIP5 = MIP(squeeze(Scan(5,:,:,:)),squeeze(Scan_label(5,:,:,:)));

%
% clims = [-3.9e5,-3.3e5];
% figure(1)
% subplot(2,2,1)
% % imagesc(Scan1(:,:,34))
% % imagesc(MIP1,clims)
% imagesc(MIP1)
% colormap('gray')
% title("Slice1-0528")
% view(-90,90);
% 
% 
% subplot(2,2,2)
% % imagesc(Scan2(:,:,34))
% % imagesc(MIP2,clims)
% imagesc(MIP2)
% title("Slice2-0610")
% view(-90,90);
% 
% subplot(2,2,3)
% % imagesc(MIP3,clims)
% imagesc(MIP3)
% % imagesc(Scan3(:,:,34))
% title("Slice3-0617")
% view(-90,90);
% 
% subplot(2,2,4)
% % imagesc(MIP4,clims)
% imagesc(MIP4)
% title("Slice4-0626")
% % colorbar
% view(-90,90);

% subplot(2,3,5)
% imagesc(MIP5)
% % imagesc(Scan5(:,:,34))
% view(-90,90);


T1 = cat(2,MIP1,MIP3);
T2 = cat(2,MIP2,MIP4);
T = cat (1,T1,T2);
imagesc(T)
colormap('gray')
view([-90 90])
% axis equal