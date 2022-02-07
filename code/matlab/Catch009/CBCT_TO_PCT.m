clear all
Data_path = "D:\MRES\Label\Catch009\C\C";
Label = niftiread("D:\MRES\Label\Catch009\Label");
Scan1_path = '20200406.nii';
Scan2_path = '20200407.nii';
Scan3_path = '20200413.nii';
Scan4_path = '20200420.nii';
Scan5_path = '20200430.nii';
Scan6_path = '20200501.nii';


Scan1 = Input(Data_path + Scan1_path,Label);
Scan2 = Input(Data_path + Scan2_path,Label);
Scan3 = Input(Data_path + Scan3_path,Label);
Scan4 = Input(Data_path + Scan4_path,Label);
Scan5 = Input(Data_path + Scan5_path,Label);
Scan6 = Input(Data_path + Scan6_path,Label);
% Scan7 = Input(Data_path + Scan7_path,Label);
% Scan8 = Input(Data_path + Scan8_path,Label);
% Scan9 = Input(Data_path + Scan9_path,Label);
% Scan10 = Input(Data_path + Scan10_path,Label);

N = 6;
A = 7;
sigma = 2;

for i = 1:1:N

    eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',A,sigma);']);

end

%%  
% Scan1(Label==0) = -1000;
% Scan1(Scan1==0) = -1000;
% Scan2(Label==0) = -1000;
% Scan2(Scan2==0) = -1000;
% Scan3(Label==0) = -1000;
% Scan4(Label==0) = -1000;
% Scan5(Label==0) = -1000;
% Scan6(Label==0) = -1000;
% Scan7(Label==0) = -1000;
% Scan8(Label==0) = -1000;
% Scan9(Label==0) = -1000;
% Scan10(Label==0) = -1000;
%%
A = 2;
MIP1 = MIP(Scan1,Label,A);
MIP2 = MIP(Scan2,Label,A);
MIP3 = MIP(Scan3,Label,A);
MIP4 = MIP(Scan4,Label,A);
MIP5 = MIP(Scan5,Label,A);
MIP6 = MIP(Scan6,Label,A);



Result1 = cat(1,MIP1,MIP2,MIP3);
Result2 = cat(1,MIP4,MIP5,MIP6);
Result = cat(2,Result2,Result1);
imagesc(Result)
colormap('gray')
title('Catch11')
daspect([1 4 1]);
view([-90 90])

%%
Sum1(1) = SumP(Scan1,Label);
Sum1(2) = SumP(Scan2,Label);
Sum1(3) = SumP(Scan3,Label);
Sum1(4) = SumP(Scan4,Label);
Sum1(5) = SumP(Scan5,Label);
Sum1(6) = SumP(Scan6,Label);
Sum1(7) = SumP(Scan7,Label);
Sum1(8) = SumP(Scan8,Label);
Sum1(9) = SumP(Scan9,Label);
Sum1(10) = SumP(Scan10,Label);
%%
plot(Sum1)
%%

