%% info
% This script generates Fig. 4 of our paper:
% Ziling Wu and George Barbastathis "Universal K-space theory of 
% three-dimensional Optical Microscopy"
% for optical diffraction tomography
% under transmission and reflection modes
% This code requires the subaxis.m and arrow.m files from MathWorks File
% Exchange.

%%
clearvars
lambda = 0.532;
k = 2*pi/lambda;
theta_0 = pi/8;
alpha = -pi/20;
gama = linspace(0, 2*pi, 1000);
circle = @(r0, radius) [radius*cos(gama)+r0(1); radius*sin(gama)+r0(2)];
%

fig = figure('units', 'inches', 'position', [4, 4, 6.4, 4]);
NA_all = [0.3,0.6];
for i = 1:2
    NA = NA_all(i);

%
h1 = subaxis(2, 2, (i-1)*2+1, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);
theta = linspace(-asin(NA),asin(NA),256);
alpha = linspace(-asin(NA),asin(NA),100);

c = circle([0, k], k);
% plot k-space sphere
plot(c(1,:), c(2,:), '--','color',[0.5 0.5 0.5],'LineWidth',0.1)
ylabel(['NA = ', num2str(NA)])
hold on
% plot center of the sphere
scatter(0, k,20,'filled','MarkerFaceColor',[0.4,0.4,0.4])
hold on
for idx = 1:length(alpha)
    alpha_tmp = alpha(idx);
    k_s_x = k.*sin(theta)-k*sin(alpha_tmp);
    k_s_y = -k.*cos(theta)+k*cos(alpha_tmp);
    plot(k_s_x,k_s_y,'LineWidth',1);
    hold on
end
% plot axis vectors:
arrow([0,-k*0.3], [0, k*2.3], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k*1.4,0], [k*1.4, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])
text(-1.5, 2*k-0.2, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k*1.2, -1.8, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
hold on
text(-3, k, '$k$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
xlim([-k-0.5*k, k+0.5*k])
ylim([0-0.5*k, 2*k+0.5*k])
if i==1
    title('(a) Transmission mode', 'fontweight', 'normal','FontSize', 10)
end
axis image
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])

h2 = subaxis(2, 2, (i-1)*2+2, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);

c = circle([0, k], k);
% plot k-space sphere
plot(c(1,:), c(2,:), '--','color',[0.5 0.5 0.5],'LineWidth',0.1)

hold on
% plot center of the sphere
scatter(0, k,20,'filled','MarkerFaceColor',[0.4,0.4,0.4])
hold on
for idx = 1:length(alpha)
    alpha_tmp = alpha(idx);
    k_s_x = k.*sin(theta)-k*sin(alpha_tmp);
    k_s_y = k.*cos(theta)+k*cos(alpha_tmp);
    plot(k_s_x,k_s_y,'LineWidth',1);
    hold on
end
% plot axis vectors:
arrow([0,-k*0.3], [0, k*2.3], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k*1.4,0], [k*1.4, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

text(-1.5, 2*k-0.2, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k*1.2, -1.8, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)

% plot center of sphere
hold on
text(-3, k, '$k$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)

xlim([-k-0.5*k, k+0.5*k])
ylim([0-0.5*k, 2*k+0.5*k])
if i==1
    title('(b) Reflection mode', 'fontweight', 'normal','FontSize', 10)
end
axis image
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])


end
set(gcf,'color','w')
exportgraphics(fig,'ODT.png','Resolution',300)
exportgraphics(fig,'ODT.eps')