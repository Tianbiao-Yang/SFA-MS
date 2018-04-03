load LCMS
max_shift=90;
AMWFA_NPC=1;
AMWFA_wz=5;
phi=6;
l=10;
lambda=10e9; 
valve=0.84;
s=x2;t=y2;
x=x1;y=y1;
[s,ssb]=airPLS(s, lambda,2,0.05);
[x,xxb3]=airPLS(x, lambda,2,0.05);
[xf,peaks,CoCee,shiftvaluee] = SFAMS(s,t,x,y,phi,max_shift,valve,AMWFA_wz,l);
[s,xln]=wavelet_denoising(s,l,6,'soft');
[x,ln]=wavelet_denoising(x,l,6,'soft');
[xf,sln]=wavelet_denoising(xf,l,6,'soft');
corrcoef(x,s)
corrcoef(xf,s)
figure
subplot(2,1,1)
plot(x+0.15*max(s),'k')
hold on
plot(s-0.2*max(s),'r')
legend('Before aligned','reference')
ylabel('Intensity')
axis([0 5098 -1500000 8000000])
subplot(2,1,2)
plot(xf+0.25*max(s),'k')
hold on
plot(s-0.2*max(s),'r')
legend('After aligned','reference')
xlabel('Time(dots)')
ylabel('Intensity')
axis([0 5098 -1500000 8000000])