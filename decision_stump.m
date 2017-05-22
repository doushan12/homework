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
    [X_isort,X_iseq]=sort(X(:,i), 'ascend');
    cumsum_yw=cumsum(y(X_iseq).*w(X_iseq));%cumulative sum of elements.
    [~,c_maxseq]=max(cumsum_yw);
    [~,c_minseq]=min(cumsum_yw);
    
     %count the error rate
    err1 = abs(sum(w(X(:, i) <= X_isort(c_maxseq)) .* (1 ~= y(X(:, i) <= X_isort(c_maxseq))))) + ...
        abs(sum(w(X(:, i) > X_isort(c_maxseq)) .* (-1 ~= y(X(:, i) > X_isort(c_maxseq)))));
    err2 = abs(sum(w(X(:, i) <= X_isort(c_minseq)) .* (-1 ~= y(X(:, i) <= X_isort(c_minseq))))) + ...
        abs(sum(w(X(:, i) > X_isort(c_minseq)) .* (1 ~= y(X(:, i) > X_isort(c_minseq)))));
    
    if err1<err2
        d_p(i)=1;
        a_p(i)=X_isort(c_maxseq);
        error(i)=err1;
    else
        d_p(i)=-1;
        a_p(i)=X_isort(c_minseq);
        error(i)=err2;
    end
         
end

[~,k]=min(error);
a=a_p(k);
d=d_p(k);

%%% Your Code Here %%%
end