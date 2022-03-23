clear all
clc

for i = 1:8
    if i < 10
        A = 'Catch_col_00';
    else
        A = 'Catch_col_0'
    end

    num = strcat(A,num2str(i)); ;
    path = strcat('D:\MRES\Label\',num,'\C\');
    
    Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
    eval(['Sum',num2str(i),' = plot_intensity(path,Label,num);'])
end
%%
figure(2)
for i = 1:8
    subplot(2,4,i)
    eval(['plot(Sum',num2str(i),')'])
    title(i)
    eval(['len = size(Sum',num2str(i),');'])
    eval(['p = polyfit(1:len(2),Sum',num2str(i),',2);'])
    f1 = polyval(p,1:len(2));
    hold on 
    plot(1:len(2),f1,'-r')
    hold off


end
