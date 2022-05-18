function output = ThreeAPfilter(image,A,sigma)
hsize = [A];

volSmooth = imgaussfilt3(hsize, sigma);
kernal = zeros(A,A,A);
if mod(A,2) == 0
    B = A/2;
else
%奇数
    B = floor((A+1)/2);
end
kernal(B,:,B) = h;

output = imfilter(image,volSmooth,'same');
end