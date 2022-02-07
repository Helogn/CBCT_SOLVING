function out = SumP(input,label)

    input(input == -1000) = 0;
    Sum1 = sum(input,'all');
    label(input == -1000) = 0;
    Sum2 = sum(label,'all');
    out = Sum1/Sum2;


end