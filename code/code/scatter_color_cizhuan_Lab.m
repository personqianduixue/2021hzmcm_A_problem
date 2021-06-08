figure('Position',[489,343,560,420])
data = load('瓷砖.txt');
color = data(:,2:4);
colorlength = size(color,1);
lab = [];
for i = 1:colorlength
    lab = [lab;rgb2lab(color(i,:)/255)];
end
scatter3(lab(:,2),lab(:,3),lab(:,1),100,color./255,'filled');hold on 
grid on
xlim([-128,128]),ylim([-128,128]),zlim([0,100])
title('瓷砖Lab颜色')
xlabel('a');ylabel('b');zlabel('L');
print(gcf,'..\img\瓷砖的Lab颜色','-dpng','-r600')