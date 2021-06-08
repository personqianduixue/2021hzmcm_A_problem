clc;clear
beishu = 1;
maxc = 100;
figure('Position',[129.8,294.6,967.2,380])
plotlegend = []; 
i = 0;
for maxcolornum = 20:10:maxc
    i = i+1;
    colornum = 1:maxcolornum;
    biaoxianli = (1.456*colornum-0.1841)./(colornum+7.622);
    chenben = beishu*colornum;
    chenben = mapminmax(chenben,0,1);
    biaoxianli = mapminmax(biaoxianli,0,1);
    %加载数据  列数表示指标数 ， 行数表示评价的个体数 
    %此数据 7个评价个体 3个评价指标
    X = [chenben',biaoxianli'] ;
    %说明指标是正向指标还是负向指标
    %此数据第一个是负向指标， 其余为正向指标
    Ind=[2 1]; %Specify the positive or negative direction of each indicator
    %S 为分数排名 W为指标权重
    [S,W]=sqf(X,Ind); % get the score

    func = @(x) (1.456*x-0.1841)./(x+7.622);
    result = -W(1)*mapminmax(colornum)+W(2)*mapminmax(func(colornum));
    plotnow = plot(colornum,result,'LineWidth',1.5);
    plotlegend = [plotlegend,plotnow];
    legendstr{i} = ['maxnum=',num2str(maxcolornum)];
    hold on;
    [maxvalue,position] = max(result);
    scatter(position,maxvalue,'*')
    line([position,position],[-0.8,maxvalue],'LineStyle','--','LineWidth',0.5)
    
end
% xtick([0,5,6,7,10:10:maxc])
% xticklabel([0,5,6,7,10:10:maxc])
set(gca,'XTick',[0,4,5,6,10:10:maxc]);
set(gca,'XTickLabel',[0,4,5,6,10:10:maxc]);
lgd = legend(plotlegend,legendstr,'NumColumns',2);
title(lgd,'不同的最大新增颜色数')
% legend('boxoff')
title('得分随新增颜色数量的变化');xlabel('新增颜色数量');ylabel('相对得分')
print(gcf,'..\img\得分随新增颜色数量的变化','-dpng','-r600')

function [s,w]=sqf(x,ind)
%实现用熵值法求各指标(列）的权重及各数据行的得分
%x为原始数据矩阵, 一行代表一个样本, 每列对应一个指标
%ind指示向量，指示各列正向指标还是负向指标，1表示正向指标，2表示负向指标
%s返回各行（样本）得分，w返回各列权重
[n,m]=size(x); % n个样本, m个指标
%%数据的归一化处理
for i=1:m
    if ind(i)==1 %正向指标归一化
        X(:,i)=guiyi(x(:,i),1,0.002,0.996);    %若归一化到[0,1], 0会出问题
    else %负向指标归一化
        X(:,i)=guiyi(x(:,i),2,0.002,0.996);
    end
end

Y = X;
%%计算第j个指标下，第i个样本占该指标的比重p(i,j)
for i=1:n
    for j=1:m
        p(i,j)=X(i,j)/sum(X(:,j));
    end
end

%%计算第j个指标的熵值e(j)
k=1/log(n);
for j=1:m
    e(j)=-k*sum(p(:,j).*log(p(:,j)));
end
d=ones(1,m)-e; %计算信息熵冗余度
w=d./sum(d); %求权值w
s=100*w*p'; %求综合得分
end

function y=guiyi(x,type,ymin,ymax)
%实现正向或负向指标归一化，返回归一化后的数据矩阵
%x为原始数据矩阵, 一行代表一个样本, 每列对应一个指标
%type设定正向指标1,负向指标2
%ymin,ymax为归一化的区间端点
[n,m]=size(x);
y=zeros(n,m);
xmin=min(x);
xmax=max(x);
switch type
    case 1
        for j=1:m
            y(:,j)=(ymax-ymin)*(x(:,j)-xmin(j))/(xmax(j)-xmin(j))+ymin;
        end
    case 2
        for j=1:m
            y(:,j)=(ymax-ymin)*(xmax(j)-x(:,j))/(xmax(j)-xmin(j))+ymin;
        end
end
end
function X0 = stand(X)

    zeros(size(X));
    [nr,nx]=size(X);
    for mk=1:nr
        X0(mk,:)=(X(mk,:)-mean(X))./std(X);
    end
end