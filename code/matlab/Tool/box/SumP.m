function out = SumP(input,label)

% calculate percentage
    mx = max(label,[],'all');
    input(label ~= mx) = 0;
    input(input < -980) = 0;
    Sum1 = sum(input,'all');
    label(label < mx) = 0;
    label = label /mx;
    Sum2 = sum(label,'all');
    out = Sum1/Sum2;


end