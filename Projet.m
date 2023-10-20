%% Affichage de la vidéo
video = VideoReader("vid_in2.mp4");
while hasFrame(video)
    frame = readFrame(video);
    imshow(frame)
end

%% Récuperer la 1ère image
close all
video = VideoReader("vid_in2.mp4");
if hasFrame(video)
    frame = readFrame(video);
end

% Calcul des gradients en pratique
gradPratique = CalculerGradientPrat(0.5, frame);

% Capture des coordonnées pour la 1ère image
coins = Demander4Points(frame);

%% Détermination de l'ensemble des points Mij
Mij = DeterminerMij(10, 3, 0.7, 10, coins);
Mij
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
    Mij=[];
    Mi=[];
    for seg=1:5
        for i=-u:u
            for j=-v:v
                vecteur = (angles(:,mod(seg,4)+1)-angles(:,seg))/norm(angles(:,mod(seg,4)+1)-angles(:,seg));
                Mi = [Mi round([(angles(1, mod(seg,4)+1)+angles(1,seg))/2 ; (angles(2,mod(seg,4)+1)+angles(2, seg))/2]+i*p/(2*u)*(angles(:,mod(seg,4)+1)-angles(:,seg))+j*L*[-vecteur(2); vecteur(1)])];
            end
            Mij = [Mij Mi];
        end
        for i=1:size(Mij,2)
            plot(Mij(1,i),Mij(2,i), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
        end
    end
    Mij = cat(3, Mij(1), Mij(2), Mij(3), Mij(4))
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

