 %%
clear all
clc
% judge mip or sip；
% Judge = 2;

Aim = 16;

sz1 = size(Aim);
% smooth for label
t = 1;


I = Aim;
if I < 10
    A = 'Catch00';
else
    A = 'Catch0';
end
%         if I < 10
%             A = 'Catch_col_00';
%         else
%             A = 'Catch_col_0';
%         end
num = strcat(A,num2str(I));

Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
Aim_path = strcat('D:\MRES\Label\', num, '\RPTV.nii');
% ---------------------------
mx = max(Label,[],'all');
sz = size(Label);
Mask1 = zeros(sz(1),sz(2), sz(3));
Mask1(Label==mx) = 1;
SE = strel('cube',3);
if t > 0
    for i = 1 : t
        Mask1 = imerode(Mask1,SE);
    end
end

%------------------------------------------------
PCT = strcat('D:\MRES\Label\',num,'\PCT.nii');
%         close all
data = load_untouch_nii(PCT);

data.img = Mask1;
save_untouch_nii(data,Aim_path)




