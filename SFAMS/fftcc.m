function [lag,fccc]= fftcc(x,s,shift,hpw)
%% ģ������
if 0
load Data247
load Data260
x=Data247.TIC; %x:��У�׷�(���о���)
s=Data260.TIC; %s:�ο��׷�(���о���)
hpw=5;
shift=50;
end
%% fftcc����
if nargin < 4
hpw=5;
end
n=size(s,2);
shift=max(1,min(n,shift));
S=fft(s);
X=fft(x);
fccc=real(ifft(S.*conj(X)./n));
lag=peak_position(fccc,hpw);
lag=lag(((lag>hpw)&(lag<=shift))|((lag>=n-shift)&(lag<n-hpw)));
[max_l,ind_l]=max(fccc(1:hpw+1));
[max_r,ind_r]=max(fliplr(fccc(n-hpw-1:n)));
lag=[lag;ind_l;(n-ind_r)];
lag=unique(lag);
sfccc=fccc(lag);
lag=lag-1;
if any(lag>n/2)
   lag(lag>n/2)=lag(lag>n/2)-n; 
end
