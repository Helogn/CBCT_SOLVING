function number = cal_sum_se(input,se)
sz = size(input);
arr1 = zeros(sz);
arr1(input>se) = 1;


number = sum(arr1,'all');
end