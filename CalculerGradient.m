function grad = CalculerGradient(sigma, image)
    G = CalculerProduitConv(sigma, image);

    for i=2:size(G,1)-2
        for j=2:size(G,2)-2
           % Calcul de la dérivé en x et en y pour chaque point:
            derX(i,j) = (G(i,j+1)-G(i,j-1))/2; % Dérivé horizontale
            derY(i,j) = (G(i+1,j)-G(i-1,j))/2; % Dérivé verticale
        end
    end

    grad = cat(3,derX, derY);
end
