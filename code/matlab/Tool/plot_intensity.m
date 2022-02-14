function Sum = plot_intensity(path,Label,num)


list = dir([path +'*.nii']);
sz = size(list);
A = 7;
sigma = 3;
for i = 1 : sz(1)
    eval(['Scan',num2str(i),'=','Input(strcat(path,list(i).name),Label);']);
    eval(['B = Scan',num2str(i),';']);
    eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',A,sigma);'])
    eval(['Scan',num2str(i),'(B == -1000) = -1000;'])
    clear B
end

for i = 1:1:sz(1)
    eval(['Sum(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);
end

% Sum1;
% plot(1:sz(1),Sum)
% title(num)

end


