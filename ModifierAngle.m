function [nouveauAngles, nouveauC, Mij] = ModifierAngle(frame, angles, C, gradPratique, epsilon, alpha)
    sigma = 3;% --> le meshgrid à 10 < 3*3 = 9
    mesh = 10;
    rnd = randi(4);
    coinsCalcul = angles(:,:);
    coinsCalcul(rnd) = round(coinsCalcul(rnd) + epsilon);

    % Détermination de l'ensemble des points Mij
    Mij = DeterminerMij(5, 3, 0.7, 10, coinsCalcul);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne

    % On crée une image virtuelle rempli de 0 et de 1
    imageVirtuelle = quadrangle_from_points(frame(:, :, 1), coinsCalcul(2,:), coinsCalcul(1,:));
    
    % On calcule le gradient de l'image virtuelle
    gradTheorique = CalculerGradient(imageVirtuelle,sigma,mesh);
    
    Cintermediaire = CalculerCritere(gradPratique, gradTheorique, Mij);
    
    nouveauAngles = angles(:,:);
    nouveauAngles(:, rnd) = round(nouveauAngles(:, rnd) - alpha*(Cintermediaire-C)/epsilon);
    Mij = DeterminerMij(5, 3, 0.7, 10, nouveauAngles);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne
    nouveauC = CalculerCritere(gradPratique, gradTheorique, Mij)

end

