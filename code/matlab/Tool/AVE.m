clear all
close all
%%
% calculate average changes among size
ST = [3
7
9
11
15
16
19
]';
% ST = [6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22];
% ST = 22;
% ST = 18
% ST = [6,8,15,16,10,17]
szL = size(ST);
for T = 1:szL(2)
    Index = ST(T)
    if Index < 10
        A = 'Catch00';
    else
        A = 'Catch0'
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
        eval(['Sum',num2str(Index),'(',num2str(i),') = SumP(Scan',num2str(i),',Label);']);
        eval(['SL',num2str(Index),'= sz(1);']);

        
    end
%     
%     plot(1:sz(1),Sum)
%     title(strcat(num))


end
    
  %% 

figure(1)
% plot(1:SL1,Sum1)
hold on 
for N = 1 : szL(2)
    eval(['plot(1:SL',num2str(ST(N)),',Sum',num2str(ST(N)),')'])
    hold on
end
xlim([0.5,23])


% ylim([-150,-90])
% title('average intensity for catch')
% xlabel('date')
% legend('C6','C7','C8','C9','C10','C11','C12','C13','C14','C15','C16','C17','C18','C19','C20','C21','C22')



% confirmed positive date
C3 = 5;
% C4 = 8;
C7 = 3;
% C16 = 1:6;
% C18 = 8;
C19 = 5:6;

Ind = [3,7,19];
% Ind = 18
sz2 = size(Ind);
for j = 1 : sz2(2)
    eval(['scatter(C',num2str(Ind(j)),',Sum',num2str(Ind(j)),'(C',num2str(Ind(j)),'),"r")']);
end

title('average intensity for catch')
xlabel('date')
legend('3','7','9','11','15','16','19');
% legend('C6','C7','C8','C9','C10','C11','C12','C13','C14','C15','C16','C17','C18','C19','C20','C21','C22')


% --------------- suspect date ---------------------
S11 = 10;
S12 = 9;
S13 = 3;
S14 = 3;

% Ind = [11,12,13,14];
% % Ind = 18
% sz2 = size(Ind);
% for j = 1 : sz2(2)
%     eval(['scatter(S',num2str(Ind(j)),',Sum',num2str(Ind(j)),'(S',num2str(Ind(j)),'),"b")']);
% end

% title('average intensity for catch')
% xlabel('date')
% legend('C6','C7','C8','C9','C10','C11','C12','C13','C14','C15','C16','C17','C18','C19','C20','C21','C22')