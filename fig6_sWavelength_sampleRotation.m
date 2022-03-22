%% info
% This script generates Fig. 7 of our paper:
% Ziling Wu and George Barbastathis "Universal K-space theory of 
% three-dimensional Optical Microscopy"
% for holography with sample rotation 
% under transmission and reflection modes
% This code requires the subaxis.m and arrow.m files from MathWorks File
% Exchange.


%%
clearvars
lambda = 0.532;

k = 2*pi./lambda;

gama = linspace(0, 2*pi, 1000);
circle = @(r0, radius) [radius*cos(gama)+r0(1); radius*sin(gama)+r0(2)];
%
fig = figure('units', 'inches', 'position', [4, 4, 6.4, 4]);
NA_all = [0.3,0.6];

for i = 1:2
    NA = NA_all(i);
    theta = linspace(-asin(NA),asin(NA),256);
    alpha = linspace(-asin(NA),asin(NA),30);

%
h1 = subaxis(2, 2, (i-1)*2+1, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);
k_max = max(k);



c = circle([0, k_max], k_max);
% plot k-space sphere
plot(c(1,:), c(2,:), '--','color',[0.5 0.5 0.5],'LineWidth',0.1)
hold on
beta = linspace(-pi,pi,50);
k_s_x = k.*sin(alpha);
k_s_y = -k.*cos(alpha)+k;
for idx = 1:length(beta)
    beta_tmp = beta(idx);
    kx_r = k_s_x.*cos(beta_tmp)-k_s_y.*sin(beta_tmp);
    ky_r = k_s_x.*sin(beta_tmp)+k_s_y.*cos(beta_tmp);
    plot(kx_r,ky_r,'LineWidth',1.5)
    hold on
end
ylabel(['NA = ', num2str(NA)])

% plot axis vectors:
arrow([0,-k_max*2.5], [0, k_max*2.5], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k_max*2.5,0], [k_max*2.5, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

text(-2, 2*k_max, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k_max*2.2, -1.8, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)

% plot center of the sphere
scatter(0, k_max,10,'filled','MarkerFaceColor',[0.4,0.4,0.4])
% plot center of sphere
hold on
text(-4, k_max, '$k$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
if i==1
    title('(a) Transmission mode', 'fontweight', 'normal','FontSize', 10)
end
xlim([-k_max-1.2*k_max, k_max+1.2*k_max])
ylim([0-1*k_max, 2*k_max+1*k_max])

axis image
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])



h2 = subaxis(2, 2, (i-1)*2+2, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);
c = circle([0, k_max], k_max);
% plot k-space sphere
plot(c(1,:), c(2,:), '--','color',[0.5 0.5 0.5],'LineWidth',0.1)
hold on
k_s_x = k.*sin(alpha);
k_s_y = k.*cos(alpha)+k;
for idx = 1:length(beta)
    beta_tmp = beta(idx);
    kx_r = k_s_x.*cos(beta_tmp)-k_s_y.*sin(beta_tmp);
    ky_r = k_s_x.*sin(beta_tmp)+k_s_y.*cos(beta_tmp);
    plot(kx_r,ky_r,'LineWidth',1.5)
    hold on
end
% plot axis vectors:
arrow([0,-k_max*2.5], [0, k_max*2.5], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k_max*2.5,0], [k_max*2.5, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

text(-2, 2*k_max, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k_max*2.2, -1.8, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
% plot center of the sphere
scatter(0, k_max,10,'filled','MarkerFaceColor',[0.4,0.4,0.4])
% plot center of sphere
hold on
text(-4, k_max, '$k$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)

xlim([-k_max-1.2*k_max, k_max+1.2*k_max])
ylim([0-1*k_max, 2*k_max+1*k_max])
if i==1
    title('(b) Rlection mode', 'fontweight', 'normal','FontSize', 10)
end
axis image
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])


end
set(gcf,'color','w')
exportgraphics(fig,'sWavelength_SR.png','Resolution',300)
exportgraphics(fig,'sWavelength_SR.eps')