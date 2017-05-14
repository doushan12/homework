%% 多决策树
%% 初始化
clear;
load('Sogou_webpage.mat')
doclabel = int16(doclabel);
wordMat = int16(wordMat);

%% 取wordmat的1/5为测试集，4/5为训练集
delta=5;
n=length(doclabel);
k=randperm(n);
wordMat_rand=wordMat(k,:);
doclabel_rand=doclabel(k,:);
train_word=wordMat_rand(1:0.8*n,:);
train_label=doclabel_rand(1:0.8*n,:);
test_word=wordMat_rand(0.8*n+1:end,:);
test_label=doclabel_rand(0.8*n+1:end,:);

%% 训练及测试
threshold=0.1;
tree_num=10;
train_res=zeros(length(train_label),tree_num);
test_res=zeros(length(test_label),tree_num);
for i=1:tree_num
        train_part=train_word(i:tree_num:end,:);%选训练集1/tree_num作为新训练集
        label_part=train_label(i:tree_num:end);
        [leaf_principles, leaf_class]=build_Tree(train_part,label_part,threshold);
        [~,train_res(:,i)]=test_tree(train_word,train_label,leaf_principles,leaf_class);
        [~,test_res(:,i)]=test_tree(test_word,test_label,leaf_principles,leaf_class);
end
train_res_final=mode(train_res,2);%分类结果取众数
test_res_final=mode(test_res,2);

train_acc=sum(train_res_final==train_label)/length(train_label);
test_acc=sum(test_res_final==test_label)/length(test_label);

disp(['tree_num=',num2str(tree_num),'  train_acc=',num2str(train_acc),'  test_acc=',num2str(test_acc)]);


