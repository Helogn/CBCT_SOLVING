function output = Input(input_image, label_image)
% extract lung from original

    mx = max(label_image,[],'all');
    image = niftiread(input_image);
    image(label_image~=mx) = -1000;
    image(image==0) = -1000;
    output = image;
    
end