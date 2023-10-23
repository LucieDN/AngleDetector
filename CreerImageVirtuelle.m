function images = CreerImageVirtuelle(angles, imageOrigine)
    images = [];
    for seg=1:4
        imageVirt = CreerImageBinaire(angles, imageOrigine, seg);
        images = cat(3, images, imageVirt);
    end
    image = images(:,:,1)+images(:,:,2)+images(:,:,3)+images(:,:,4);
    M= double(image==0);
    figure, imshow(M);
end

function image = CreerImageBinaire(angles, imageOrigine,seg)
    image = [];
    X = [];
    Y = [];
    nbligne = size(imageOrigine, 1);
    nbcolonne = size(imageOrigine,2);
    P1 = round(angles(:,seg));
    P2 = round(angles(:,mod(seg,4)+1));
    vecteurDir = (P2(2)-P1(2))/(P2(1)-P1(1));
    ordonneOrigine = P1(2) - vecteurDir*P1(1);
    
    for x=1:nbcolonne
        X = [X x];
        Y = [Y round(vecteurDir*x+ordonneOrigine)];
    end
    
    for ligne=1:nbligne
        for colonne=1:nbcolonne
            image(ligne, colonne) = TesterPosition(vecteurDir,ordonneOrigine, [ligne colonne], Y, seg);
        end
    end
end

function bool = TesterPosition(vecteur, ordOrigine, point, Y, seg)
    bool = 1;% blanc par défaut
    y = point(1);
    x = point(2);
    

    if seg == 1 && y > Y(x)
        bool = 0;% 0 --> noir
    end
    if seg == 3 && y < Y(x)
        bool = 0;
    end
    if seg == 2 && x < (y-ordOrigine)/vecteur
        bool = 0;
    end
    if seg == 4 && x > (y-ordOrigine)/vecteur
        bool = 0;
    end
    
end


