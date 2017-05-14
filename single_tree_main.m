%��һ������
%% ��ʼ��
clear;
load('Sogou_webpage.mat')
doclabel = int16(doclabel);
wordMat = int16(wordMat);

%% ȡwordmat��1/5Ϊ���Լ���4/5Ϊѵ����
delta=5;
n=length(doclabel);
k=randperm(n);
wordMat_rand=wordMat(k,:);
doclabel_rand=doclabel(k,:);
train_word=wordMat_rand(1:0.8*n,:);
train_label=doclabel_rand(1:0.8*n,:);
test_word=wordMat_rand(0.8*n+1:end,:);
test_label=doclabel_rand(0.8*n+1:end,:);

%% ����������
threshold=[0.05 0.07 0.1];
for i=1:length(threshold)
    [leaf_principles, leaf_class]=build_Tree(train_word,train_label,threshold(i));
    train_acc=test_tree(train_word,train_label,leaf_principles,leaf_class);
    test_acc=test_tree(test_word,test_label,leaf_principles,leaf_class);
end

