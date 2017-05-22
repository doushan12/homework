function e = adaboost_error(X, y, k, a, d, alpha)
% adaboost_error: returns the final error rate of a whole adaboost
% 
% Input
%     X     : n * p matrix, each row a sample
%     y     : n * 1 vector, each row a label
%     k     : iter * 1 vector,  selected dimension of features
%     a     : iter * 1 vector, selected threshold for feature-k
%     d     : iter * 1 vector, 1 or -1
%     alpha : iter * 1 vector, weights of the classifiers
%
% Output
%     e     : error rate      

%%% Your Code Here %%%

n=size(X,1);
iter=sum(k>0);

y_esti = zeros(n, 1);
for i = 1:iter
    y_i = ((X(:, k(i)) <= a(i)) * 2 - 1) * d(i);
    y_esti = y_esti + y_i * alpha(i);
end
e = sum(sign(y_esti) ~= y) / n;

%%% Your Code Here %%%

end