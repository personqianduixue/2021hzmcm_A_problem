figure('Position',[489,343,560,420])
data = load('瓷砖.txt');
color = data(:,2:4);
colorlength = size(color,1);

scatter3(color(:,1),color(:,2),color(:,3),100,color./255,'filled');hold on 
grid on
ax = gca;
XYZ = 1:255;
num255 = ones(1,255)*255;
plot3(num255,num255,XYZ,'k',num255,XYZ,num255,'k',XYZ,num255,num255,'k');
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([0,256]),ylim([0,256]),zlim([0,256])
view(-37.5+160,28)
xlabel('R');ylabel('G');zlabel('B');
title('瓷砖rgb颜色')
print(gcf,'..\img\瓷砖的rgb颜色','-dpng','-r600')