%% �������ݹ�
function [principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, Index, if_choosed, imp, principle, leaf_principles, leaf_class, threshold)
%% ��ֵ����
last_principle=cell2mat(principle(end));
class_type=unique(label(Index));
%��ֹ����1��Ҷ��ȫΪ1���Ҷ������Ϊ0
if (length(class_type)<=1)||(sum(if_choosed)==0)
    leaf_principles(end+1)={last_principle};
    leaf_class(end+1)=mode(label(Index));
    %disp(['class = ' num2str(leaf_class(end))]);
    return;
end

[feature,pos_imp,neg_imp,imp_max]=choose_feature(...
    train,label,imp,if_choosed,Index);
if_choosed(feature)=false;

%��ֹ����2������½�����С����ֵthreshold1;������ȴ���threshold2������������С��threshold3
threshold2=50;
threshold3=10;
if imp_max<threshold||length(last_principle)>threshold2||sum(Index)<threshold3
    leaf_principles(end+1)={last_principle};
    leaf_class(end+1)=mode(label(Index));
    %disp(['class = ' num2str(leaf_class(end))]);
    return;
end
%% �ݹ���������������

pos_Index=Index&(train(:,feature)==1);
neg_Index=Index&(train(:,feature)==0);

principle(end+1)={[last_principle,feature]};
[principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, pos_Index, if_choosed, pos_imp, principle, leaf_principles, leaf_class, threshold);

principle(end+1)={[last_principle,-feature]};
[principle, leaf_principles, leaf_class] = GrowTree(...
    train, label, neg_Index, if_choosed, neg_imp, principle, leaf_principles, leaf_class, threshold);

end

