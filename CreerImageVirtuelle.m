function image = CreerImageVirtuelle(angles, imageOrigine)
    image = CreerImageBinaire(angles, imageOrigine);
end

function image = CreerImageBinaire(angles, imageOrigine)
    image = [];
    X = [];
    Y = [];
    seg = 1;
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
            image(ligne, colonne) = TesterPosition(vecteurDir,ordonneOrigine, [ligne colonne], Y);
        end
    end
    plot(X, Y)
    %line([P1(1) P2(1)], [P1(2) P2(2)]) % On trace le rectangle virtuel
    figure, imshow(image);
end

function bool = TesterPosition(vecteur, ordOrigine, point, Y)
    bool = 1;
    y = point(1);
    x = point(2);
    if y > Y(x)
        bool = 0;
    end
end


