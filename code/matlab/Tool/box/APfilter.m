function output = APfilter(image,A,sigma)
% This is a filter along AP direction
% image : input img
% A is size of filter kernel
% sigma is the parameter of size


hsize = [A,1];
h = fspecial('gaussian',hsize,sigma) ;
kernal = zeros(A,A,A);
if mod(A,2) == 0
    B = A/2;
else
%奇数
    B = floor((A+1)/2);
end
kernal(B,:,B) = h;

output = imfilter(image,kernal,'same');
end