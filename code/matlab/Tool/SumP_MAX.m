function out = SumP_MAX(input)

% calculate maximum percentage
    sz = size(input);
    amount = zeros(sz);
    amount(input == -1000) = 1;
    input(input == -1000) = 0;
    Sum1 = sum(input,"all");
    Sum2 = sum(amount,"all");
    out = Sum1 /Sum2;

end