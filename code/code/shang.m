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
    %��������  ������ʾָ���� �� ������ʾ���۵ĸ����� 
    %������ 7�����۸��� 3������ָ��
    X = [chenben',biaoxianli'] ;
    %˵��ָ��������ָ�껹�Ǹ���ָ��
    %�����ݵ�һ���Ǹ���ָ�꣬ ����Ϊ����ָ��
    Ind=[2 1]; %Specify the positive or negative direction of each indicator
    %S Ϊ�������� WΪָ��Ȩ��
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
title(lgd,'��ͬ�����������ɫ��')
% legend('boxoff')
title('�÷���������ɫ�����ı仯');xlabel('������ɫ����');ylabel('��Ե÷�')
print(gcf,'..\img\�÷���������ɫ�����ı仯','-dpng','-r600')

function [s,w]=sqf(x,ind)
%ʵ������ֵ�����ָ��(�У���Ȩ�ؼ��������еĵ÷�
%xΪԭʼ���ݾ���, һ�д���һ������, ÿ�ж�Ӧһ��ָ��
%indָʾ������ָʾ��������ָ�껹�Ǹ���ָ�꣬1��ʾ����ָ�꣬2��ʾ����ָ��
%s���ظ��У��������÷֣�w���ظ���Ȩ��
[n,m]=size(x); % n������, m��ָ��
%%���ݵĹ�һ������
for i=1:m
    if ind(i)==1 %����ָ���һ��
        X(:,i)=guiyi(x(:,i),1,0.002,0.996);    %����һ����[0,1], 0�������
    else %����ָ���һ��
        X(:,i)=guiyi(x(:,i),2,0.002,0.996);
    end
end

Y = X;
%%�����j��ָ���£���i������ռ��ָ��ı���p(i,j)
for i=1:n
    for j=1:m
        p(i,j)=X(i,j)/sum(X(:,j));
    end
end

%%�����j��ָ�����ֵe(j)
k=1/log(n);
for j=1:m
    e(j)=-k*sum(p(:,j).*log(p(:,j)));
end
d=ones(1,m)-e; %������Ϣ�������
w=d./sum(d); %��Ȩֵw
s=100*w*p'; %���ۺϵ÷�
end

function y=guiyi(x,type,ymin,ymax)
%ʵ���������ָ���һ�������ع�һ��������ݾ���
%xΪԭʼ���ݾ���, һ�д���һ������, ÿ�ж�Ӧһ��ָ��
%type�趨����ָ��1,����ָ��2
%ymin,ymaxΪ��һ��������˵�
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