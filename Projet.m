%% Travail préliminaire
    close all
    clear all

    % Variables méthode de Newton
    epsilon = 3;
    alpha = 10;

    % Variables calcul du gradient
    sigma = 3;
    mesh = 9;

    video = VideoReader("vid_in2.mp4");
    if hasFrame(video)
        image = readFrame(video);
    end

    anglesOrigine = [349 313 394 436 ; 985	1127 1136 986];

%% Travail test
  
    % Capture des coordonnées pour la 1ère image
    %anglesOrigine = DemanderPoints(image);% La première ligne correspond aux coordonnées Y (ligne)
    angles = anglesOrigine(:,:);

% Ajustement de la partie de photo étudiée

    ymin = min(angles(1,1),angles(1,2))-20;
    ymax = max(angles(1,3),angles(1,4))+20;
    xmin = min(angles(2,1),angles(2,4))-20;
    xmax = min(angles(2,2),angles(2,3))+20;
    frame = image(ymin:ymax, xmin:xmax, :);
    angles(1,:) = angles(1,:)-ymin;
    angles(2,:) = angles(2,:)-xmin;
    %figure, imshow(frame)
    %line([angles(2,:) angles(2,1)], [angles(1,:) angles(1,1)])
% Détermination du gradient pratique sur l'image d'origine

    gradPratique = CalculerGradient(frame,sigma, mesh);

% Amélioration de la position des angles par la méthode de Newton
    anglesF = round(AmeliorerAngles(frame,angles, gradPratique, sigma, mesh, epsilon, alpha));
    figure, imshow(frame)
    hold on
    line([angles(2,:) angles(2,1)], [angles(1,:) angles(1,1)])
    
    line([anglesF(2,:) anglesF(2,1)], [anglesF(1,:) anglesF(1,1)])

%% Répétitions sur les images successives

video = VideoReader("vid_in2.mp4");
angles = anglesOrigine(:,:);
res = [];

for i=1:10
    % Redéfinition et fenêtrage de l'image étudiée
    if hasFrame(video)
        frame = readFrame(video);
    end
    ymin = min(angles(1,1),angles(1,2))-20;
    ymax = max(angles(1,3),angles(1,4))+20;
    xmin = min(angles(2,1),angles(2,4))-20;
    xmax = min(angles(2,2),angles(2,3))+20;
    frame = frame(ymin:ymax, xmin:xmax, :);
    angles(1,:) = angles(1,:)-ymin;
    angles(2,:) = angles(2,:)-xmin;

    % Calcul du gradient associé à l'image
    gradPratique = CalculerGradient(frame,sigma, mesh);
    % Améliorations des angles qui ont été admis sur l'image précédente
    subplot(5,2,i)
    angles = round(AmeliorerAngles(frame,angles, gradPratique, sigma, mesh, epsilon, alpha));
    angles(1,:) = angles(1,:)+ymin;
    angles(2,:) = angles(2,:)+xmin;
    res = cat(3, res, angles);
end

    
%% Visualisation des coordonnées enregistrées
video = VideoReader("vid_in2.mp4");

for i=1:5
    % Redéfinition et fenêtrage de l'image étudiée
    if hasFrame(video)
        frame = readFrame(video);
    end

    subplot(2,3,i)
    hold on
    imshow(frame)
    plot(res(2,1,i),res(1,1,i), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5)
end

