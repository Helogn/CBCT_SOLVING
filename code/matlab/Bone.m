clear all
close all 
clc
%%
name = '23';
sz = size(name);

PLAN_nii = strcat('D:\MRES\Label\Catch021\202006' , name ,'.nii');
Aim_path = "D:\MRES\Label\Catch021\Bone\B202006" + name+".nii";
PLAN_info = niftiinfo(PLAN_nii);
image = niftiread(PLAN_nii);
sz2 = size(image);
output = zeros(sz2);
output(image>150) = 1;
output = int16(output);

data = load_untouch_nii(PLAN_nii);
data.img = output;
save_untouch_nii(data,Aim_path)

%     niftiwrite(output,Aim_path,PLAN_info);
clear PLAN_nii Aim_path



%%
