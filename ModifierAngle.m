function [angles, nouveauC, Mij] = ModifierAngle(frame, angles, C, gradPratique, epsilon, alpha)
    rnd = randi(4);
    rndXY = randi(2);
    coinsCalcul = angles(:,:);
    coinsCalcul(rndXY, rnd) = round(coinsCalcul(rndXY, rnd) + epsilon)
    
    % Détermination de l'ensemble des points Mij
    Mij = DeterminerMij(5, 3, 0.7, 10, coinsCalcul);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne

    %res = AfficherGradient(gradPratique, Mij);

    % On crée une image virtuelle rempli de 0 et de 1
    %imageVirtuelle = CreerImageVirtuelle(angles, frame);
    imageVirtuelle = quadrangle_from_points(frame(:, :, 1), coinsCalcul(2,:), coinsCalcul(1,:));
    
    % On calcule le gradient de l'image virtuelle
    gradTheorique = CalculerGradient(imageVirtuelle);
    %res = AfficherGradient(gradTheorique, Mij);
    
    nouveauC = CalculerCritere(gradPratique, gradTheorique, Mij);
    angles(:, rnd) = round(angles(:, rnd) - alpha*(nouveauC-C)/epsilon);
    Mij = DeterminerMij(5, 3, 0.7, 10, angles);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne

end

