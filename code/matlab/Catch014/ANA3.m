clear all
Data_path = "D:\MRES\Label\Catch014\";

Scan1_path = '20201104.nii';
Scan2_path = '20201106.nii';
Scan3_path = '20201109.nii';
Scan4_path = '20201116.nii';
Scan5_path = '20201119.nii';
Scan6_path = '20201123.nii';
Scan7_path = '20201126.nii';
Scan8_path = '20201130.nii';
% vars = []
% for i = 1:8
% 
%     vars{1,i} = ['Scan',num2str(i)]
%     eval([vars{1,i},'=',strcat("niftiread(Data_path" , "_path)")])

Scan1 = niftiread(Data_path + Scan1_path);
Scan2 = niftiread(Data_path + Scan2_path);
Scan3 = niftiread(Data_path + Scan3_path);
Scan4 = niftiread(Data_path + Scan4_path);
Scan5 = niftiread(Data_path + Scan5_path);
Scan6 = niftiread(Data_path + Scan6_path);


Scan1_label =  niftiread(Data_path + 'RBone'+ Scan1_path);
Sum(1) = sum(Scan1_label,"all");
Scan2_label =  niftiread(Data_path + 'RBone'+ Scan2_path);
Sum(2) = sum(Scan2_label,"all");
Scan3_label =  niftiread(Data_path + 'RBone'+ Scan3_path);
Sum(3) = sum(Scan3_label,"all");
Scan4_label =  niftiread(Data_path + 'RBone'+ Scan4_path);
Sum(4) = sum(Scan4_label,"all");
Scan5_label =  niftiread(Data_path + 'RBone'+ Scan5_path);
Sum(5) = sum(Scan5_label,"all");
Scan6_label =  niftiread(Data_path + 'RBone'+ Scan6_path);
Sum(6) = sum(Scan6_label,"all");

% 
Scan1(Scan1_label==0) = -1000;
Scan2(Scan2_label==0) = -1000;
Scan3(Scan3_label==0) = -1000;
Scan4(Scan4_label==0) = -1000;
Scan5(Scan5_label==0) = -1000;
Scan6(Scan6_label==0) = -1000;


%%
A = 2;
MIP1 = MIP(Scan1,Scan1_label,A);
MIP2 = MIP(Scan2,Scan2_label,A);
MIP3 = MIP(Scan3,Scan3_label,A);
MIP4 = MIP(Scan4,Scan4_label,A);
MIP5 = MIP(Scan5,Scan5_label,A);
MIP6 = MIP(Scan6,Scan6_label,A);


%%
Result1 = cat(1,MIP1,MIP2,MIP3);
Result2 = cat(1,MIP4,MIP5,MIP6);
Result = cat(2,Result1,Result2);
figure()
imagesc(Result)
colormap('gray')
daspect([1 4 1]);
view([-90 90])

%%
Scan1(Scan1_label==0) = 0;
Scan2(Scan2_label==0) = 0;
Scan3(Scan3_label==0) = 0;
Scan4(Scan4_label==0) = 0;
Scan5(Scan5_label==0) = 0;
Scan6(Scan6_label==0) = 0;


for i = 1:6
    varient = ['Scan',num2str(i)];
    Sum_voxel(i) = sum (Scan6,'all')/Sum(i);
end

figure()
plot(Sum_voxel)
