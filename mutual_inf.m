function mi = mutual_inf(X, Y)
num=size(X,1);
Z=[X Y];
%��X�ֳ�X_interval=10������,����Ƶ�ʼ���ÿ������ĵĸ���ֵ,team����ÿ���������ʼֵ���м�ֵ-���䳤�ȵ�һ�룩
X_interval=20;
[pX,team]=hist(X, X_interval);
pX=pX./num;
team=team-(max(X)-min(X))/(2*X_interval);
%����ʹĳһ����ĸ���Ϊ0
i = find(pX == 0);
pX(i) = 0.00001;
%����Ƶ�ʼ����ǩ�ĵĸ���ֵ
pY=[length(find(Y==1)) length(find(Y==2))]/num;
Y_interval=length(pY);
%����Ƶ�ʼ���XY���ϸ����ܶ�
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
HX=-sum(pX .* log(pX));%�������ݵ���Ϣ��
HY=-sum(pY .* log(pY));%�����ǩ����Ϣ��
pX=repmat(pX,Y_interval,1);
pY=repmat(pY',1,X_interval);
mi=-sum(sum(pXY.*log(pXY./(pX.*pY))));
end