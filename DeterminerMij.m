function Mij = DeterminerMij(u, v, p, L, angles)
    Mij = [];
    for seg=1:4
       Mi = [];
       for j=-v:v
            for i=-u:u
                vecteurDir = (angles(:,mod(seg,4)+1)-angles(:,seg))/norm(angles(:,mod(seg,4)+1)-angles(:,seg));
                point = (angles(:, mod(seg,4)+1)+angles(:,seg))/2 + i*p/(2*u)*(angles(:,mod(seg,4)+1)-angles(:,seg)) + j*L*[-vecteurDir(2); vecteurDir(1)];
                Mi = [Mi round(point)];
            end
       end
       Mij = cat(3, Mij, Mi);
    end

    %Afficher les points Mij
    nbcolonne = size(Mij(:, :, 1),2);
    for segment=1:4
        for colonne=1:nbcolonne
            plot(Mij(1, colonne, segment),Mij(2,colonne, segment), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
        end
    end
end

