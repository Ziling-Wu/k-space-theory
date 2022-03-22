%% info
% This script generates Fig. 3 of our paper: 
% Ziling Wu and George Barbastathis "Universal K-space theory of 
% three-dimensional Optical Microscopy"
% for reflection Holography
% under normal and oblique illumination conditions
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


circle_arc = @(r0, gama_arc,radius) [radius*cos(gama_arc)+r0(1); radius*sin(gama_arc)+r0(2)];
%
fig = figure('units', 'inches', 'position', [4, 4, 6.4, 4]);
NA_all = [0.4,0.8];
for i = 1:2
    NA = NA_all(i);
h1 = subaxis(2, 4, (i-1)*4+1, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);
% plot Ewald sphere:
c = circle([0, 0], k);
plot(c(1,:), c(2,:), 'color',[0.5 0.5 0.5])
ylabel(['NA = ', num2str(NA)])
hold on
gama_arc = linspace(pi/2-theta_0, pi/2,  20);
c = circle_arc([0, 0], gama_arc,4);
plot(c(1,:), c(2,:), 'color',[0.5 0.5 0.5])
hold on
text(c(1,10)+0.3 ,c(2,10)+0.8, '$\theta$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
% plot axis vectors:
arrow([0,-k*1.2], [0, k*1.2], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k*1.2,0], [k*1.2, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])
text(-1.2, k-0.2, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k, -1, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)

hold on
% plot incident wave vector:
arrow([0, 0], [0, -k], 'length', 4,'tipangle', 35, 'width', .5, 'color', [255 192 0]/255)
text(-2, -k+2, '$k_{in}$', 'interpreter', 'latex', 'horizontalalignment', 'left')
% plot scattered wave vector:

arrow([0, 0], [k*sin(theta_0), k*cos(theta_0)], 'length', 4,'tipangle', 35, 'width', .5, 'color', [0 112 192]/255)
text((k)*sin(theta_0)-3.5,k*cos(theta_0)-2, '$k_{d}$', 'interpreter', 'latex', 'horizontalalignment', 'left')
% plot sample wave vector:
arrow([0, -k], [k*sin(theta_0), k*cos(theta_0)], 'length', 4,'tipangle', 35, 'width', .5, 'color', [255 0 0]/255)
text((k)*sin(theta_0-pi/9)+3,-2, '$k_{s}$', 'interpreter', 'latex', 'horizontalalignment', 'left')
hold on
% plot lines corresponding to NA:
x = ones(512,1)*k*NA;
y = linspace(-k,k,512);
plot(x, y, '--','color',[0.5 0.5 0.5])
plot(-x, y, '--','color',[0.5 0.5 0.5])
hold on
text( k*NA+0.4,1, 'kNA', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize', 8)
xlim([-k-0.6*k, k+0.6*k])
ylim([0-0.6*k, 2*k+0.6*k])
if i==1
    title('(a) Normal incidence', 'fontweight', 'normal','FontSize', 10)
end
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])
axis image



%
h2 = subaxis(2, 4, (i-1)*4+2, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);
theta = linspace(-asin(NA),asin(NA),256);
k_s_x = k.*sin(theta);
k_s_y = k.*cos(theta)+k;
c = circle([0, k], k);
% plot k-space sphere
plot(c(1,:), c(2,:), '--','color',[0.5 0.5 0.5],'LineWidth',0.1)

hold on
% plot center of the sphere
scatter(0, k,20,'filled','MarkerFaceColor',[0.4,0.4,0.4])
hold on
plot(k_s_x,k_s_y,'LineWidth',1.5,'color','r');axis image
axis image
grid on
% plot axis vectors:
arrow([0,-k*0.2], [0, k*2.2], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k*1.2,0], [k*1.2, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])
text(-1.5, 2*k-0.2, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k, -1.5, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
hold on
text(-3, k, '$k$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
xlim([-k-0.6*k, k+0.6*k])
ylim([0-0.6*k, 2*k+0.6*k])
if i==1
    title('(b) Transfer function', 'fontweight', 'normal','FontSize', 10)
end
axis image
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])



h3 = subaxis(2, 4, (i-1)*4+3, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);
% plot Ewald sphere:

