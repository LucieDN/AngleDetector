function C = CalculerCritere(gradPratique, gradTheorique, Mij)
    sum = 0;
    for i=1:4
        Ci = CalculerCriterePourSegment(i, gradPratique, gradTheorique, Mij);
        sum = sum + Ci;
    end
    C = 1-sum/4;
end

