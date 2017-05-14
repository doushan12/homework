%根据不纯度下降值选取特征
function [feature,pos_imp,neg_imp]=choose_feature(...
    train,label,imp,if_choosed,Index)
n=sum(Index);
feature_num=length(if_choosed);
pos_imps=zeros(feature_num,1);
neg_imps=zeros(feature_num,1);
imp_decrease=-ones(feature_num)*inf;

for i=1:feature_num
    if if_choosed(i)
    pos_Index=Index*(train(:,i)==1);
    neg_Index=Index*(train(:,i)==0);
    pos_imps(i)=count_impurity(label,pos_Index);
    neg_imps(i)=count_impurity(label,neg_Index);
    %信息增益
    imp_decrease(i)=imp- pos_imps(i)*sum( pos_Index)/n...
        -neg_imps(i)*sum(neg_Index)/n;
    %信息增益率
    %imp_decrease(i)=imp_decrease(i)/count_impurity(label,Index);
    
    end
end



end