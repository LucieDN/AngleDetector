%% Code Principal
close all
clear all

video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

sigma = 30;
% Calcul des gradients en pratique
gradPratique = CalculerGradientPrat(sigma, frame);

% Capture des coordonnées pour la 1ère image
coins = Demander4Points(frame);

% Détermination de l'ensemble des points Mij
Mij = DeterminerMij(5, 3, 0.7, 10, coins);% Paramètres : u, v, p, L

% Calculer les gradients théoriques par une approximation à un modèle
% gaussien
%gradTheo = ModeleGaussien(coins, Mij, 30);




