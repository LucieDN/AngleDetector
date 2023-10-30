function res = AfficherMij(Mij)
    %Afficher les points Mij
    nbcolonne = size(Mij(:, :, 1),2);
    for segment=1:4
        for colonne=1:nbcolonne
            hold on
            plot(Mij(2, colonne, segment),Mij(1,colonne, segment), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
        end
    end
    res = 0;
end

