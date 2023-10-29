%% Code Principal
close all
clear all

video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

sigma = 3;%A changer en 3.0 --> changer le meshgrid pour 3*3 = 9

% Calcul des gradients en pratique
gradPratique = CalculerGradient(frame);

% Capture des coordonnées pour la 1ère image
angles = DemanderPoints(frame);% La première ligne correspond aux coordonnées Y (ligne)

% Détermination de l'ensemble des points Mij
Mij = DeterminerMij(20, 3, 0.7, 3, angles);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne
res = AfficherMij(Mij);
%res = AfficherGradient(gradPratique*10, Mij);

% On crée une image virtuelle rempli de 0 et de 1
imageVirtuelle = quadrangle_from_points(frame(:, :, 1), angles(2,:), angles(1,:));

% On calcule le gradient de l'image virtuelle
gradTheorique = CalculerGradient(imageVirtuelle);
%res = AfficherGradient(gradTheorique*100, Mij)

C = CalculerCritere(gradPratique, gradTheorique, Mij);

epsilon = 2;
alpha = 50;
F = [];

for i=1:200
    [angles, C] = ModifierAngle(frame, angles, C, gradPratique, epsilon, alpha);
    F = [F C];
end

figure, plot(F)

