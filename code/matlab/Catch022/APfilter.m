function output = APfilter(image,A,sigma)
hsize = [A,1];
h = fspecial('gaussian',hsize,sigma) ;
kernal = zeros(A,A,A);
if mod(A,2)
    B = A/2;
else
%奇数
    B = floor((A+1)/2);
end
kernal(B,:,B) = h;

output = imfilter(image,kernal,'same');
end