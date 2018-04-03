load Data247
load Data260
phi=20;                                              
l=6;                                                
lambda=10e4;
valve=0.9;
max_shift=20;
AMWFA_NPC=1;
AMWFA_wz=3;
[sa,ssa]=airPLS(Data260.TIC, lambda,2,0.05);
[xa,xxa]=airPLS(Data247.TIC, lambda,2,0.05);
% 运行模拟数据集
[xo,peaks1o,CoCe1o,shiftvalue1o] = SFAMS(sa,Data260.MZ,xa,Data247.MZ,phi,max_shift,valve,AMWFA_wz,l);
corrcoef(xo,sa)
% 模拟数据结果图
figure
plot(xa,'g')
hold on
plot(xo+0.05*max(sa),'r')%
plot(sa+0.1*max(sa),'k')
legend('Before aligned','After aligned','reference')
xlabel('Time(secend)')
ylabel('Intensity')
title('利用SFAMS算法校准模拟数据结果')