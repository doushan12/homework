clear;
close all;

load('ada_data.mat');

maxIter=300;

[e_train, e_test] = adaboost(X, y, X_test, y_test, maxIter);

figure;
plot(1:maxIter,e_train,'-b');
hold on;
plot(1:maxIter,e_test,'-r');
xlabel('interation num');
ylabel('error rate');
title('adaboost with different interation num');
legend('train_error','test_error');
hold off;
