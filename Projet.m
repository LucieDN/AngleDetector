%% Affichage de la vidéo
video = VideoReader("vid_in2.mp4");
while hasFrame(video)
    frame = readFrame(video);
    imshow(frame)
end

%% Récuperer la 1ère image
close all
clear all

video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

% Calcul des gradients en pratique
gradPratique = CalculerGradientPrat(0.5, frame);

% Capture des coordonnées pour la 1ère image
coins = Demander4Points(frame);

% Détermination de l'ensemble des points Mij
Mij = DeterminerMij(5, 3, 0.7, 10, coins);% Paramètres : u, v, p, L

% Calculer les gradients théoriques



%% Functions

function G = CalculerProduitConv(sigma, image)
    [X,Y] = meshgrid(2,2);
    L= image(:,:,1)/3+image(:,:,2)/3+image(:,:,3)/3;
    Hx=-X.*exp(-(X.^2+Y.^2)/(2*sigma^2));
    Hy=-Y.*exp(-(X.^2+Y.^2)/(2*sigma^2));
    Gx=conv2(L,Hx);
    Gy=conv2(L,Hy);
    G=(Gx.*Gx+Gy.*Gy).^0.5;
end

function grad = CalculerGradientPrat(sigma, image)
    G = CalculerProduitConv(sigma, image);

    for i=2:size(G,1)-2
        for j=2:size(G,2)-2
            % Calcul de la dérivé en x et en y pour chaque point:
            derX(i,j) = (G(i+1,j)-G(i-1,j))/2;
            derY(i,j) = (G(i,j+1)-G(i,j-1))/2;
        end
    end

    grad = cat(3,derX, derY);
end

function Mij = DeterminerMij(u, v, p, L, angles)
    Mij = [];
    for seg=1:4
       MijPourUnSeg = [];
       for j=-v:v+1
            Mi=[];
            for i=-u:u+1
                
                vecteur = (angles(:,mod(seg,4)+1)-angles(:,seg))/norm(angles(:,mod(seg,4)+1)-angles(:,seg));
                point = (angles(:, mod(seg,4)+1)+angles(:,seg))/2 + i*p/(2*u)*(angles(:,mod(seg,4)+1)-angles(:,seg)) + j*L*[-vecteur(2); vecteur(1)];
                Mi = [Mi round(point)];
            end
            MijPourUnSeg = [MijPourUnSeg ; Mi];
       end
       Mij = cat(3, Mij, MijPourUnSeg);
    end

    %Afficher les points Mij
    nbligne = size(Mij(:, :,1), 1);
    nbcolonne = size(Mij(:, :, 1),2);
    for segment=1:4
        for ligne=1:2:nbligne
            for colonne=1:nbcolonne
                plot(Mij(ligne, colonne, segment),Mij(ligne+1,colonne, segment), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
            end
        end
    end
end

function coins = Demander4Points(firstImage)
    close all
    figure, imshow(firstImage)
    [x,y] = ginput(4);
    x=fix(x);
    y=fix(y);
    coins = [x.' ; y.']; % On formalise la notation
    line([coins(1,:) coins(1,1)], [coins(2,:) coins(2,1)]) % On trace le rectangle virtuel
    hold on;
end

function grad = CalculerGradientTheo(sigma, image, points)
    G = CalculerProduitConv(sigma, image);

    for i=2:size(G,1)-2
        for j=2:size(G,2)-2
            % Calcul de la dérivé en x et en y pour chaque point:
            derX(i,j) = (G(i+1,j)-G(i-1,j))/2;
            derY(i,j) = (G(i,j+1)-G(i,j-1))/2;
        end
    end

    grad = cat(3,derX, derY);
end

