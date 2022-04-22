clear all;
close all;
clc;

saveFig = 1;
load('SOP_FSAE_1e6.mat')

xk_pBounds = spkfData.xhat + spkfData.Bounds;
xk_mBounds = spkfData.xhat - spkfData.Bounds;


figure();  
plot(time',100*spkfData.xhat(spkfData.zkInd,1:end-1)); hold on
plot(time',100*(xk_pBounds(spkfData.zkInd,1:end-1)),'--r');hold on
plot(time',100*(xk_mBounds(spkfData.zkInd,1:end-1)),'--r');
% title('SOC estimate');
ylabel('SOC (%)');
legend('Estimate','Bounds'); grid on;xlim([0 time(end)])
set(gcf,'color','w');ylim([0 100]);
xlabel (['Time (s)']);
set(gcf,'color','w');
paperSmallFormat;
if saveFig, saveas(gcf,sprintf('./figures/SOC_SPKF.png'),'epsc'); end




figure();  
plot(time',spkfData.xhat(spkfData.TcInd,2:end)); hold on
plot(time',(xk_pBounds(spkfData.TcInd,2:end)),'--r');hold on
plot(time',(xk_mBounds(spkfData.TcInd,2:end)),'--r');
xlim([time(1),time(end)]);
ylabel ('Temperature ({\circ}C)');
xlabel ('Time (s)');
paperSmallFormat;
if saveFig, saveas(gcf,sprintf('./figures/Temp_SPKF.png'),'epsc'); end



figure();  
plot(time,voltage);
xlabel (['Time (s)']); ylabel('Voltage (V)'); 
xlim([0 time(end)]);
paperSmallFormat;
ax2 = axes('Position',[0.265486725663717,0.291836734693877,0.566371681415929,0.199999999999999]);
box on; 
plot(time(31:93),voltage(31:93)); grid on;
if saveFig, saveas(gcf,sprintf('./figures/voltage_FSAE.png'),'epsc'); end


figure()
plot(time,current);xlabel (['Time (s)']);
ylabel('Current (A)');grid on;
xlim([0 time(end)]);
ylim([-5 40])
% title('Input current profile');
paperSmallFormat;
ax2 = axes('Position',[0.252212389380531,0.689795918367347,0.621238938053097,0.2]);
box on;
plot(time(31:93),current(31:93)); hold on
xlim([31 93]);
grid on;
if saveFig, saveas(gcf,sprintf('./figures/current_FSAE.png'),'epsc'); end


