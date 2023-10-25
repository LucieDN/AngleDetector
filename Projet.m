%% Code Principal
close all
clear all

video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

sigma = 30;
% Calcul des gradients en pratique
gradPratique = CalculerGradient(sigma, frame);

% Capture des coordonnées pour la 1ère image
coins = DemanderPoints(frame);

% Détermination de l'ensemble des points Mij
Mij = DeterminerMij(5, 3, 0.7, 10, coins);% Paramètres : u, v, p, L

% On crée une image virtuelle rempli de 0 et de 1
imageVirtuelle = CreerImageVirtuelle(coins, frame);

% On calcule le gradient de l'image virtuelle
gradTheorique = CalculerGradient(sigma, imageVirtuelle);

C = CalculerCritere(gradPratique, gradTheorique, Mij);


