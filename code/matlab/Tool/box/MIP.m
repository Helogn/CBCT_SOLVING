% He Jiang
function output = MIP(input_image, label_image,t,Judge,X)
if (nargin<5)
    X = -1000;
end

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
    end
end
% -----------
matrix = zeros(sz) + X ;
matrix(Mask1 == 1) = input_image(Mask1 == 1);

% input_image(label_image == mx) = -1000;

if Judge == 1
    % MIP
    output = squeeze(max(matrix,[],2));

elseif Judge == 2
    % SIP
    output = squeeze(mean(matrix,2));
elseif Judge == 3
    base = zeros(sz);
    base(label_image==mx) = input_image(label_image == mx);
    output = sum(base,2) ./ sum(label_image,2);

end


end