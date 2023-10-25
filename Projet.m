%% Code Principal
close all
clear all

video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

sigma = 30;%A changer en 3.0 --> changer le meshgrid pour 3*3 = 9

% Calcul des gradients en pratique
gradPratique = CalculerGradient(sigma, frame);

% Capture des coordonnées pour la 1ère image
angles = DemanderPoints(frame);% La première ligne correspond aux coordonnées Y (ligne)

% Détermination de l'ensemble des points Mij
Mij = DeterminerMij(5, 3, 0.7, 10, angles);% Paramètres : u, v, p, L, et toujours les Y sur la 1ère ligne

% On crée une image virtuelle rempli de 0 et de 1
%imageVirtuelle = CreerImageVirtuelle(angles, frame);
imageVirtuelle = quadrangle_from_points(frame(:, :, 1), angles(2,:), angles(1,:));
figure, imshow(imageVirtuelle)

%%
% On calcule le gradient de l'image virtuelle
gradTheorique = CalculerGradient(sigma, imageVirtuelle);

imshow(frame);
C = CalculerCritere(gradPratique, gradTheorique, Mij);


