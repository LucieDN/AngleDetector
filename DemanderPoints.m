function coins = DemanderPoints(firstImage)
    close all
    figure, imshow(firstImage)
    [x,y] = ginput(4);
    x=fix(x);
    y=fix(y);
    coins = [y.' ; x.']; % On formalise la notation
    line([coins(2,:) coins(2,1)], [coins(1,:) coins(1,1)]) % On trace le rectangle virtuel
    hold on;
end