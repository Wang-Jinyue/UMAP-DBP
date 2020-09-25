function self_mi = self_mutual_inf(X, Y)
num=size(X,1);
Z=[X Y];
%��X�ֳ�X_interval=10������,����Ƶ�ʼ���ÿ������ĵĸ���ֵ,team����ÿ���������ʼֵ���м�ֵ-���䳤�ȵ�һ�룩
X_interval=20;
[pX,team1]=hist(X, X_interval);
pX=pX./num;
team1=team1-(max(X)-min(X))/(2*X_interval);

%��Y�ֳ�X_interval=10������,����Ƶ�ʼ���ÿ������ĵĸ���ֵ,team����ÿ���������ʼֵ���м�ֵ-���䳤�ȵ�һ�룩
Y_interval=20;
[pY,team2]=hist(Y, Y_interval);
pY=pY./num;
team2=team2-(max(Y)-min(Y))/(2*Y_interval);

%����ʹĳһ����ĸ���Ϊ0
i = find(pX == 0);
pX(i) = 0.00001;
i = find(pY == 0);
pY(i) = 0.00001;

%����Ƶ�ʼ���XY���ϸ����ܶ�
pXY=zeros(Y_interval,X_interval);
for i=1:Y_interval
    if(i==Y_interval)
        count_y=(Z(:,2)>=team2(i));
    else
        count_y=(Z(:,2)<team2(i+1))&(Z(:,2)>=team2(i));
    end
    for j=1:X_interval
        if(j==X_interval)
            count_x=(Z(:,1)>=team1(j));
        else
            count_x=((Z(:,1)<team1(j+1))&(Z(:,1)>=team1(j)));
        end
        count=count_y&count_x;
        pXY(i,j)=length(find(count==1))/num;
        if(pXY(i,j)==0)
            pXY(i,j)=0.00001;
        end
    end
end
HX=-sum(pX .* log(pX));%�������ݵ���Ϣ��
HY=-sum(pY .* log(pY));%�����ǩ����Ϣ��
pX=repmat(pX,Y_interval,1);
pY=repmat(pY',1,X_interval);
self_mi=sum(sum(pXY.*log(pXY./(pX.*pY))));
end