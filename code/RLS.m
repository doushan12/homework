%% 递推最小二乘法RLS

function [Theta, Inn, J, lambda] = RLS(na, nb, z, u, L)

nMax = max(na, nb);
h = zeros(na + nb, L + nMax);
s = zeros(L + nMax, 1);
Inn = zeros(L + nMax, 1); % 模型新息
K = zeros(na + nb, L + nMax); % 算法增益
P = ones(na + nb, na + nb, L + nMax); % 数据协方差阵
P(:, :, nMax) = eye(na + nb) * 1000;
Theta = ones(na + nb, L + nMax) * 0.0001; % 模型参数
J = zeros(L + nMax, 1); % 损失函数

for k = nMax + 1 : L + nMax % 随时间迭代
    % 构造数据向量
    for i = 1:na
        h(i, k) = -z(k - i);
    end
    for i = 1:nb
        h(na + i, k) = u(k - i);
    end

    % 缺失数据处理
    if z(k) == 0
        z(k) = h(:, k)' * Theta(:, k-1);
    end

    % 辨识算法
    s(k) = h(:, k)' * P(:, :, k-1) * h(:, k) + 1.0;
    Inn(k) = z(k) - h(:, k)' * Theta(:, k-1);
    K(:, k) = P(:, :, k-1) * h(:, k) / s(k);
    P(:, :, k) = P(:, :, k-1) - K(:, k) * K(:, k)' * s(k);
    Theta(:, k) = Theta(:, k-1) + K(:, k) * Inn(k);

    % 损失函数
    J(k) = J(k-1) + Inn(k)^2 / s(k);
end

Theta = Theta(:, nMax+1 : end);
Inn = Inn(nMax+1 : end);
lambda = sqrt(J(L + nMax) / L); % 噪声标准差
