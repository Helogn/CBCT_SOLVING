clear all
Data_path = "D:\MRES\Label\Catch009\";

Scan1_path = '20200406.nii';
Scan2_path = '20200407.nii';
Scan3_path = '20200413.nii';
Scan4_path = '20200420.nii';
Scan5_path = '20200430.nii';
Scan6_path = '20200501.nii';

A = 6;
sigma = 6;

Scan1 = APfilter(niftiread(Data_path + Scan1_path),A,sigma);
Scan2 = APfilter(niftiread(Data_path + Scan2_path),A,sigma);
Scan3 = APfilter(niftiread(Data_path + Scan3_path),A,sigma);
Scan4 = APfilter(niftiread(Data_path + Scan4_path),A,sigma);
Scan5 = APfilter(niftiread(Data_path + Scan5_path),A,sigma);
Scan6 = APfilter(niftiread(Data_path + Scan6_path),A,sigma);


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



A = 4;
MIP1 = MIP(Scan1,Scan1_label,A);
MIP2 = MIP(Scan2,Scan2_label,A);
MIP3 = MIP(Scan3,Scan3_label,A);
MIP4 = MIP(Scan4,Scan4_label,A);
MIP5 = MIP(Scan5,Scan5_label,A);
MIP6 = MIP(Scan6,Scan6_label,A);



Result1 = cat(1,MIP1,MIP2,MIP3);
Result2 = cat(1,MIP4,MIP5,MIP6);
Result = cat(2,Result1,Result2);
figure()
imagesc(Result)
title('Catch009')
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

N = 6;
for i = 1:N
    varient = ['Scan',num2str(i)];
    Sum_voxel(i) = sum (varient,'all')/Sum(i);
end

figure()
plot(1:N,(Sum_voxel(1:N)),'-V')
title('Catch009 Average Intensity')
set(gca,'xtick',1:1:N)  
xtickformat('%g Scan')


