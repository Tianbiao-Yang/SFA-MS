load DAD
max_shift=400;
AMWFA_NPC=1;
AMWFA_wz=3;
phi=10e3;                                             %�Է�ֵ����ȼ�⣺
l=10;                                                %DWT��ˮƽ
lambda=10e11; 
valve=0.95;
s=DADX10;t=DADY10;
x=DADX45;y=DADY45;
[se,sse]=airPLS(s, lambda,2,0.05);
[xe,xxe1]=airPLS(x, lambda,2,0.05);
%%����DAD ���ݣ����ص�������ݣ�
[xf,peakse,CoCee,shiftvaluee] = SFAMS(se,t,xe,y,phi,max_shift,valve,AMWFA_wz,l);
corrcoef(xe,se)
corrcoef(xf,se)
%%DAD���ݽ��ͼ
figure
plot(xe,'r')
hold on
plot(xf,'b')%
plot(se,'k')
legend('Before aligned','After aligned','reference')
xlabel('Time(secend)')
ylabel('Intensity')
title('����SFAMS�㷨У׼DAD���ݽ��')