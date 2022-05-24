function [out,mi,mx] = classify(input,t)
% if t == 'default'
%     t =mx

% classify whole image into 5 classes
input = (input);
mx = max(input,[],"all");
mi = min(input,[],"all");
if t == 'default'
    t = 20;
end


out = input;
    for i = 1:1:t
%         m = t - i + 1;
        m = i-1;
        out(input <= (mx-(mx-mi)/t*m)) = m;
    end
% out(input == 0) = 0;
% mx = max(out,[],"all")
% out = input;
mi=0;
mx=t;
end