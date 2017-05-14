%º∆À„Ïÿ≤ª¥ø∂»
function imp=count_impurity(label)
n=length(label);
class_type=unique(label);
p_temp=zeros(class_type,1);
for i=1:length(class_type)
    p_temp(i)=sum(label==class_type(i));
end
p=double(p_temp)/double(n);
imp=-sum(p.*log2(p));
end