% PlotComparisonGraphs.m
% Plot and save the figures.

close all;

%% Variable extraction

% Commont terms between the simulations
t = out_baseline.p.time';
pr = out_baseline.pr.signals.values(:,:);
yaw_ref = out_baseline.yawr.signals.values(:,:)';
Fe_E = out_DOBC.Fe_E.signals.values(:,:);
Me_B = out_DOBC.Me_B.signals.values(:,:);

% Baseline controller specific variables 
p_baseline = out_baseline.p.signals.values(:,:);
rpy_baseline = out_baseline.rpy.signals.values(:,:);
r_baseline = out_baseline.r.signals.values(:,:);

% DOBC controller specific variables 
p_DOBC = out_DOBC.p.signals.values(:,:);
rpy_DOBC = out_DOBC.rpy.signals.values(:,:);
r_DOBC = out_DOBC.r.signals.values(:,:);
Fe_E_hat_DOBC = out_DOBC.Fe_E_hat.signals.values(:,:);
Me_B_hat_DOBC = out_DOBC.Me_B_hat.signals.values(:,:);

%% MISC

% Some colors
dkred = "#A2142F";
dkblue = "#0072BD";
dkgreen = "#77AC30";
orange = "#EDB120";

% Some labels
baselinelabel = "Baseline";
DOBClabel = "Composite";
referencelabel = "Reference";

%% 3D Plot
fig_3D = figure;
    plot3(p_baseline(1,:),p_baseline(2,:),p_baseline(3,:),'LineWidth',1,'Color','black'); hold on; 
    plot3(p_DOBC(1,:),p_DOBC(2,:),p_DOBC(3,:),'LineWidth',1,'Color','blue'); hold on;
    plot3(pr(1,:),pr(2,:),pr(3,:),'LineWidth',1,'Color','red'); hold on;
    grid on;
    xlabel('$x$ [m]','Interpreter','latex')
    ylabel('$y$ [m]','Interpreter','latex')
    zlabel('$z$ [m]','Interpreter','latex')
    legend(baselinelabel,DOBClabel,referencelabel,'interpreter','latex','Location','northeast');     % 'Location','eastoutside'
set(gca,'FontSize',12)
set(gcf,'position',[10,10,510,410])                                
set(gcf,'color','w');
set(gca, 'ZDir', 'reverse')
view([-37.5840,13.2925]);
exportgraphics(fig_3D,'Figures\Comparison_3D.pdf','ContentType','vector')

%% Tracking on position
fig_outer3 = figure;
layout_outer = tiledlayout(3,1);
nexttile;
    plot(t,p_baseline(1,:),'LineWidth',1,'Color','k'); hold on;
    plot(t,p_DOBC(1,:),'LineWidth',1,'Color','blue'); hold on;
    plot(t,pr(1,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on; 
    % xlabel('$t [s]$','Interpreter','latex')
    xticklabels([])
    ylabel('$x$ $[m]$','Interpreter','latex')
    lgd = legend(baselinelabel,DOBClabel,referencelabel,'interpreter','latex','Location','southeast');
    lgd.NumColumns = 3;
    xlim([0,Tfin]);
    set(gca,'FontSize',12)
    grid on;
nexttile;
    plot(t,p_baseline(2,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,p_DOBC(2,:),'LineWidth',1,'Color','blue'); hold on;
    plot(t,pr(2,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on;
    % xlabel('$t [s]$','Interpreter','latex')
    xticklabels([])
    ylabel('$y$ $[m]$','Interpreter','latex')
    lgd = legend(baselinelabel,DOBClabel,referencelabel,'interpreter','latex','Location','southeast');
    lgd.NumColumns = 3;
    xlim([0,Tfin]);
    set(gca,'FontSize',12)
    grid on;
nexttile;
    plot(t,p_baseline(3,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,p_DOBC(3,:),'LineWidth',1,'Color','blue'); hold on;
    plot(t,pr(3,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on;
    xlabel('$t$ $[s]$','Interpreter','latex')
    ylabel('$z$ $[m]$','Interpreter','latex')
    llgd = legend(baselinelabel,DOBClabel,referencelabel,'interpreter','latex','Location','southeast');
    lgd.NumColumns = 3;
    xlim([0,Tfin]);
    set(gca,'FontSize',12)
    grid on;
set(gcf,'position',[10,10,560,400])                                   
set(gcf,'color','w');
layout_outer.TileSpacing = 'tight';
layout_outer.Padding='compact';
exportgraphics(fig_outer3,'Figures\Comparison_TrackingPosition.pdf')

%% Tracking on Yaw angle
fig_inner3 = figure;
    plot(t,rpy_baseline(3,:),'LineWidth',1,'Color','k'); hold on; 
    plot(t,rpy_DOBC(3,:),'LineWidth',1,'Color','blue'); hold on; 
    plot(t,yaw_ref(1,:),'LineWidth',1,'Color','red','LineStyle','-'); hold on; 
    grid on;
    xlim([0,Tfin]);
    xlabel('$t$ $[s]$','Interpreter','latex')
    ylabel('$\psi$ $[rad]$','Interpreter','latex')
    lgd = legend(baselinelabel,DOBClabel,referencelabel,'interpreter','latex','Location','southeast');
    lgd.NumColumns = 3;
set(gca,'FontSize',12)
set(gcf,'position',[10,10,560,200])                                   
set(gcf,'color','w');
exportgraphics(fig_inner3,'Figures\Comparison_TrackingYaw.pdf')

%% Residuals
if false
    r_baseline_norm = sqrt(sum(r_baseline.^2));
    r_DOBC_norm = sqrt(sum(r_DOBC.^2));
    fig_residual = figure;
        plot(t,r_baseline_norm(1,:),'LineWidth',1); hold on; 
        plot(t,r_DOBC_norm(1,:),'LineWidth',1); hold on; 
        grid on;
        xlim([0,Tfin]);
        xlabel('$t$ $[s]$','Interpreter','latex')
        ylabel('Residual','Interpreter','latex')
        lgd = legend(baselinelabel,DOBClabel,'interpreter','latex','Location','southeast');
        lgd.NumColumns = 3;
    set(gca,'FontSize',12)
    set(gcf,'position',[10,10,560,200])                                   
    set(gcf,'color','w');
    exportgraphics(fig_residual,'Figures\Comparison_Residual.pdf')
end

%% NDO - Force observer (3 plots)
fig_force3 = figure;
layout_outer = tiledlayout(3,1);
nexttile;
    plot(t,Fe_E_hat_DOBC(1,:),'LineWidth',1,'Color','k','LineStyle','-'); hold on; 
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
    plot(t,Fe_E_hat_DOBC(2,:),'LineWidth',1,'Color','k','LineStyle','-'); hold on; 
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
    plot(t,Fe_E_hat_DOBC(3,:),'LineWidth',1,'Color','k','LineStyle','-'); hold on; 
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
exportgraphics(fig_force3,'Figures\Comparison_NDO_force_3plots.pdf')

%% NDO - Torque observer (3 plots)
fig_torque3 = figure;
layout_outer = tiledlayout(3,1);
nexttile;
    plot(t,Me_B_hat_DOBC(1,:),'LineWidth',1,'Color','k'); hold on; 
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
    plot(t,Me_B_hat_DOBC(2,:),'LineWidth',1,'Color','k'); hold on; 
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
    plot(t,Me_B_hat_DOBC(3,:),'LineWidth',1,'Color','k'); hold on; 
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
exportgraphics(fig_torque3,'Figures\Comparison_NDO_torque_3plots.pdf')