function Mij = DeterminerMij(u, v, p, L, angles)
    Mij = [];
    for seg=1:4
       Mi = [];
       for j=-v:v
            for i=-u:u
                P1 = angles(:,seg);
                P2 = angles(:,mod(seg,4)+1); 
                vecteurDir = (P2-P1)/norm(P2-P1);
                point = (P2+P1)/2 + i*p/(2*u)*(P2-P1) + j*L*[-vecteurDir(2); vecteurDir(1)];
                Mi = [Mi round(point)];
            end
       end
       Mij = cat(3, Mij, Mi);
    end
end

