function Mij = DeterminerMij(u, v, p, L, angles)
    Mij = [];
    for seg=1:4
       MijPourUnSeg = [];
       for j=-v:v
            Mi=[];
            for i=-u:u
                vecteurDir = (angles(:,mod(seg,4)+1)-angles(:,seg))/norm(angles(:,mod(seg,4)+1)-angles(:,seg));
                point = (angles(:, mod(seg,4)+1)+angles(:,seg))/2 + i*p/(2*u)*(angles(:,mod(seg,4)+1)-angles(:,seg)) + j*L*[-vecteurDir(2); vecteurDir(1)];
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

