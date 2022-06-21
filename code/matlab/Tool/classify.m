function out = classify(input)
% classify whole image into 5 classes
input = abs(input);
out = input;
out(input <= 1000) = 5;
out(input < 800) = 4;
out(input < 600) = 3;
out(input < 400) = 2;
out(input < 200) = 0;

end