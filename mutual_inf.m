function mi = mutual_inf(X, Y)
num=size(X,1);
Z=[X Y];
%将X分成X_interval=10个区间,利用频率计算每个区间的的概率值,team储存每个区间的起始值（中间值-区间长度的一半）
X_interval=20;
[pX,team]=hist(X, X_interval);
pX=pX./num;
team=team-(max(X)-min(X))/(2*X_interval);
%不能使某一区间的概率为0
i = find(pX == 0);
pX(i) = 0.00001;
%利用频率计算标签的的概率值
pY=[length(find(Y==1)) length(find(Y==2))]/num;
Y_interval=length(pY);
%利用频率计算XY联合概率密度
pXY=zeros(Y_interval,X_interval);
for i=1:Y_interval
    for j=1:X_interval
        if(j==X_interval)
            count=((Z(:,1)>=team(j))&(Z(:,2)==i));
        else
            count=((Z(:,1)<team(j+1))&(Z(:,1)>=team(j))&(Z(:,2)==i));
        end
        pXY(i,j)=length(find(count==1))/num;
        if(pXY(i,j)==0)
            pXY(i,j)=0.00001;
        end
    end
end
HX=-sum(pX .* log(pX));%计算数据的信息熵
HY=-sum(pY .* log(pY));%计算标签的信息熵
pX=repmat(pX,Y_interval,1);
pY=repmat(pY',1,X_interval);
mi=-sum(sum(pXY.*log(pXY./(pX.*pY))));
end