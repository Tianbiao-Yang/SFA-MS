load Micdata
phi=20;                                              
l=6;                                                
lambda=10e4;
valve=0.9;
max_shift=15;
sc1=a2';tc=b2';
xc1=a3';yc1=b3';
xc2=a4';yc2=b4';
%%����΢�����(����xa�����Ľ��)
[sc,ssc]=airPLS(sc1, lambda,2,0.05);
[xcc1,xxc1]=airPLS(xc1, lambda,2,0.05);
[xcc2,xxc2]=airPLS(xc2, lambda,2,0.05);
[xc1,peaks1c,CoCe1c,shiftvalue1c] = SFAMS(sc,tc,xcc1,yc1,phi,max_shift,valve,3,l);
[xc2,peaks2c,CoCe2c,shiftvalue2c] = SFAMS(sc,tc,xcc2,yc2,phi,max_shift,valve,11,l);
corrcoef(xc1,sc)
corrcoef(xc2,sc)
%%΢��������ݽ��ͼ
figure
plot(sc,'b')
hold on
plot(xc1+0.05*max(sc),'r')%
plot(xc2+0.1*max(sc),'k')
legend('�ο���','У׼��1','У׼��2')
xlabel('Time(secend)')
ylabel('Intensity')
title('����SFAMS�㷨У׼΢��������ݽ��')