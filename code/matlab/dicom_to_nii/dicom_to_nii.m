% He Jiang
% Transfer Dicom to Nii
clear all;
close all;
clc;
File_Path = "D:\MRES\covid19-open-xnat.cs.ucl.ac.uk\CATCH_0022\";
Dir = dir(File_Path);
% load di.mat
length_Dir = length(Dir);

%%
for i = 3:length_Dir
    Dir2 = dir(File_Path + (Dir(i).name));
    mkdir(File_Path+ Dir(i).name + '\Nii');

    Dicom_folder = File_Path+ Dir(i).name
        
    aim_folder = (File_Path+ Dir(i).name +'\Nii')
    dicm2nii(Dicom_folder,aim_folder,0)


%     Dir2.name;
end
