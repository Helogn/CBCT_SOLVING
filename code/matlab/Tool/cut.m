function [out,x,y,jug] = cut(img,x,y,jug)
% arr1 = 0;
img = squeeze(img);
sum1 = -1000;
% arr2 = 0;
% jugy = 0;
sumy = -1000;
if jug == 1
    
    arr1 = squeeze(mean (img , 1));
    arr2 = squeeze(mean (img , 2));
    sz1 = squeeze(size(arr1));
    sz2 = squeeze(size(arr2));
    for i = 1 : sz1(2)
        
%         sum1 = (sum1 + arr1(i) )/2;
           
        if arr1(i)  == -1000
            x = x + 1;
        else 
            break
         
        end

    end

    for j = 1 : sz2(1)
        
        sumy = (sumy + arr2(j) )/2;
        if arr2(j)  == -1000
            y = y + 1;
        else
            break
        end
    end
    jug = 2;
    y = y-12;
    x = x-6;
end

sz = size(img);

out = img(y:(sz(1)-y),x:(sz(2)-x));

end