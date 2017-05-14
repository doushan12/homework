%% 决策树递归
function [principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, Index, if_choosed, imp, principle, leaf_principles, leaf_class, threshold)
%% 终值条件
last_principle=cell2mat(principle(end));
class_type=unique(label(Index));
%终止条件1：叶子全为1类或叶子数量为0
if (length(class_type)<=1)||(sum(if_choosed)==0)
    leaf_principles(end+1)={last_principle};
    leaf_class(end+1)=mode(label(Index));
    %disp(['class = ' num2str(leaf_class(end))]);
    return;
end

[feature,pos_imp,neg_imp,imp_max]=choose_feature(...
    train,label,imp,if_choosed,Index);
if_choosed(feature)=false;

%终止条件2：最大下降增益小于阈值threshold1;树的深度大于threshold2；子树样本数小于threshold3
threshold2=50;
threshold3=10;
if imp_max<threshold||length(last_principle)>threshold2||sum(Index)<threshold3
    leaf_principles(end+1)={last_principle};
    leaf_class(end+1)=mode(label(Index));
    %disp(['class = ' num2str(leaf_class(end))]);
    return;
end
%% 递归左子树和右子树

pos_Index=Index&(train(:,feature)==1);
neg_Index=Index&(train(:,feature)==0);

principle(end+1)={[last_principle,feature]};
[principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, pos_Index, if_choosed, pos_imp, principle, leaf_principles, leaf_class, threshold);

principle(end+1)={[last_principle,-feature]};
[principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, neg_Index, if_choosed, neg_imp, principle, leaf_principles, leaf_class, threshold);

end

