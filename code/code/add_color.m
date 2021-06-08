clc,clear
cizhuan_rgb = load('瓷砖.txt');
cizhuan_rgb = cizhuan_rgb(:,2:4);
NUM =  size(cizhuan_rgb,1);

n = 0;
diary(['log_增加',num2str(n),'.log']);diary on;
R = intvar(1,n);G = intvar(1,n);B = intvar(1,n);
for i = 1:n
    cizhuan_rgb = [cizhuan_rgb;[R(i),G(i),B(i)]];
end

for i = 1:NUM+n
    for j = 1:NUM+n
        if i>NUM||j>NUM
            D(i,j) = color_similarity(cizhuan_rgb(i,:),cizhuan_rgb(j,:));
        end
    end
end
for i =1:NUM
    for j =1:NUM
        D(i,j) = color_similarity(cizhuan_rgb(i,:),cizhuan_rgb(j,:));
    end
end
D = D+diag(ones(1,n+NUM)*inf);

C = [];
for i = 1:n
    C =[C,R(i)>=0,R(i)<=255,G(i)>=0,G(i)<=255,B(i)>=0,B(i)<=255];
end
Z = -sum((min(D)));

result  = optimize(C,Z);
% if result.problem== 0
%     value(R)
%     value(G)
%     value(B)
%     value(Z)
% else
%     disp('求解过程中出错');
% end
value(R)
value(G)
value(B)
value(Z)
%% 绘图
figure('Position',[187.4,300.2,884.8,392.8])
data = load('瓷砖.txt');
color = data(:,2:4);
colorlength = size(color,1);
subplot(121)
scatter3(color(:,1),color(:,2),color(:,3),25,color./255,'filled');hold on
grid on
ax = gca;
XYZ = 1:255;
num255 = ones(1,255)*255;
plot3(num255,num255,XYZ,'k',num255,XYZ,num255,'k',XYZ,num255,num255,'k');hold on
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([0,256]),ylim([0,256]),zlim([0,256])
view(-37.5+160,28)
xlabel('R');ylabel('G');zlabel('B');title(['RGB(添加',num2str(n),'个点)'])
scatter3(value(R),value(G),value(B),100,[value(R)',value(G)',value(B)']/255,'filled')

subplot(122)
lab = rgb2lab(color/255);
scatter3(lab(:,2),lab(:,3),lab(:,1),25,color./255,'filled');hold on
grid on
xlim([-128,128]),ylim([-128,128]),zlim([0,100])
xlabel('a');ylabel('b');zlabel('L');
out_rgb = [value(R)',value(G)',value(B)'];
out_lab = rgb2lab(out_rgb/255);
title(['Lab(添加',num2str(n),'个点)'])
scatter3(out_lab(:,2),out_lab(:,3),out_lab(:,1),100,out_rgb./255,'filled');
print(gcf,['..\img\添加',num2str(n),'个点'],'-dpng','-r600')
%% 保存数据

value_RGB = num2cell([(1:n)',value(R)',value(G)',value(B)']);
title = {'序号','R','G','B'};
result_RGB = [title;value_RGB];
writecell(result_RGB,['.\增加',num2str(n),'个点.xlsx']);
dlmwrite('目标值.xlsx',-value(Z),'-append');
diary off;
