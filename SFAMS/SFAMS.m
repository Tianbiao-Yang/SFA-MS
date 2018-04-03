function [xn,peaks,CoCe,shiftvalue] = SFAMS(reftic,refmz,xtic,xmz,phi,max_shift,valve,AMWFA_wz,l)
%  CAMS	
%  Input 
%         reftic:�ο��׷�(row vector)
%         refmz: �ο��׷����׾���
%         xtic: ��У�׷�(row vector)
%         xmz:  ��У�׷����׾���
%         phi:  �����ˮƽ
%         max_shift: ���λ����
%         valve:���׵Ľ������
%  Output
%         xn:У������
%         peaks: ��⵽�ķ�ֵ
%         CoCe: corrcoef correlation of two chromatograms
%         shiftvalue: ÿ�����λ����
if nargin<7
    valve=0.8; 
end
if nargin<6
    max_shift=90; 
end
if nargin<5
    phi=6; 
end
if (nargin<4)
    help align;
    return;
end

[xs,xln]=wavelet_denoising(xtic,l,6,'soft');
[ss,sln]=wavelet_denoising(reftic,l,6,'soft');
peaks=peak_detection(xtic,3,xln,phi);
peaks=peak_clustering(xtic,peaks,1);
xs=xtic;
xn=xs;
shiftvalue=zeros(1,size(peaks,1));
for i=size(peaks,1):-1:1
    si=max(1,peaks(i,1)-max_shift);
    ei=min(length(xs),peaks(i,3)+max_shift);
    [lag,fccc]=fftcc(xs(si:ei),ss(si:ei),max_shift); 
    
    for j=length(lag):-1:1
        if i>2 && i<size(peaks,1)
            if (lag(j)>0) && (lag(j)>(peaks(i+1,1)-peaks(i,1)))
                lag(j) =[];
            end
            if (lag(j)<0) && (abs(lag(j))> (peaks(i,1)-peaks(i-1,1)))
                lag(j) =[];
            end     
        end
    end
    for j=1:length(lag)
        if (peaks(i,1)+lag(j))>0 && (peaks(i,2)+lag(j)<length(reftic))
            %R(j) = corr2(xmz(:,(peaks(i,2)-1):(peaks(i,2)+1)),refmz(:,(peaks(i,2)+lag(j)-1):(peaks(i,2)+lag(j)+1)));
            R(j)=SWFA(xmz(:,((peaks(i,1))-0):((peaks(i,3))+0)),refmz(:,((peaks(i,1)-0)+lag(j)):(((peaks(i,3))+0)+lag(j))),0.1,AMWFA_wz,valve);
            %R(j)=SWFA(xmz(:,((peaks(i,1))-0):((peaks(i,3))+0)),refmz(:,((peaks(i,1)-0)+lag(j)):(((peaks(i,3))+0)+lag(j))),0.1,AMWFA_wz);
            %a=R(j);
            %R1=SFA(xmz(:,(peaks(i,2)-AMWFA_NPC):(peaks(i,2)+AMWFA_NPC)),refmz(:,(peaks(i,2)+lag(j)-AMWFA_NPC):(peaks(i,2)+lag(j))+AMWFA_NPC),AMWFA_wz);
            %E(j,:)=R1;
            %R=E;
        end
            
    end
    %[value,shift] = max(R);
    %shiftvalue(i)=lag(shift);
    %if 0
     if max(R)>=valve
         [value,shift] = max(R);
         shiftvalue(i)=lag(shift);
     else
        peaks(i,:) = [];
        shiftvalue(i) = [];
     end
    %end
    CoCe(i)=max(R);
    R=[];
    %E=[];
end

for i=1:size(peaks,1)  
    if i==1
        if peaks(i,1)+shiftvalue(i) <= 1
            xn(1:(peaks(i,3)+shiftvalue(i))) = xs(abs(shiftvalue(i)-1):peaks(i,3));
        elseif peaks(i,1)==1
            xn(1:peaks(i,3)) = xs(1:peaks(i,3));
        else
            xt=interp1(1:peaks(i,1), xs(1:peaks(i,1)),linspace(1,peaks(i,1),peaks(i,1)+shiftvalue(i)));
            xn(1:(peaks(i,1)+shiftvalue(i))) = xt;
            xn((peaks(i,1):peaks(i,3))+shiftvalue(i)) = xs(peaks(i,1):peaks(i,3)); 
        end
        if size(peaks,1)==1
            xt=interp1(peaks(i,3):length(xs), xs(peaks(i,3):length(xs)),linspace(peaks(i,3),length(xs),length(xs)-peaks(i,3)-shiftvalue(i)+1));
            xn((peaks(i,3)+shiftvalue(i)):length(xs)) = xt;
        end
    elseif i==size(peaks,1)
        if peaks(i,3)+shiftvalue(i) < length(xn)
            xt=interp1(peaks(i,3):length(xs), xs(peaks(i,3):length(xs)),linspace(peaks(i,3),length(xs),length(xs)-peaks(i,3)-shiftvalue(i)+1));
            xn((peaks(i,3)+shiftvalue(i)):length(xs)) = xt;
            xt=interp1(peaks(i-1,3):peaks(i,1), xs(peaks(i-1,3):peaks(i,1)),linspace(peaks(i-1,3),peaks(i,1),peaks(i,1)+shiftvalue(i)+1-(peaks(i-1,3)+shiftvalue(i-1))));
            xn((peaks(i-1,3)+shiftvalue(i-1)):(peaks(i,1)+shiftvalue(i))) = xt;
            xn((peaks(i,1):peaks(i,3))+shiftvalue(i)) = xs(peaks(i,1):peaks(i,3));
        end
    else
        if peaks(i-1,3)+shiftvalue(i-1)>peaks(i,1)+shiftvalue(i)
             xn((peaks(i,1)+shiftvalue(i)):(peaks(i-1,3)+shiftvalue(i-1))) =  xn((peaks(i,1)+shiftvalue(i)):(peaks(i-1,3)+shiftvalue(i-1))) + xs(peaks(i,1):(peaks(i-1,3)+shiftvalue(i-1)-shiftvalue(i)));
             xn((peaks(i-1,3)+shiftvalue(i-1)):(peaks(i,3)+shiftvalue(i))) =  xs((peaks(i-1,3)+shiftvalue(i-1)-shiftvalue(i)):peaks(i,3));
        else
            xt=interp1(peaks(i-1,3):peaks(i,1), xs(peaks(i-1,3):peaks(i,1)),linspace(peaks(i-1,3),peaks(i,1),peaks(i,1)+shiftvalue(i)+1-(peaks(i-1,3)+shiftvalue(i-1))));
            xn((peaks(i-1,3)+shiftvalue(i-1)):(peaks(i,1)+shiftvalue(i))) = xt;
            xn((peaks(i,1):peaks(i,3))+shiftvalue(i)) = xs(peaks(i,1):peaks(i,3));
       end
    end
end