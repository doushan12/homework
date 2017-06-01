function z_est_ARMAX=estimate_z_ARMAX(theta,na,nb,nd,u,z,L)
L=L+max(max(na, nb),nd);
nMax = max(max(na, nb),nd);
h = zeros(na + nb+nd, 1);
z_est=z;v1=zeros(na + nb+nd, 1);
for k = nMax+1 : L
    for i = 1:na
        h(i) = -z_est(k - i);
    end
    for i = 1:nb
        h(na + i) = u(k - i);
    end
    for i=1:nd
        h(na +nb+ i) = v1(k - i);
    end
    z_est(k) = h' * theta;
    v1(k)=z_est(k)-h' * theta;
end
z_est_ARMAX=z_est;
figure;
hold on;
plot(1:L,z,'b');
plot(1:L,z_est,'r');
legend('real output','estimate output');
title('real output and estimate output');
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold off;
end