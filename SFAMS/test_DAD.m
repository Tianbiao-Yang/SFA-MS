load DAD
max_shift=400;
AMWFA_NPC=1;
AMWFA_wz=3;
phi=10e3;                                             %对峰值信噪比检测：
l=10;                                                %DWT的水平
lambda=10e11; 
valve=0.95;
s=DADX10;t=DADY10;
x=DADX45;y=DADY45;
[se,sse]=airPLS(s, lambda,2,0.05);
[xe,xxe1]=airPLS(x, lambda,2,0.05);
%%运行DAD 数据（含重叠峰的数据）
[xf,peakse,CoCee,shiftvaluee] = SFAMS(se,t,xe,y,phi,max_shift,valve,AMWFA_wz,l);
corrcoef(xe,se)
corrcoef(xf,se)
%%DAD数据结果图
figure
plot(xe,'r')
hold on
plot(xf,'b')%
plot(se,'k')
legend('Before aligned','After aligned','reference')
xlabel('Time(secend)')
ylabel('Intensity')
title('利用SFAMS算法校准DAD数据结果')