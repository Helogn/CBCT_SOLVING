% He Jiang
function output = MIP(input_image, label_image,t)
sz = size(input_image);
mx = max(label_image,[],'all');
mn = min(label_image,[],'all');

% ----------- erode
Mask1 = ones(sz(1),sz(2), sz(3));
Mask1(label_image==mn) = 0;
SE = strel('cube',3);
for i = 1 : t
    Mask1 = imerode(Mask1,SE);
end
% -----------
matrix = zeros(sz) -1000 ;
matrix(Mask1 == 1) = input_image(Mask1 == 1);

% input_image(label_image == mx) = -1000;


% output = squeeze(max(matrix,[],2));
output = squeeze(sum(matrix,2));


end