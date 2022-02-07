% He Jiang
function output = MIP(input_image, label_image)
sz = size(input_image);
mx = max(label_image,[],'all');
mn = min(label_image,[],'all');

% ----------- erode
Mask = ones(sz(1),sz(2), sz(3));
Mask(label_image==mx) = 0;
SE = strel('cube',3);
for i = 1:3
    label_image = imerode(label_image,SE);
end
% -----------
matrix = zeros(sz(1),sz(2),sz(3)) -1000 ;
matrix(label_image == 1) = input_image(label_image == 1);

% input_image(label_image == mx) = -1000;


% output = squeeze(max(matrix,[],2));
output = squeeze(sum(matrix,2));


end