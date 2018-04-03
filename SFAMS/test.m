load DATA
phi=6;                                             %对峰值信噪比检测：
l=6;                                                %DWT的水平
lambda=10e4; 
valve=0.9;
AMWFA_NPC=1; 
AMWFA_wz=3;
max_shift=20;
s1=a10(1500:7950,:)';t1=b10(1500:7950,:)';
x3=a17(1500:7950,:)';y3=b17(1500:7950,:)';
[sb,ssb]=airPLS(s1, lambda,2,0.05);
[xb3,xxb3]=airPLS(x3, lambda,2,0.05);
tic
[xch3,peaksch3,CoCech3,shiftvaluech3] = SFAMS(sb,t1,xb3,y3,phi,max_shift,valve,AMWFA_NPC,AMWFA_wz,l);
toc
corrcoef(xch3,sb)
figure
plot(xb3,'g')
hold on
plot(xch3+0.05*max(sb),'r')%
plot(sb+0.1*max(sb),'k')
legend('Before aligned','After aligned','reference')
xlabel('Time(secend)')
ylabel('Intensity')
title('利用SFAMS算法校准模拟数据结果')
