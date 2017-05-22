function [k, a, d] = decision_stump(X, y, w)
% decision_stump returns a rule ...
% h(x) = d if x(k) ??? a, ???d otherwise,
%
% Input
%     X : n * p matrix, each row a sample
%     y : n * 1 vector, each row a label
%     w : n * 1 vector, each row a weight
%
% Output
%     k : the optimal dimension
%     a : the optimal threshold
%     d : the optimal d, 1 or -1

% total time complexity required to be O(p*n*logn) or less
%%% Your Code Here %%%
p=size(X,2);
error=zeros(p,1);
a_p=zeros(p,1);
d_p=zeros(p,1);

for i=1:p
    [X_isort,X_iseq]=sort(X(:,i));
    cumsum_yw=cumsum(y(X_iseq).*w(X_iseq));%cumulative sum of elements.
    [c_max,c_maxseq]=max(cumsum_yw);
    [c_min,c_minseq]=min(cumsum_yw);
    
    if abs(c_max)>abs(c_min)
        d_p(i)=1;
        a_p(i)=X_isort(c_maxseq);
    else
        d_p(i)=-1;
        a_p(i)=X_isort(c_minseq);
    end
    %count the error rate
    error(i)=abs(sum(d_p(i)-y(X(:,i)<=a_p(i))))+abs(sum(d_p(i)+y(X(:,i)>a_p(i))));
       
end

[~,k]=min(error);
a=a_p(k);
d=d_p(k);

%%% Your Code Here %%%
end