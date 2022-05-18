function out = classify(input,t)
% if t == 'default'
%     t =mx

% classify whole image into 5 classes
input = abs(input);
mx = max(input,[],"all")
if t == 'default'
    t =mx;
end
out = input;
    for i = 1:1:t
        m = t - i + 1;
        out(input <= mx/t*m) = m;
    end
out(input == 0) = 0;
mx = max(out,[],"all")
end