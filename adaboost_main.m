clear;
close all;

load('ada_data.mat');

maxIter=300;

[e_train, e_test] = adaboost(X_train, y_train, X_test, y_test, maxIter);

figure;
plot(1:maxIter,e_train,'-b');
hold on;
plot(1:maxIter,e_test,'-r');
xlabel('interation num');
ylabel('error rate');
title('adaboost with different interation num');
legend('train error','test error');
hold off;
