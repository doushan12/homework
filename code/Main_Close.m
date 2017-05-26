%%  main function :Closed - loop system forward channel identification

%initiate

close all;
z = zk_1(10:end, 2);%select middle part of the data 
u = uk_1(10:end, 2);

%configeration
L = 1800; 
na = 2;
nb = 1;
d = 1;
true_Theta_F=[1.4, 0.45, 1, 0.7];

%RLS
[Theta_F_F, Inn, J, lambda] = RLS(na, nb + d, z, u, L);
Theta_F_ex_F = Theta_F_F(:, end);
disp(Theta_F_ex_F);
disp(lambda); 

%% plot 

figure;
hold on;

h1 = plot(1:L, Theta_F(1, :), 'r');
h2 = plot(1:L, Theta_F(2, :), 'g');
h3 = plot(1:L, Theta_F(3, :), 'b');
h4 = plot(1:L, Theta_F(4, :), 'm');

plot([1, L], [true_Theta_F(1) true_Theta_F(1)], 'r--');
plot([1, L], [true_Theta_F(2) true_Theta_F(2)], 'g--');
plot([1, L], [true_Theta_F(3) true_Theta_F(3)], 'b--');
plot([1, L], [true_Theta_F(4) true_Theta_F(4)], 'm--');

legend([h1, h2, h3, h4], 'a_1', 'a_2', 'b_0', 'b_1');
set(findobj(get(gca, 'Children'), 'LineWidth', 0.5), 'LineWidth', 1.2);

title('Closed - loop system forward channel identification result');
xlabel('time');
ylabel('Parameter estimation');
ylim([-1.5, 3]);
hold off;