c = circle([0, 0], k);
plot(c(1,:), c(2,:), 'color',[0.5 0.5 0.5])
hold on
gama_arc = linspace(pi/2-theta_0, pi/2,  20);
c = circle_arc([0, 0], gama_arc,4);
plot(c(1,:), c(2,:), 'color',[0.5 0.5 0.5])
hold on
text(c(1,10)+0.3 ,c(2,10)+0.8, '$\theta$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)

gama_arc = linspace(3*pi/2+alpha,3*pi/2, 20);
c = circle_arc([0, 0], gama_arc,5);
plot(c(1,:), c(2,:), 'color',[0.5 0.5 0.5])
hold on
text(c(1,10) ,c(2,10)-3, '$\alpha$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)

% plot axis vectors:
arrow([0,-k*1.2], [0, k*1.2], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k*1.2,0], [k*1.2, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])
text(-1.2, k-0.2, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k, -1, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)

hold on
% plot incident wave vector:

arrow([0, 0], [k*sin(alpha), -k*cos(alpha)], 'length', 4,'tipangle', 35, 'width', .5, 'color', [255 192 0]/255)
text(-6, -k+5, '$k_{in}$', 'interpreter', 'latex', 'horizontalalignment', 'left')
% plot scattered wave vector:

arrow([0, 0], [k*sin(theta_0), k*cos(theta_0)], 'length', 4,'tipangle', 35, 'width', .5, 'color', [0 112 192]/255)
text((k)*sin(theta_0)-3.5,k*cos(theta_0)-2, '$k_{d}$', 'interpreter', 'latex', 'horizontalalignment', 'left')
% plot sample wave vector:
arrow([k*sin(alpha), -k*cos(alpha)], [k*sin(theta_0), k*cos(theta_0)], 'length', 4,'tipangle', 35, 'width', .5, 'color', [255 0 0]/255)
text((k)*sin(theta_0-pi/9)+3,-2, '$k_{s}$', 'interpreter', 'latex', 'horizontalalignment', 'left')
hold on
% plot lines corresponding to NA:
x = ones(512,1)*k*NA;
y = linspace(-k,k,512);
plot(x, y, '--','color',[0.5 0.5 0.5])
plot(-x, y, '--','color',[0.5 0.5 0.5])
hold on
text( k*NA+0.4,1, 'kNA', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize', 8)
xlim([-k-0.6*k, k+0.6*k])
ylim([0-0.6*k, 2*k+0.6*k])
if i==1
    title('(c) Oblique incidence', 'fontweight', 'normal','FontSize', 10)
end
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])
axis image



%
h4 = subaxis(2, 4, (i-1)*4+4, 'pad', 0, 'margin', .05, 'sh', .01, 'sv', .01);
k_s_x = k.*sin(theta)-k*sin(alpha);
k_s_y = k.*cos(theta)+k*cos(alpha);
c = circle([0, k], k);
% plot k-space sphere
plot(c(1,:), c(2,:), '--','color',[0.5 0.5 0.5],'LineWidth',0.1)
hold on
plot(k_s_x,k_s_y,'LineWidth',2);axis image
c = circle([0, k], k);
% plot k-space sphere
plot(c(1,:), c(2,:), '--','color',[0.5 0.5 0.5],'LineWidth',0.1)

hold on
% plot center of the sphere
scatter(0, k,20,'filled','MarkerFaceColor',[0.4,0.4,0.4])
hold on
plot(k_s_x,k_s_y,'LineWidth',1.5,'color','r');axis image
axis image
grid on
% plot axis vectors:
arrow([0,-k*0.2], [0, k*2.2], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])

arrow([-k*1.2,0], [k*1.2, 0], 'length', 3,'tipangle', 30, 'width', .2, 'color', [.4, .4, .4])
text(-1.5, 2*k-0.2, '$k_z$', 'interpreter', 'latex', 'verticalalignment', ...
    'bottom', 'horizontalalignment', 'center','FontSize',9)
text(k, -1.5, '$k_x$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
hold on
text(-3, k, '$k$', 'interpreter', 'latex', 'horizontalalignment', 'left','FontSize',9)
xlim([-k-0.6*k, k+0.6*k])
ylim([0-0.6*k, 2*k+0.6*k])
if i==1
    title('(d) Transfer function', 'fontweight', 'normal','FontSize', 10)
end
axis image
set(gca, 'ydir', 'normal', 'xtick', [], 'ytick', [])
end
set(gcf,'color','w')
exportgraphics(fig,'RefHolo.png','Resolution',300)
exportgraphics(fig,'RefHolo.eps')