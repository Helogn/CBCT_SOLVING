clear all
Data_path = "D:\MRES\Label\Catch011\";

Scan1_path = '20200527.nii';
Scan2_path = '20200528.nii';
Scan3_path = '20200601.nii';
Scan4_path = '20200608.nii';
Scan5_path = '20200611.nii';
Scan6_path = '20200616.nii';
Scan7_path = '20200617.nii';
Scan8_path = '20200624.nii';
Scan9_path = '20200625.nii';
Scan10_path = '20200626.nii';


Scan1 = niftiread(Data_path + Scan1_path);
Scan2 = niftiread(Data_path + Scan2_path);
Scan3 = niftiread(Data_path + Scan3_path);
Scan4 = niftiread(Data_path + Scan4_path);
Scan5 = niftiread(Data_path + Scan5_path);
Scan6 = niftiread(Data_path + Scan6_path);
Scan7 = niftiread(Data_path + Scan7_path);
Scan8 = niftiread(Data_path + Scan8_path);
Scan9 = niftiread(Data_path + Scan9_path);
Scan10 = niftiread(Data_path + Scan10_path);

Scan1_label =  niftiread(Data_path + 'R'+ Scan1_path);
Scan2_label =  niftiread(Data_path + 'R'+ Scan2_path);
Scan3_label =  niftiread(Data_path + 'R'+ Scan3_path);
Scan4_label =  niftiread(Data_path + 'R'+ Scan4_path);
Scan5_label =  niftiread(Data_path + 'R'+ Scan5_path);
Scan6_label =  niftiread(Data_path + 'R'+ Scan6_path);
Scan7_label =  niftiread(Data_path + 'R'+ Scan7_path);
Scan8_label =  niftiread(Data_path + 'R'+ Scan8_path);
Scan9_label =  niftiread(Data_path + 'R'+ Scan9_path);
Scan10_label =  niftiread(Data_path + 'R'+ Scan10_path);
Sum(1) = sum(Scan1_label,"all");Sum(4) = sum(Scan4_label,"all");
Sum(2) = sum(Scan2_label,"all");Sum(3) = sum(Scan3_label,"all");
Sum(7) = sum(Scan7_label,"all");Sum(5) = sum(Scan5_label,"all");
Sum(8) = sum(Scan8_label,"all");Sum(6) = sum(Scan6_label,"all");
% 
Scan1(Scan1_label==0) = -1000;
Scan2(Scan2_label==0) = -1000;
Scan3(Scan3_label==0) = -1000;
Scan4(Scan4_label==0) = -1000;
Scan5(Scan5_label==0) = -1000;
Scan6(Scan6_label==0) = -1000;
Scan7(Scan7_label==0) = -1000;
Scan8(Scan8_label==0) = -1000;
Scan9(Scan9_label==0) = -1000;
Scan10(Scan10_label==0) = -1000;
%%
A = 2;
MIP1 = MIP(Scan1,Scan1_label,A);
MIP2 = MIP(Scan2,Scan2_label,A);
MIP3 = MIP(Scan3,Scan3_label,A);
MIP4 = MIP(Scan4,Scan4_label,A);
MIP5 = MIP(Scan5,Scan5_label,A);
MIP6 = MIP(Scan6,Scan6_label,A);
% MIP6(:,54) = -1000;
MIP7 = MIP(Scan7,Scan7_label,A);
MIP7(:,54) = -384000;
MIP8 = MIP(Scan8,Scan8_label,A);
MIP9 = MIP(Scan9,Scan9_label,4);
MIP10 = MIP(Scan10,Scan10_label,A);


Result1 = cat(1,MIP1,MIP2,MIP3,MIP5);
Result2 = cat(1,MIP6,MIP7,MIP8,MIP10);
Result = cat(2,Result1,Result2);
imagesc(Result)
colormap('gray')
title('Catch11')
daspect([1 4 1]);
view([-90 90])

%%
Scan1(Scan1_label==0) = 0;
Scan2(Scan2_label==0) = 0;
Scan3(Scan3_label==0) = 0;
Scan4(Scan4_label==0) = 0;
Scan5(Scan5_label==0) = 0;
Scan6(Scan6_label==0) = 0;
Scan7(Scan7_label==0) = 0;
Scan8(Scan8_label==0) = 0;

N = 8;
for i = 1:N
    varient = ['Scan',num2str(i)];
    Sum_voxel(i) = sum (varient,'all')/Sum(i);
end

figure()
plot(1:N,(Sum_voxel(1:N)),'-V')
title('Catch0011 Average Intensity')
set(gca,'xtick',1:1:N)  
xtickformat('%g Scan')