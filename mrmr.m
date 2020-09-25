clear all
close all
clc;

data=xlsread('D:\paper\DNA Binding protein\data\feature extraction\S2\combine.xlsx')
lab(1:297,1)=1;lab(298:594,1)=2;

len=size(data,1);
%πÈ“ªªØ
maxV=max(data);
minV=min(data);
range=maxV-minV;
newdata=(data-repmat(minV,[len,1]))./(repmat(range,[len,1]));
feature_num=size(newdata,2);

rank1=[];
for i = 1:size(newdata,2)
    rank1 = [rank1; mutual_inf(newdata(:,i),lab) i]; 
end

rank1=sortrows(rank1,1);    
w=rank1(1:feature_num, 1);
r=rank1(1:feature_num, 2);

num_select=1915;

self_rank=zeros(num_select,num_select);
choose_data=newdata(:,r(1:num_select));
for i=1:num_select-1
    for j=i+1:num_select
        self_rank(i,j) = self_mutual_inf(newdata(:,i),newdata(:,j));
        self_rank(j,i) = self_rank(i,j);
    end
end

for i=1:num_select
    self_rank(i,i)=1;
end

rank2=[mean(self_rank,2) r(1:num_select)];
rank1(1:num_select,1)=-rank1(1:num_select,1);
max_rank1=max(rank1(1:num_select,1));
max_rank2=max(rank2(:,1));
min_rank1=min(rank1(1:num_select,1));
min_rank2=min(rank2(:,1));
range1=max_rank1-min_rank1;
range2=max_rank2-min_rank2;
rank1(1:num_select,1)=(rank1(1:num_select,1)-min_rank1)/range1;
rank2(:,1)=(rank2(:,1)-min_rank2)/range2;


RANK=[(rank1(1:num_select,1)-rank2(1:num_select,1)) r(1:num_select)];
RANK=sortrows(RANK,-1);

data=[];
for i=1:num_select
    data=[data newdata(1:594,RANK(i,2))];
end

lab(1:297,1)=1;lab(298:594,1)=0;

data=[data lab];
xlswrite('D:\paper\DNA Binding protein\data\umap-Dimensionality reduction\compare\MRMR\BP594_mrmr.xlsx',data);