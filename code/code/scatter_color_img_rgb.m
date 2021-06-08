figure('Position',[193.8,305,908.8,366.4])
subplot(121)
data = load('img1.txt');
color = data(:,2:4);
scatter3(color(:,1),color(:,2),color(:,3),50,color./255,'filled');hold on 
grid on
ax = gca;
XYZ = 1:255;
num255 = ones(1,255)*255;
plot3(num255,num255,XYZ,'k',num255,XYZ,num255,'k',XYZ,num255,num255,'k');
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([0,256]),ylim([0,256]),zlim([0,256])
view(124,38)
xlabel('R');ylabel('G');zlabel('B');
title('图像1 RGB颜色散点图')
subplot(122)
data = load('img2.txt');
color = data(:,2:4);
scatter3(color(:,1),color(:,2),color(:,3),50,color./255,'filled');hold on 
grid on
ax = gca;
XYZ = 1:255;
num255 = ones(1,255)*255;
plot3(num255,num255,XYZ,'k',num255,XYZ,num255,'k',XYZ,num255,num255,'k');
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([0,256]),ylim([0,256]),zlim([0,256])
view(124,38)
xlabel('R');ylabel('G');zlabel('B');
title('图像2 RGB颜色散点图')
print(gcf,'..\img\图像1 2的rgb颜色','-dpng','-r600')
