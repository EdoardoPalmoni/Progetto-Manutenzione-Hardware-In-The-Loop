% PlotGraphs.m
% Plot and save the figures.

close all;

%% Plot results and save images
t = out.p.time';
p = out.p.signals.values(:,:);
pdot = out.pdot.signals.values(:,:);
vdot = out.vdot.signals.values(:,:);
omega = out.omega.signals.values(:,:);
omegadot = out.omegadot.signals.values(:,:);
R = out.R.signals.values;
rpy = out.rpy.signals.values(:,:);
pr = out.pr.signals.values(:,:);
yaw_ref = out.yawr.signals.values(:,:)';
u = out.u.signals.values(:,:)';
Fe_E = out.Fe_E.signals.values(:,:);
Me_B = out.Me_B.signals.values(:,:);
Fe_E_hat = out.Fe_E_hat.signals.values(:,:);
Me_B_hat = out.Me_B_hat.signals.values(:,:);
r = out.r.signals.values(:,:);

dkred = "#A2142F";
dkblue = "#0072BD";
dkgreen = "#77AC30";
orange = "#EDB120";

%% 3D Plot
fig_3D = figure;
plot3(p(1,:),p(2,:),p(3,:),'LineWidth',1,'Color','black'); hold on; 
plot3(pr(1,:),pr(2,:),pr(3,:),'LineWidth',1,'Color','red'); hold on; 
xlabel('$x$ [m]','Interpreter','latex')
ylabel('$y$ [m]','Interpreter','latex')
zlabel('$z$ [m]','Interpreter','latex')
legend('$p$','$p_r$','interpreter','latex','Location','northeast');     % 'Location','eastoutside'
set(gca,'FontSize',12)
grid on;
set(gcf,'position',[10,10,510,410])                                
set(gcf,'color','w');
set(gca, 'ZDir', 'reverse')
view([-37.5840,13.2925]);
exportgraphics(fig_3D,'Figures\3D.pdf')

