%% �����ز�����
function imp=count_impurity(label,Index)
n=sum(Index);
label_now=label(Index);%��ǰҪ���������
class_type=unique(label_now);
p_temp=zeros(length(class_type),1);
for i=1:length(class_type)
    p_temp(i)=sum(label_now==class_type(i));
end
p=double(p_temp)/double(n);
imp=-sum(p.*log2(p));%�ز�����
end