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
resu1 = result1';
result1_reshape = [];
for i = 1:8
    result1_reshape = [result1_reshape;resu1(:,(i-1)*27+1:(i)*27)];
end
writematrix(result1_reshape,'.\DE2000\result1_reshape.xlsx')

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
resu2 = result2';
result2_reshape = [];
for i = 1:8
    result2_reshape = [result2_reshape;resu2(:,(i-1)*25+1:(i)*25)];
end
writematrix(result2_reshape,'.\DE2000\result2_reshape.xlsx')

figure('Position',[106.6,259.4,560,381.6])
cizhuan_lab = rgb2lab(uint8(cizhuan_rgb));
img1_lab = rgb2lab(uint8(img1_rgb));
scatter3(cizhuan_lab(:,2),cizhuan_lab(:,3),cizhuan_lab(:,1),100,cizhuan_rgb./255,'filled');hold on
scatter3(img1_lab(:,2),img1_lab(:,3),img1_lab(:,1),25,img1_rgb./255,'filled');hold on 
for i = 1:img1_length
    img_lab = img1_lab(i,:);
    cizhuanlab = cizhuan_lab(position_img1(i),:);
    cizhuanrgb = cizhuan_rgb(position_img1(i),:);
    plot3([img_lab(2),cizhuanlab(2)],[img_lab(3),cizhuanlab(3)],[img_lab(1),cizhuanlab(1)],'color',...
        cizhuanrgb/255)
end
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([-128,128]),ylim([-128,128]),zlim([0,100])
view(-55,23.4)
xlabel('a');ylabel('b');zlabel('L');
title('图像1与瓷砖lab颜色匹配网络(DE2000)')
print(gcf,'..\img\图像1与瓷砖lab颜色匹配网络DE2000','-dpng','-r600')

figure('Position',[106.6,259.4,560,381.6])
cizhuan_lab = rgb2lab(uint8(cizhuan_rgb));
img2_lab = rgb2lab(uint8(img2_rgb));
scatter3(cizhuan_lab(:,2),cizhuan_lab(:,3),cizhuan_lab(:,1),100,cizhuan_rgb./255,'filled');hold on
scatter3(img2_lab(:,2),img2_lab(:,3),img2_lab(:,1),25,img2_rgb./255,'filled');hold on 
for i = 1:img2_length
    img_lab = img2_lab(i,:);
    cizhuanlab = cizhuan_lab(position_img2(i),:);
    cizhuanrgb = cizhuan_rgb(position_img2(i),:);
    plot3([img_lab(2),cizhuanlab(2)],[img_lab(3),cizhuanlab(3)],[img_lab(1),cizhuanlab(1)],'color',...
        cizhuanrgb/255)
end
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([-128,128]),ylim([-128,128]),zlim([0,100])
view(-55,23.4)
xlabel('a');ylabel('b');zlabel('L');
title('图像2与瓷砖lab颜色匹配网络(DE2000)')
print(gcf,'..\img\图像2与瓷砖lab颜色匹配网络DE2000','-dpng','-r600')



         