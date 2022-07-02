%sequence of array
function out = sequence(input,start,increase)
hh = input;
sz = size(input);
sequ = ones(sz);
for i = 1:sz(1)
    sequ(i,:) = sequ(1,:) * i;
end

% sequence
for k = 1:sz(2)
    for m = 1:sz(1) - 1
    for j = 1:sz(1) - 1
        if input(j,k) > input(j+1,k) 
            mid1 = input(j,k);
            input(j,k) = input(j+1,k);
            input(j+1,k) = mid1;

            mid2 = sequ(j,k);
            sequ(j,k) = sequ(j+1,k);
            sequ(j+1,k) = mid2;
        end
    end
    end
end
% output

out = zeros(sz);

for k = 1:sz(2)
    for j = 1:sz(1)
        out(sequ(j,k),k) = j;
        
    end
end
out(:,1) = 0;
scrsz = get(0,'ScreenSize'); %%%% 获取屏幕的尺寸
figure1=figure('Position',[0 30 scrsz(3) scrsz(4)-95]);
for i = 1:sz(1)
    plot(start + ((0:(sz(2)-1))*increase),out(i,:),'Color',[i/sz(1),0.5,0.5],'DisplayName',strcat('Image: ',num2str(i)),'LineWidth',3);
    hold on 
end
legend('Location','northwest');
ylim([-1 sz(1)+1]);
end
