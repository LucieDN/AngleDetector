function anglesFinaux = AmeliorerAngles(frame, angles, gradPratique, sigma, mesh, epsilon, alpha)
    
    
    % Variable positionnement des Mij
    u = 20;
    v = 3;
    p = 0.7;
    L = 3;

    F = [];
    for i=1:200
        %On recalcule toutes les variables dont on a besoin et qui sont
        %associées à la position des angles
        Mij = DeterminerMij(u,v,p,L, angles);
        imageVirtuelle = quadrangle_from_points(frame(:, :, 1), angles(2,:), angles(1,:));
        gradTheorique = CalculerGradient(imageVirtuelle,sigma, mesh);
        C = CalculerCritere(gradPratique, gradTheorique, Mij);

        % On définit l'angle sur lequel on travaille
        rnd = randi(4);
        coinsCalcul = angles(:,:);
        coinsCalcul(:, rnd) = round(coinsCalcul(:,rnd) + epsilon);% On le fait varier de epsilon
    
        % On calcul le gradient théorique qui permet de recalculer le
        % critère avec cette position
        MijIntermediaire = DeterminerMij(20, 3, 0.7, 3, coinsCalcul);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne
        imageVirtuelleIntermediaire = quadrangle_from_points(frame(:, :, 1), coinsCalcul(2,:), coinsCalcul(1,:));
        gradTheoriqueIntermediaire = CalculerGradient(imageVirtuelleIntermediaire,sigma,mesh);
        Cintermediaire = CalculerCritere(gradPratique, gradTheoriqueIntermediaire, MijIntermediaire);
    
        % On utilise la méthode de Newton pour faire varier l'angle étudié
        angles(:,rnd) = angles(:,rnd)-alpha*(Cintermediaire-C)/epsilon;    
        
        F = [F C]; 
    end
    anglesFinaux=angles;
    figure, plot(F)
end
