function res = AfficherGradient(gradient, image, Mij)
    res = 0;
    figure, imshow(image)
    
    for segment=1:4
        for colonne=1:size(Mij(:,:,segment),2)
            x = Mij(1, colonne, segment);

            hold on, quiver(x, y, gradient(y, y, 2), gradient(x, y, 1), 'r-' , 'MarkerSize', 5, 'LineWidth', 0.5);
        end
    end
end

