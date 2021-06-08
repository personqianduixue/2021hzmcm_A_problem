clc,clear
y = [124335,1.4463e+05,1.6334e+05,1.7809e+05,1.9069e+05,2.0315e+05,2.1411e+05,2.2326e+05,2.3565e+05,2.4102e+05...
,2.4541e+05,2.4971e+05,2.5221e+05,2.6872e+05];
y = mapminmax(y,0,1);
x = [0:12,20];
% cftool(x,y)
xi = [0:50];
yi = (1.456*xi-0.1841)./(xi+7.622);
figure('Position',[202.6,297.8,709.6,252.8])
plot(x,y,'*',xi,yi,'r--','LineWidth',1)
% ylim([0,1.1]);
xlabel('增加的颜色数量n'),ylabel('相对表现力'),title('相对表现力随新增颜色数量的变化')
text('Interpreter','latex','String','$y=\frac{1.459n-0.1841}{n+7.622}$','Position',[25,0.9],'FontSize',15)
legend('实际数据', '拟合曲线','Location','best');
print(gcf,'..\img\相对表现力随新增颜色数量的变化','-dpng','-r600')
