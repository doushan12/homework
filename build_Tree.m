%生成决策树
function [leaf_principles, leaf_class]=build_Tree(train,label,thredhold)
Index=(doclabel>0);
if_choosed=true(size(train,2),1);
imp=count_impurity(label,Index);
feature=choose_feature(train,label,imp,if_choosed,Index);
if_choosed(feature)=false;

pos_Index=Index&(train(Index,feature)==1);
neg_Index=Index&(train(Index,feature)==0);

%创建左右子树
leaf_principles={};
leaf_class=[];

principle(1)={feature};

[principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, pos_Index, if_choosed, imp, principle, leaf_principles, leaf_class, threshold);
principle(end+1)={-feature};
[~, leaf_principles, leaf_class] = GrowTree(...
    train, label, neg_Index, if_choosed, imp, principle, leaf_principles, leaf_class, threshold);


end