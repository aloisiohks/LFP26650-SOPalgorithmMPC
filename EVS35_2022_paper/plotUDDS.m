%% Plot Discharge SOP within the power prediction interval 
clear all;
close all;
clc;




name = 'UDDS';

data0 = load('SOP_UDDS_1e6.mat');
data1 = load('SOP_UDDS_1e7.mat');
data2 = load('SOP_UDDS_1e8.mat');
data3 = load('SOP_UDDS_1e9.mat');
data4 = load('SOP_UDDS_adap.mat');

saveFig = 1;

flagPlot = 1;    % 0 -> Discharge      1 -> Charge


tk=400; % discharge
% tk = 1200;


tk=1100;  % charge  chosen


colors = {[0, 0.4470, 0.7410];...
    [0.8500, 0.3250, 0.0980];...
    [0.9290, 0.6940, 0.1250];...
    [0.4660, 0.6740, 0.1880];...
    [0.4940, 0.1840, 0.5560]};

figure()
% Discharge
plot(data0.P_MPC_Dis,'Color',colors{1});hold on;
plot(data1.P_MPC_Dis,'Color',colors{2});hold on;
plot(data2.P_MPC_Dis,'Color',colors{3});hold on;
plot(data3.P_MPC_Dis,'Color',colors{4});hold on;
plot(data4.P_MPC_Dis,'Color',colors{5});hold on;

plot(data0.P_MPC_Chg,'--','Color',colors{1});hold on;
plot(data1.P_MPC_Chg,'--','Color',colors{2});hold on;
plot(data2.P_MPC_Chg,'--','Color',colors{3});hold on;
plot(data3.P_MPC_Chg,'--','Color',colors{4});hold on;
plot(data4.P_MPC_Chg,'--','Color',colors{5});hold on;
legend('SMPC1','SMPC2','SMPC3','SMPC4','SAMPC',...
    'location','best','NumColumns',4,'FontSize',12,'Location','SouthWest')
grid on;
ylabel('Power (W)'); xlabel('Time (s)'); xlim([data1.time(1) data1.time(end)]);
thesisFormat;
if saveFig, saveas(gcf,sprintf('./figures/SOP_UDDS'),'epsc'); end

if flagPlot==0

    tp = 1:10;
    figure()
    plot(tp,data0.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]); 
    ylabel('Current (A)'); 
    xlabel(['Prediction interval'])
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_DIS_%s_%d_I',name,tk),'epsc'); end



    figure()
    plot(tp,data0.V_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.V_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.V_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.V_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.V_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('Voltage (V)')
    xlabel(['Prediction interval']); 
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_DIS_%s_%d_V',name,tk),'epsc'); end

    figure()
    plot(tp,data0.X_MPC_Dis(4,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.X_MPC_Dis(4,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.X_MPC_Dis(4,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.X_MPC_Dis(4,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.X_MPC_Dis(4,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('Temperature (\circC)')
    xlabel(['Prediction interval']); 
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_DIS_%s_%d_Tc',name,tk),'epsc'); end



% 
    figure
    plot(tp,data0.X_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.X_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.X_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.X_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.X_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('SOC (%)')
    xlabel(['Prediction interval']);
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_DIS_%s_%d_SOC',name,tk),'epsc'); end

    figure()
    plot(tp,data0.V_MPC_Dis(1,2:end,tk).*data1.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.V_MPC_Dis(1,2:end,tk).*data1.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.V_MPC_Dis(1,2:end,tk).*data2.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.V_MPC_Dis(1,2:end,tk).*data3.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.V_MPC_Dis(1,2:end,tk).*data4.I_MPC_Dis(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});
    grid on;xlim([1 tp(end)]);ylabel('Inst. Power (W)')
    xlabel(['Prediction interval']); 
    set(gcf,'position',[400,400,226,196]); 
    paperSmallFormat;
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    if saveFig, saveas(gcf,sprintf('./figures/SOP_DIS_%s_%d_instPower',name,tk),'epsc'); end

    figure()
    plot(tp,data4.Ru_MPC_Dis(tk,2:end),'-o','linewidth',2,'color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('{\it r_{adap}}')
    xlabel(['Prediction interval']);
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    if saveFig, saveas(gcf,sprintf('./figures/SOP_DIS_%s_%d_Rwadap',name,tk),'epsc'); end

elseif flagPlot == 1


    tp = 1:10;
    figure()
    plot(tp,data0.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]); 
    ylabel('Current (A)'); 
    xlabel(['Prediction interval'])
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_CHG_%s_%d_I',name,tk),'epsc'); end



    figure()
    plot(tp,data0.V_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.V_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.V_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.V_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.V_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('Voltage (V)')
    xlabel(['Prediction interval']); 
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_CHG_%s_%d_V',name,tk),'epsc'); end

    figure()
    plot(tp,data0.X_MPC_Chg(4,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.X_MPC_Chg(4,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.X_MPC_Chg(4,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.X_MPC_Chg(4,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.X_MPC_Chg(4,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('Temperature (\circC)')
    xlabel(['Prediction interval']); 
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_CHG_%s_%d_Tc',name,tk),'epsc'); end



% 
    figure
    plot(tp,data0.X_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.X_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.X_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.X_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.X_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('SOC (%)')
    xlabel(['Prediction interval']);
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    if saveFig, saveas(gcf,sprintf('./figures/SOP_CHG_%s_%d_SOC',name,tk),'epsc'); end

    figure()
    plot(tp,data0.V_MPC_Chg(1,2:end,tk).*data1.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{1});hold on;
    plot(tp,data1.V_MPC_Chg(1,2:end,tk).*data1.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{2});hold on;
    plot(tp,data2.V_MPC_Chg(1,2:end,tk).*data2.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{3});hold on;
    plot(tp,data3.V_MPC_Chg(1,2:end,tk).*data3.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{4});hold on;
    plot(tp,data4.V_MPC_Chg(1,2:end,tk).*data4.I_MPC_Chg(1,2:end,tk),'-o','linewidth',2,'Color',colors{5});
    grid on;xlim([1 tp(end)]);ylabel('Inst. Power (W)')
    xlabel(['Prediction interval']); 
    set(gcf,'position',[400,400,226,196]); 
    paperSmallFormat;
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    if saveFig, saveas(gcf,sprintf('./figures/SOP_CHG_%s_%d_instPower',name,tk),'epsc'); end

    figure()
    plot(tp,data4.Ru_MPC_Chg(tk,2:end),'-o','linewidth',2,'color',colors{5});hold on;
    grid on;xlim([1 tp(end)]);ylabel('{\it r_{adap}}')
    xlabel(['Prediction interval']);
    set(gcf,'position',[400,400,226,196]);  
    paperSmallFormat;
    set(get(gca,'XLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    set(get(gca,'YLabel'),'FontSize',15,'FontName','Times','FontWeight','normal');
    if saveFig, saveas(gcf,sprintf('./figures/SOP_CHG_%s_%d_Rwadap',name,tk),'epsc'); end


end

