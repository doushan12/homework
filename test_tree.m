%% ²âÊÔ¾ö²ßÊ÷
function [accuracy,class]=test_tree(data,label,leaf_principles,leaf_class)
n=size(data,1);
leaf_n=length(leaf_principles);
class=zeros(n,1);
for i=1:n
    x=data(i,:);
    for j=1:leaf_n
        pri=cell2mat(leaf_principles(j));
        pos_pri=pri(pri>0);
        neg_pri=-pri(pri<0);
        
        if sum(x(:,pos_pri))==length(pos_pri)&&sum(x(:,neg_pri))==0
            class(i)=leaf_class(j);
            continue;
        end
        
    end
end
accuracy=double(sum(class==label))/double(n);
end