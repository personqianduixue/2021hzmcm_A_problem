clc;clear
cizhuan_rgb = load('瓷砖.txt');
img1_rgb = load('img1.txt');
img2_rgb = load('img2.txt');
cizhuan_rgb = cizhuan_rgb(:,2:4);
img1_rgb = img1_rgb(:,2:4);
img2_rgb = img2_rgb(:,2:4);
cizhuan_length = size(cizhuan_rgb,1);
img1_length = size(img1_rgb,1);
img2_length = size(img2_rgb,1);
DE_img1 = ones(img1_length,cizhuan_length);
% fun = @deltaE; %DE76
fun = @(rgb1,rgb2) imcolordiff(rgb1,rgb2,"Standard","CIEDE2000");%DE2000
for i = 1:img1_length
    each_img_rgb = img1_rgb(i,:);
    for j = 1:cizhuan_length
        each_cizhuan_rgb = cizhuan_rgb(j,:);
        DE_img1(i,j) = fun(uint8(each_img_rgb),uint8(each_cizhuan_rgb));%计算相似度
    end
end
DE_img1
for i = 1:img1_length
    position_img1(i) = find(DE_img1(i,:)==min(DE_img1(i,:)));%图像中每种rgb对应瓷砖的rgb的编号
end
result1 = [1:img1_length;position_img1]';
dlmwrite('.\DE2000\result1.txt',result1,'delimiter',',','newline','pc')

for i = 1:img2_length
    each_img_rgb = img2_rgb(i,:);
    for j = 1:cizhuan_length
        each_cizhuan_rgb = cizhuan_rgb(j,:);
        DE_img2(i,j) = fun(uint8(each_img_rgb),uint8(each_cizhuan_rgb));%计算相似度
    end
end
DE_img2
for i = 1:img2_length
    position_img2(i) = find(DE_img2(i,:)==min(DE_img2(i,:)));%图像中每种rgb对应瓷砖的rgb的编号
end
result2 = [1:img2_length;position_img2]';
dlmwrite('.\DE2000\result2.txt',result2,'delimiter',',','newline','pc')

figure(1)
scatter3(cizhuan_rgb(:,1),cizhuan_rgb(:,2),cizhuan_rgb(:,3),100,cizhuan_rgb./255,'filled');hold on
scatter3(img1_rgb(:,1),img1_rgb(:,2),img1_rgb(:,3),25,img1_rgb./255,'filled');hold on 
for i = 1:img1_length
    img_rgb = img1_rgb(i,:);
    cizhuanrgb = cizhuan_rgb(position_img1(i),:);
    plot3([img_rgb(1),cizhuanrgb(1)],[img_rgb(2),cizhuanrgb(2)],[img_rgb(3),cizhuanrgb(3)],'color',...
        cizhuanrgb/255)
end
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([0,256]),ylim([0,256]),zlim([0,256])
view(101,32.8)
xlabel('R');ylabel('G');zlabel('B');
title('图像1与瓷砖rgb颜色匹配网络(DE2000)')
print(gcf,'..\img\图像1与瓷砖rgb颜色匹配网络DE2000','-dpng','-r600')

figure(2)
scatter3(cizhuan_rgb(:,1),cizhuan_rgb(:,2),cizhuan_rgb(:,3),100,cizhuan_rgb./255,'filled');hold on
scatter3(img2_rgb(:,1),img2_rgb(:,2),img2_rgb(:,3),25,img2_rgb./255,'filled');hold on 
for i = 1:img2_length
    img_rgb = img2_rgb(i,:);
    cizhuanrgb = cizhuan_rgb(position_img2(i),:);
    plot3([img_rgb(1),cizhuanrgb(1)],[img_rgb(2),cizhuanrgb(2)],[img_rgb(3),cizhuanrgb(3)],'color',...
        cizhuanrgb/255)
end
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([0,256]),ylim([0,256]),zlim([0,256])
view(101,32.8)
xlabel('R');ylabel('G');zlabel('B');
title('图像2与瓷砖rgb颜色匹配网络(DE2000)')
print(gcf,'..\img\图像2与瓷砖rgb颜色匹配网络DE2000','-dpng','-r600')

         