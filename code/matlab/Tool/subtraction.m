% calculate subtraction image between closed images.
% Jiang He 2022-6-19

%% Load images and set arguments
clear all; close all; clc
Aim = [3];
if ind >= 10
    Catch = strcat('0',num2str(ind));
else
    Catch = strcat('00',num2str(ind));
end



% Path
Path_CB = strcat("D:\MRES\Label\Catch",Catch,"\DEF\");
PCT = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\PCT.nii"));
Label = niftiread(strcat("D:\MRES\Label\Catch",Catch,"\RLabel.nii"));




