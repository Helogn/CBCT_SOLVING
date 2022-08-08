function out = classify(input,num)
% classify whole image into 5 classes
mx = max(input,[],"all");
mi = min(input,[],"all");
range = (mx - mi) / num;
out = input;
for i = 0 : num
    stage = mx - i*range;
    out(input <= stage) = num - i;
    
end
end