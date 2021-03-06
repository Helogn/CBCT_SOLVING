% He Jiang
% output erosion image
function [output,label_image] = Out_erosion(input_image, label_image,t,Judge)
% t: times of erosion




% input_image(label_image==0) = -1000;
% input_image(input_image==0) = -1000;
sz = size(input_image);
mx = max(label_image,[],'all');
mn = min(label_image,[],'all');

% ----------- erode
Mask1 = zeros(sz(1),sz(2), sz(3));
Mask1(label_image==mx) = 1;
SE = strel('cube',3);
if t > 0
    for i = 1 : t
        Mask1 = imerode(Mask1,SE);
        label_image = imerode(label_image,SE);
    end
end
% -----------
matrix = zeros(sz) -1000 ;
matrix(Mask1 == 1) = input_image(Mask1 == 1);

% input_image(label_image == mx) = -1000;

if Judge == 1
    % MIP
    output = squeeze(max(matrix,[],2));
elseif Judge == 2
    % SIP
    output = squeeze(sum(matrix,2));
end


end