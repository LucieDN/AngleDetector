function Ci = CalculerCriterePourSegment(segment, gradPratique, gradTheorique, Mij)
    nbcolonne = size(Mij(:, :, 1),2);
    resPratique = [];
    resTheorique = [];
    for colonne=1:nbcolonne
        y = Mij(1, colonne, segment);
        x = Mij(2, colonne, segment);
        resPratique = [resPratique gradPratique(x, y, :)];
        resTheorique = [resTheorique gradTheorique(x,y,:)];
    end
    GP = [resPratique(:, :, 1) resPratique(:, :, 2)];
    GT = [resTheorique(:, :, 1) resTheorique(:, :, 2)];
    Ci = GP*GT.'/(norm(GP)*norm(GT));

end