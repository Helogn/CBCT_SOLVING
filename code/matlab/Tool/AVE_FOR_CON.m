clear all
close all
% calculate average changes among size

% ST = [7,9,11,12,13,14,18,19,20,21];
ST = 1:9;
% ST = [6,8,15,16,10,17]
szL = size(ST);
for T = 1:szL(2)
    Index = ST(T)
    if Index < 10
        A = 'Catch_col_00';
    else
        A = 'Catch_col_0'
    end
    num = strcat(A,num2str(Index))
    path = strcat('D:\MRES\Label\',num,'\C\');

    % -------------------------Jiang-------------------------
    Label = niftiread(strcat('D:\MRES\Label\',num,'\RLabel.nii'));
    sz = size(Label);
%     t = zeros(sz);
%     for i = 1:sz(1)
%         for j = 1 :sz(2)
%             for k = 1 : sz(3)
%                 t(i,j,k) = Label(i,sz(2)+1-j,k);
%             end
%         end
%     end
%     Label = t;

    %----------------------------------------
    PCT = Input(strcat('D:\MRES\Label\',num,'\PCT.nii'),Label);
    list = dir([path +'*.nii']);
    sz = size(list);
    A = 20;
    sigma = 10;

    for i = 1 : sz(1)

        eval(['Scan',num2str(i),'=','Input(strcat(path,list(i).name),Label);']);
        eval(['B = Scan',num2str(i),';']);
%         eval(['Scan',num2str(i),'= APfilter(Scan',num2str(i),',A,sigma);'])
        eval(['Scan',num2str(i),'(B == -1000) = -1000;'])
        clear B
    
    %     eval(['Scan',num2str(i),'=','APfilter(Input(strcat(path,list(i).name),Label),A,sigma);']);
    end
    for i = 1:1:sz(1)
        eval(['Sum',num2str(T),'(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);
        eval(['SL',num2str(T),'= sz(1);']);

        
    end
%     
%     plot(1:sz(1),Sum)
%     title(strcat(num))


end
    
  %%

figure(1)
plot(1:SL1,Sum1)
hold on 
for N = 1 : szL(2)
    eval(['plot(1:SL',num2str(N),',Sum',num2str(N),')'])
end
xlim([0,23])
% ylim([-150,-90])
title('average intensity for Control catch')
xlabel('date')
legend('C1','C2','C3','C4','C5','C6','C7','C8','C9')
%%
figure(1)
plot(1:SL1,Sum1)
hold on 
plot(1:SL2,Sum2)
plot(1:SL3,Sum3)