%% Tracking on position
fig_outer3 = figure;
layout_outer = tiledlayout(3,1);
nexttile;
    plot(t,p(1,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,pr(1,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on; 
    % xlabel('$t [s]$','Interpreter','latex')
    xticklabels([])
    ylabel('$[m]$','Interpreter','latex')
    lgd = legend('$x$','$x_r$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    xlim([0,Tfin]);
    set(gca,'FontSize',12)
    grid on;
nexttile;
    plot(t,p(2,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,pr(2,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on;
    % xlabel('$t [s]$','Interpreter','latex')
    xticklabels([])
    ylabel('$[m]$','Interpreter','latex')
    lgd = legend('$y$','$y_{r}$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    xlim([0,Tfin]);
    set(gca,'FontSize',12)
    grid on;
nexttile;
    plot(t,p(3,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,pr(3,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on;
    xlabel('$t$ $[s]$','Interpreter','latex')
    ylabel('$[m]$','Interpreter','latex')
    lgd = legend('$z$','$z_r$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    xlim([0,Tfin]);
    set(gca,'FontSize',12)
    grid on;
set(gcf,'position',[10,10,560,400])                                   
set(gcf,'color','w');
layout_outer.TileSpacing = 'tight';
layout_outer.Padding='compact';
exportgraphics(fig_outer3,'Figures\TrackingPosition.pdf')

%% Tracking on Yaw angle
fig_inner3 = figure;
plot(t,rpy(3,:),'LineWidth',1,'Color','k'); hold on; 
plot(t,yaw_ref(1,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on; 
xlabel('$t$ $[s]$','Interpreter','latex')
ylabel('$[rad]$','Interpreter','latex')
lgd = legend('$\psi$','$\psi_r$','interpreter','latex','Location','southeast');
lgd.NumColumns = 2;
xlim([0,Tfin]);
set(gca,'FontSize',12)
grid on;
set(gcf,'position',[10,10,560,200])                                   
set(gcf,'color','w');
exportgraphics(fig_inner3,'Figures\TrackingYaw.pdf')

%% Control input
fig_u = figure;
plot(t,u(1,:),'LineWidth',1); hold on; 
plot(t,u(2,:),'LineWidth',1); hold on; 
plot(t,u(3,:),'LineWidth',1); hold on; 
plot(t,u(4,:),'LineWidth',1); hold on; 
plot(t,u(5,:),'LineWidth',1); hold on; 
plot(t,u(6,:),'LineWidth',1); hold on; 
grid on;
xlim([0,Tfin]);
xlabel('$t$ $[s]$','Interpreter','latex')
ylabel('$[N]$','Interpreter','latex')
% lgd = legend('$u_1$','$u_2$','$u_3$','$u_4$','$u_5$','$u_6$','interpreter','latex','FontSize',14,'Location','eastoutside');
lgd = legend('$u_1$','$u_2$','$u_3$','$u_4$','$u_5$','$u_6$','interpreter','latex','Location','southeast');
lgd.NumColumns = 6;
set(gca,'FontSize',12)
set(gcf,'position',[10,10,560,200])                                   
set(gcf,'color','w');
exportgraphics(fig_u,'Figures\ControlInput.pdf')

%% NDO - Force observer (3 plots)
fig_force3 = figure;
layout_outer = tiledlayout(3,1);
nexttile;
    plot(t,Fe_E_hat(1,:),'LineWidth',1,'Color','k','LineStyle','-'); hold on; 
    plot(t,Fe_E(1,:),'LineWidth',1,'Color','r','LineStyle','-'); hold on; 
    grid on;
    xlim([0,Tfin]);
    xticklabels([])
    % xlabel('$t [s]$','Interpreter','latex')
    ylabel('$[N]$','Interpreter','latex')
    lgd = legend('$\hat{f}_{e,1}^E$','$f_{e,1}^E$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    set(gca,'FontSize',12)
nexttile;
    plot(t,Fe_E_hat(2,:),'LineWidth',1,'Color','k','LineStyle','-'); hold on; 
    plot(t,Fe_E(2,:),'LineWidth',1,'Color','r','LineStyle','-'); hold on; 
    grid on;
    xlim([0,Tfin]);
    xticklabels([])
    % xlabel('$t [s]$','Interpreter','latex')
    ylabel('$[N]$','Interpreter','latex')
    lgd = legend('$\hat{f}_{e,2}^E$','$f_{e,2}^E$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    set(gca,'FontSize',12)
nexttile;
    plot(t,Fe_E_hat(3,:),'LineWidth',1,'Color','k','LineStyle','-'); hold on; 
    plot(t,Fe_E(3,:),'LineWidth',1,'Color','r','LineStyle','-'); hold on; 
    grid on;
    xlim([0,Tfin]);
    xlabel('$t$ $[s]$','Interpreter','latex')
    ylabel('$[N]$','Interpreter','latex')
    lgd = legend('$\hat{f}_{e,3}^E$','$f_{e,3}^E$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    set(gca,'FontSize',12)
set(gcf,'position',[10,10,560,400])                                   
set(gcf,'color','w');
layout_outer.TileSpacing = 'tight';
layout_outer.Padding='compact';
exportgraphics(fig_force3,'Figures\NDO_force_3plots.pdf')

%% NDO - Force observer (1 plot)
fig_NDO_force = figure;                                 
plot(t,Fe_E_hat(1,:),'LineWidth',1,'Color',dkred); hold on; 
plot(t,Fe_E_hat(2,:),'LineWidth',1,'Color',dkgreen); hold on; 
plot(t,Fe_E_hat(3,:),'LineWidth',1,'Color',dkblue); hold on; 
plot(t,Fe_E(1,:),'LineWidth',1,'Color',orange,'LineStyle','-'); hold on;
plot(t,Fe_E(2,:),'LineWidth',1,'Color','g','LineStyle','-'); hold on; 
plot(t,Fe_E(3,:),'LineWidth',1,'Color','cyan','LineStyle','-'); hold on; 
grid on;
xlim([0,Tfin]);
xlabel('$t$ $[s]$','Interpreter','latex','FontSize',14)
ylabel('$[N]$','Interpreter','latex','FontSize',14)
lgd = legend('$\hat{F}_{e,1}$','$\hat{F}_{e,2}$','$\hat{F}_{e,3}$','$F_{e,1}$','$F_{e,2}$','$F_{e,3}$','interpreter','latex','Location','southeast');
lgd.NumColumns = 2;
set(gca,'FontSize',12)
set(gcf,'position',[10,10,560,200])   
set(gcf,'color','w');
exportgraphics(fig_NDO_force,'Figures\NDO_force_1plot.pdf')

%% NDO - Torque observer (3 plots)
fig_torque3 = figure;
layout_outer = tiledlayout(3,1);
nexttile;
    plot(t,Me_B_hat(1,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,Me_B(1,:),'LineWidth',1,'Color','r','LineStyle','-'); hold on; 
    grid on;
    xlim([0,Tfin]);
    xticklabels([])
    % xlabel('$t [s]$','Interpreter','latex')
    ylabel('$[N\cdot m]$','Interpreter','latex')
    lgd = legend('$\hat{\tau}_{e,1}^B$','$\tau_{e,1}^B$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    set(gca,'FontSize',12)
nexttile; 
    plot(t,Me_B_hat(2,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,Me_B(2,:),'LineWidth',1,'Color','r','LineStyle','-'); hold on; 
    grid on;
    xlim([0,Tfin]);
    xticklabels([])
    % xlabel('$t [s]$','Interpreter','latex')
    ylabel('$[N\cdot m]$','Interpreter','latex')
    lgd = legend('$\hat{\tau}_{e,2}^B$','$\tau_{e,2}^B$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    set(gca,'FontSize',12)
nexttile; 
    plot(t,Me_B_hat(3,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,Me_B(3,:),'LineWidth',1,'Color','r','LineStyle','-'); hold on; 
    grid on;
    xlim([0,Tfin]);
    xlabel('$t [s]$','Interpreter','latex')
    ylabel('$[N\cdot m]$','Interpreter','latex')
    lgd = legend('$\hat{\tau}_{e,3}^B$','$\tau_{e,3}^B$','interpreter','latex','Location','southeast');
    lgd.NumColumns = 2;
    set(gca,'FontSize',12)
set(gcf,'position',[10,10,560,400])                                   
set(gcf,'color','w');
layout_outer.TileSpacing = 'tight';
layout_outer.Padding='compact';
exportgraphics(fig_torque3,'Figures\NDO_torque_3plots.pdf')

%% NDO - Torque observer (1 plot)
fig_NDO_torque = figure;
plot(t,Me_B_hat(1,:),'LineWidth',1,'Color','r'); hold on; 
plot(t,Me_B_hat(2,:),'LineWidth',1,'Color','b'); hold on; 
plot(t,Me_B_hat(3,:),'LineWidth',1,'Color','g'); hold on; 
plot(t,Me_B(1,:),'LineWidth',1,'Color',dkred,'LineStyle','-'); hold on;
plot(t,Me_B(2,:),'LineWidth',1,'Color',dkblue,'LineStyle','-'); hold on; 
plot(t,Me_B(3,:),'LineWidth',1,'Color',dkgreen,'LineStyle','-'); hold on; 
grid on;
xlim([0,Tfin]);
xlabel('$t$ $[s]$','Interpreter','latex','FontSize',14)
ylabel('$[N\cdot m]$','Interpreter','latex','FontSize',14)
lgd = legend('$\hat{M}_{l,1}$','$\hat{M}_{l,2}$','$\hat{M}_{l,3}$','$M_{l,1}$','$M_{l,2}$','$M_{l,3}$','interpreter','latex','FontSize',14,'Location','southeast');
lgd.NumColumns = 2;
set(gca,'FontSize',12)
set(gcf,'position',[10,10,560,200])   
set(gcf,'color','w');
exportgraphics(fig_NDO_torque,'Figures\NDO_torque_1plot.pdf')

%% Residual
fig_residual = figure;
set(gcf,'position',[10,10,560,400])                                   
set(gcf,'color','w');
plot(t,r(1,:),'LineWidth',1); hold on; 
plot(t,r(2,:),'LineWidth',1); hold on; 
plot(t,r(3,:),'LineWidth',1); hold on; 
plot(t,r(4,:),'LineWidth',1); hold on; 
xlabel('$t$ $[s]$','Interpreter','latex')
% ylabel('[N$\cdot$ m]','Interpreter','latex','FontSize',14)
lgd = legend('$r_1$','$r_2$','$r_3$','$r_4$','interpreter','latex','FontSize',14,'Location','southeast');
lgd.NumColumns = 4;
xlim([0,Tfin]);
set(gca,'FontSize',12)
grid on;
set(gcf,'position',[10,10,560,200])                                   
set(gcf,'color','w');
exportgraphics(fig_residual,'Figures\Residual.pdf')

%%
% close all;