figure('Position',[193.8,305,908.8,366.4])
subplot(121)
data = load('img1.txt');
color = data(:,2:4);
colorlength = size(color,1);
lab = [];
for i = 1:colorlength
    lab = [lab;rgb2lab(color(i,:)/255)];
end
scatter3(lab(:,2),lab(:,3),lab(:,1),50,color./255,'filled');hold on 
xlabel('a');ylabel('b');zlabel('L');
xlim([-128,128]),ylim([-128,128]),zlim([0,100])
title('图像1 lab颜色')
subplot(122)
data = load('img2.txt');
color = data(:,2:4);
colorlength = size(color,1);
lab = [];
for i = 1:colorlength
    lab = [lab;rgb2lab(color(i,:)/255)];
end
scatter3(lab(:,2),lab(:,3),lab(:,1),50,color./255,'filled');hold on 
xlabel('a');ylabel('b');zlabel('L');
xlim([-128,128]),ylim([-128,128]),zlim([0,100])
title('图像2 lab颜色')
print(gcf,'..\img\图像1 2的lab颜色','-dpng','-r600')