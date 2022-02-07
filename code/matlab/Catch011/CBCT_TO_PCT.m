clear all
Data_path = "D:\MRES\Label\Catch011\C\C";
Label = niftiread("D:\MRES\Label\Catch011\Label");
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

N = 10;
for i = 1:1:N

    eval(['Scan',num2str(i),'=','Input(Data_path + Scan',num2str(i),'_path,Label);']);

end

% Scan1 = APfilter(Scan1,A,sigma)
A = 7;
sigma = 3;

for i = 1:1:N

    eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',A,sigma);']);

end

A = 2;
for i = 1:1:N
    eval(['MIP',num2str(i),'=','MIP(Scan',num2str(i),',Label,A);']);
end


Result1 = cat(1,MIP1,MIP2,MIP3,MIP4,MIP5);
Result2 = cat(1,MIP6,MIP7,MIP8,MIP9,MIP10);
Result = cat(2,Result2,Result1);
imagesc(Result)
colormap('gray')
title('Catch11')
daspect([1 4 1]);
view([-90 90])

%%
for i = 1:1:N

    eval(['Sum(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);

end
plot(Sum1)
%%

