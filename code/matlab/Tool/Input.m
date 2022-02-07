function output = Input(input_image, label_image)
    image = niftiread(input_image);
    label = label_image;
    
    image(label==0) = -1000;
    label(label==0) = -1000;
    output = image;
end