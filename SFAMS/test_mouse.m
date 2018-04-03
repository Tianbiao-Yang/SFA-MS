load mouse
max_shift=50;
AMWFA_NPC=1;
AMWFA_wz=3;
phi=10;                                             %对峰值信噪比检测：
l=10;                                                %DWT的水平
lambda=10e4; 
valve=0.9;
s=d1;t=c1;
xf2=d2;y2=c2;
[sf,ssf]=airPLS(s, lambda,2,0.05);
[x2,xxf2]=airPLS(xf2, lambda,2,0.05);
[d3,xxf3]=airPLS(d3, lambda,2,0.05);
[d4,xxf4]=airPLS(d4, lambda,2,0.05);
[d5,xxf5]=airPLS(d5, lambda,2,0.05);
[d6,xxf6]=airPLS(d6, lambda,2,0.05);
[d7,xxf7]=airPLS(d7, lambda,2,0.05);
[d7,xxf7]=airPLS(d7, lambda,2,0.05);
%%mouse(其中xn是最后的结果)
[xn2,peaks1n,CoCe1n,shiftvalue1n] = SFAMS(sf,t,x2,y2,phi,30,valve,AMWFA_wz,l);
[xn3,peaks2n,CoCe2n,shiftvalue2n] = SFAMS(sf,t,d3,c3,30,50,valve,AMWFA_wz,l);
[xn4,peaks3n,CoCe3n,shiftvalue3n] = SFAMS(sf,t,d4,c4,phi,35,valve,AMWFA_wz,l);
[xn5,peaks4n,CoCe4n,shiftvalue4n] = SFAMS(sf,t,d5,c5,10,35,valve,AMWFA_wz,l);
[xn6,peaks5n,CoCe5n,shiftvalue5n] = SFAMS(sf,t,d6,c6,10,11,valve,AMWFA_wz,l);
[xn7,peaks6n,CoCe6n,shiftvalue6n] = SFAMS(sf,t,d7,c7,phi,32,valve,AMWFA_wz,l);
[xn8,peaks7n,CoCe7n,shiftvalue7n] = SFAMS(sf,t,d8,c8,phi,15,valve,AMWFA_wz,l);
corrcoef(xn2,sf)
corrcoef(xn3,sf)
corrcoef(xn4,sf)
corrcoef(xn5,sf)
corrcoef(xn6,sf)
corrcoef(xn7,sf)
corrcoef(xn8,sf)
%%mouse数据结果图
figure
plot(s,'k')
hold on
plot(xn2,'k')%
plot(xn3,'k')
plot(xn4,'k')%
plot(xn5,'k')
plot(xn6,'k')
plot(xn7,'k')
plot(xn8,'k')%
legend('参考谱','校准谱1','校准谱2','校准谱3','校准谱4','校准谱5','校准谱6','校准谱7')
xlabel('Time(secend)')
ylabel('Intensity')
title('利用SFAMS算法校准mouse数据结果')