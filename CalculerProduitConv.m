function G = CalculerProduitConv(sigma, image)
    [X,Y] = meshgrid(2,2);
    L= image(:,:,1)/3+image(:,:,2)/3+image(:,:,3)/3;
    Hx=-X.*exp(-(X.^2+Y.^2)/(2*sigma^2));
    Hy=-Y.*exp(-(X.^2+Y.^2)/(2*sigma^2));
    Gx=conv2(L,Hx);
    Gy=conv2(L,Hy);
    G=(Gx.*Gx+Gy.*Gy).^0.5;
end
