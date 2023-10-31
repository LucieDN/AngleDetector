%% Code Principal
close all
clear all

video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

figure, imshow(frame)

% Capture des coordonnées pour la 1ère image
angles = DemanderPoints(frame);% La première ligne correspond aux coordonnées Y (ligne)


%% Détermination des Mij
% Détermination de l'ensemble des points Mij
figure, imshow(frame)

Mij = DeterminerMij(20, 3, 0.7, 3, angles);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne
res = AfficherMij(Mij);

%% Détermination du gradient théorique à partir d'une image virtuelle binaire
    sigma = 3;% --> le meshgrid à 10 < 3*3 = 9
    mesh = 10;
    figure, imshow(frame)
    res = AfficherMij(Mij);
    % On crée une image virtuelle rempli de 0 et de 1
    imageVirtuelle = quadrangle_from_points(frame(:, :, 1), angles(2,:), angles(1,:));
    
    % On calcule le gradient de l'image virtuelle
    gradTheorique = CalculerGradient(imageVirtuelle,sigma, mesh);
    
    % On affiche le résultat du gradient théorique
    res = AfficherGradient(gradTheorique, Mij);


%% Détermination du gradient pratique sur l'image d'origine
    figure, imshow(frame)
    res = AfficherMij(Mij);
    sigma = 1;
    mesh = 3
    % Calcul des gradients en pratique
    gradPratique = CalculerGradient(frame,sigma, mesh);
    
    res = AfficherGradient(gradPratique, Mij);

%%

C = CalculerCritere(gradPratique, gradTheorique, Mij);
%%
epsilon = 2;
alpha = 10;
sigma = 3;% --> le meshgrid à 10 < 3*3 = 9
mesh = 10;
F = [];

for i=1:200
    % On définit sur quel angle on travaille
    rnd = randi(4);
    coinsCalcul = angles(:,:);
    coinsCalcul(:, rnd) = round(coinsCalcul(:,rnd) + epsilon);% On le fait varier de epsilon

    % On recalcule le gradient théorique qui permet de recalculer le
    % critère avec cette position
    MijIntermediaire = DeterminerMij(20, 3, 0.7, 3, coinsCalcul);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne
    imageVirtuelleIntermediaire = quadrangle_from_points(frame(:, :, 1), coinsCalcul(2,:), coinsCalcul(1,:));
    gradTheoriqueIntermediaire = CalculerGradient(imageVirtuelleIntermediaire,sigma,mesh);
    Cintermediaire = CalculerCritere(gradPratique, gradTheoriqueIntermediaire, Mij);

    % On utilise la méthode de Newton pour faire varier l'angle étudié
    angles(:,rnd) = angles(:,rnd)-alpha*(Cintermediaire-C)/epsilon;
    %On recalcule toutes les variables dont on a besoin et ui sont
    %associées à la position des angles
    Mij = DeterminerMij(20, 3, 0.7, 3, angles);
    imageVirtuelle = quadrangle_from_points(frame(:, :, 1), angles(2,:), angles(1,:));
    gradTheorique = CalculerGradient(imageVirtuelle,sigma, mesh);
    C = CalculerCritere(gradPratique, gradTheorique, Mij)
    F = [F C];

end
figure, plot(F)

%%
epsilon = 3;
alpha = 100;
F = [];

for i=1:200
    [angles, C, Mij] = ModifierAngle(frame, angles, C, gradPratique, epsilon, alpha);
    F = [F C];
end

figure, plot(F)

