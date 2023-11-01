%% Travail préliminaire
close all
clear all

video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

figure, imshow(frame)

% Capture des coordonnées pour la 1ère image
anglesOrigine = DemanderPoints(frame);% La première ligne correspond aux coordonnées Y (ligne)

%% Détermination du gradient pratique sur l'image d'origine
    sigma = 1;
    mesh = 3;
    % Calcul des gradients en pratique
    gradPratique = CalculerGradient(frame,sigma, mesh);

%% Amélioration de la position des angles par la méthode de Newton
    angles = anglesOrigine(:,:);
    anglesOrigine
    angles = round(AmeliorerAngles(frame,angles, gradPratique))

%% Visualisationd de l'amélioration
figure, imshow(frame)
line([angles(2,:) angles(2,1)], [angles(1,:) angles(1,1)]) % On trace le rectangle virtuel
line([anglesOrigine(2,:) anglesOrigine(2,1)], [anglesOrigine(1,:) anglesOrigine(1,1)])
hold on;


