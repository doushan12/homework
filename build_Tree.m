%生成决策树
function []=build_Tree(train,label,thredhold)
Index=(doclabel>0);
if_choosed=true(size(train,2),1);
imp=count_impurity(label,Index);
feature=choose_feature(train,label,imp,if_choosed,Index);
if_choosed(feature)=false;


end