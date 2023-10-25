function C = CalculerCritere(gradPratique, gradTheorique, Mij)
    sum = 0;
    for i=1:4
        Ci = CalculerCriterePourSegment(1, gradPratique, gradTheorique, Mij);
        sum = sum + Ci;
    end
    C = 1-sum/4;
end

function Ci = CalculerCriterePourSegment(segment, gradPratique, gradTheorique, Mij)
    nbcolonne = size(Mij(:, :, 1),2);
    resPratique = [];
    resTheorique = [];
    for colonne=1:nbcolonne
        x = Mij(2, colonne, 1);
        y = Mij(1, colonne, 1);
        resPratique = [resPratique gradPratique(x, y, :)];
        resTheorique = [resTheorique gradTheorique(x,y,:)];
    end
    GP = [resPratique(:, :, 1) resPratique(:, :, 2)];
    GT = [resTheorique(:, :, 1) resTheorique(:, :, 2)];
    Ci = GP.*GT/(norm(GP)*norm(GT));

end