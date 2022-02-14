clear all

for i = 10:21

    num = strcat('Catch0',num2str(i)); ;
    path = strcat('D:\MRES\Label\',num,'\C\');
    
    Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
    eval(['Sum',num2str(i),' = plot_intensity(path,Label,num);'])
end
%%
figure(2)
for i = 10:21
    subplot(2,6,i-9)
    eval(['plot(Sum',num2str(i),')'])
    title(i)
    eval(['len = size(Sum',num2str(i),');'])
    eval(['p = polyfit(1:len(2),Sum',num2str(i),',2);'])
    f1 = polyval(p,1:len(2));
    hold on 
    plot(1:len(2),f1,'-r')
    hold off


end
