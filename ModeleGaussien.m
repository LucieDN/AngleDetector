function grad = ModeleGaussien(angles, Mij, sigma)
    grad =[];

    for segment=1:4
        gradSeg = ModeleGaussienPourSegment(angles, Mij, sigma, segment);
        grad = cat(3, grad, gradSeg);
    end
end

function gradSeg = ModeleGaussienPourSegment(angles, Mij, sigma, segment)
    gradSeg =[];

    % Calcul du gradient théorique pour un segment
    nbligne = size(Mij(:, :,segment), 1);
    nbcolonne = size(Mij(:, :, segment),2);

    for ligne=1:2:nbligne
        gradLigne = [];

        for colonne=1:nbcolonne
            gradient = ModeleGaussienEnij(angles, Mij, sigma, ligne, colonne, segment);
            gradLigne = [gradLigne gradient];
        end

        gradSeg = [gradSeg ; gradLigne];
    end
end

function gradPoint = ModeleGaussienEnij(angles, Mij, sigma, ligne, colonne, segment)
    % Définition de variables permettant le calcul
    Xk = angles(:,mod(segment,4)+1);
    Xl = angles(:,segment);
    vecteurDir = (Xk-Xl)/norm(Xk-Xl);
    module = [-vecteurDir(2); vecteurDir(1)];    
    a = 
    x = Mij(ligne, colonne,segment);
    y = Mij(ligne+1, colonne,segment);
    d = norm([x ; y] - (angles(:, mod(segment,4)+1)+Xl)/2);
    phase = -d^2/(2*sigma^2);

    % Calcul du gradient au point étudié
    gradPoint = -module*exp(phase);
    
    % Visualisation du gradient calculé
    res = round([x y] + gradPoint.');
    Xgrad = res(1);
    Ygrad = res(2);
    plot(Xgrad, Ygrad, 'bo', 'MarkerSize', 5, 'LineWidth', 0.5);
end
