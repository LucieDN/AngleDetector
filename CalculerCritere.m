function C = CalculerCritere()
    sum = 0;
    for i=1:4
        Ci = CalculerCriterePourSegment(i);
        sum = sum + Ci;
    end
    C = 1-sum/4;
end

function Ci = CalculerCriterePourSegment(segment)
    
end