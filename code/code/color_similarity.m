function DE = color_similarity(rgb1,rgb2)
%1
% DE = deltaE(uint8(rgb1),uint8(rgb2)); %DE76
% DE = deltaE(rgb1,rgb2);
% lab1=rgb2lab(rgb1);lab2=rgb2lab(rgb2);
% DE = sum((lab1-lab2).^2).^1.5;
%% 2
% DE = imcolordiff(rgb1,rgb2,"Standard","CIEDE2000");%DE2000
%% 3
% R_1 = rgb1(1);G_1 = rgb1(2);B_1 = rgb1(3);
% R_2 = rgb2(1);G_2 = rgb2(2);B_2 = rgb2(3);
% rmean = (R_1+R_2 )/2;
% R = R_1 - R_2;
% G = G_1 -G_2;
% B = B_1 - B_2;
% DE = (((2+rmean/256)*(R^2)+4*(G^2)+(2+(255-rmean)/256)*(B^2))/100);
%% 4
% rgb1=[1,2,3];rgb2=[1,8,7];
% [L1,a1,b1] = RGB2Lab(rgb1);
% [L2,a2,b2] = RGB2Lab(rgb2);
% DE = ((L1-L2)^2+(a1-a2)^2+(b1-b2)^2)^1.5;
%% 5
DE = sum((rgb1-rgb2).^2);
