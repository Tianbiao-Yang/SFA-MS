load rat
phi=6;                                             %�Է�ֵ����ȼ�⣺
l=6;                                                %DWT��ˮƽ
lambda=10e4; 
valve=0.9;
AMWFA_NPC=1; 
AMWFA_wz=3;
max_shift=80;
%%����rat����
[sd,ssd]=airPLS(ratx26, lambda,2,0.05);
[xd1,xxd1]=airPLS(ratx49, lambda,2,0.05);
[xd,peaks1d,CoCe1d,shiftvalue1d] = SFAMS(sd,raty26,xd1,raty49,phi,max_shift,valve,AMWFA_wz,l);
corrcoef(xd,sd)
%%rat���ݽ��ͼ
figure
plot(xd1,'g')
hold on
plot(xd+0.05*max(sd),'r')%
plot(sd+0.1*max(sd),'k')
legend('Before aligned','After aligned','reference')
xlabel('Time(secend)')
ylabel('Intensity')
title('����SFAMS�㷨У׼rat���ݽ��')