%% RLS

function [theta, Inn, J, lambda,epsilon] = RML(n_a, n_b, n_d,z, u, L)

nMax = max(max(n_a, n_b),n_d);
h = zeros(n_a + n_b+n_d, L + nMax);
hf = zeros(n_a + n_b+n_d, L + nMax);
s = zeros(L + nMax, 1);
Inn = zeros(L + nMax, 1); % new information
K = zeros(n_a + n_b+n_d, L + nMax); % gain
P = ones(n_a + n_b+n_d, n_a + n_b+n_d, L + nMax); % Covariance matrix
P(:, :, nMax) = eye(n_a + n_b+n_d) * 1000;
theta = ones(n_a + n_b+n_d, L + nMax) * 0.0001; % model parameter
J = zeros(L + nMax, 1); %loss function
v1=zeros(L + nMax, 1);
zf=zeros(L + nMax, 1);
uf=zeros(L + nMax, 1);
v1f=zeros(L + nMax, 1);

for k = nMax + 1 : L + nMax
    
    for i = 1:n_a
        h(i, k) = -z(k - i);
        hf(i,k)=-zf(k-i);
    end
    for i = 1:n_b
        h(n_a + i, k) = u(k - i);
        hf(n_a + i, k) = uf(k - i);
    end
    for i = 1:n_d
        h(n_a +n_b+ i, k) = v1(k - i);
        hf(n_a +n_b+ i, k) = v1f(k - i);
    end
    if z(k) == 0
        z(k) = h(:, k)' * theta(:, k-1);
    end
    %update variable
    s(k) = hf(:, k)' * P(:, :, k-1) * hf(:, k) + 1.0;
    Inn(k) = z(k) - h(:, k)' * theta(:, k-1);
    K(:, k) = P(:, :, k-1) * hf(:, k) / s(k);
    P(:, :, k) = P(:, :, k-1) - K(:, k) * K(:, k)' * s(k);
    theta(:, k) = theta(:, k-1) + K(:, k) * Inn(k);
    % count loss
    J(k) = J(k-1) + Inn(k)^2 / s(k);
    v1(k)=z(k)-h(:,k)'*theta(:,k);
    zf(k)=z(k);uf(k)=u(k);v1f(k)=v1(k);
    for i=1:n_d
        zf(k)=zf(k)-theta(n_a+n_b+i,k)*zf(k-i);
        uf(k)=uf(k)-theta(n_a+n_b+i,k)*uf(k-i);
        v1f(k)=v1f(k)-theta(n_a+n_b+i,k)*v1f(k-i);
    end
end


theta = theta(:, nMax+1 : end);
Inn = Inn(nMax+1 : end);
lambda = sqrt(J(L + nMax) / L);
epsilon = z(nMax+1:nMax+L) - h(:, nMax + 1 : nMax + L)' * theta(:, end);

end
