function res = AfficherGradient(gradient, Mij)
    res = 0;
    for segment=1:4
        for colonne=1:size(Mij(:,:,segment),2)
            x = Mij(2, colonne, segment); %colonne
            y = Mij(1, colonne, segment); %ligne
            hold on, quiver(x, y, gradient(y,x,1), gradient(y,x,2), 'b-' , 'MarkerSize', 5, 'LineWidth', 0.5);
        end
    end
end

