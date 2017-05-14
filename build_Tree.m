%% 生成决策树
function [leaf_principles, leaf_class]=build_Tree(train,label,threshold)
Index=(label>0);
if_choosed=true(size(train,2),1);
imp=count_impurity(label,Index);
%选取特征
feature=choose_feature(train,label,imp,if_choosed,Index);
if_choosed(feature)=false;

%分左右子树样本
pos_Index=Index&(train(:,feature)==1);
neg_Index=Index&(train(:,feature)==0);

leaf_principles={};
leaf_class=[];

principle(1)={feature};
[principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, pos_Index, if_choosed, imp, principle, leaf_principles, leaf_class, threshold);

principle(end+1)={-feature};
[~, leaf_principles, leaf_class] = GrowTree(...
    train, label, neg_Index, if_choosed, imp, principle, leaf_principles, leaf_class, threshold);


end