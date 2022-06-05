% test HU threshold
% He Jiang 2022-6-5
clear all; close all;clc



Aim_Index = [19];
sz_index = size(Aim_Index);
Time_of_smooth = 1;
Judge = 1;
% parameters of filter kernel
Length_of_kernel = 20;
sigma = 10;

%% Path Part

for N = 1 : sz_index(2)
    if Aim_Index(N) < 10
        A = 'Catch00';
    else
        A = 'Catch0';
    end

%         if I < 10
%             A = 'Catch_col_00';
%         else
%             A = 'Catch_col_0';
%         end

    num = strcat(A,num2str(Aim_Index(N)));
    CBCT_Path = strcat('D:\MRES\Label\',num,'\DEF\');
%     Aim_path = strcat('D:\MRES\Label\',num,'\erosion');
    Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
    PCT = Input(strcat('D:\MRES\Label\',num,'\PCT.nii'),Label);
