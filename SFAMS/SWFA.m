function [R,h]=SWFA(X,Y,Noise_threshold,AMWFA_wz,valve)
%Note: The Algorithms were Proposed by YiZeng Liang and ZhongDa Zeng. 
%The Programs were Written by ZhongDa Zeng and  YiZeng Liang. 
%Anyone who Want to Use this Software should Inform them in Advance.
%E-Mail:Chemoinformatics@sina.com
%May,2005.
%function CRM%load Test_MS_X%load Test_MS_Y
%clear all
%load data
%load peaks
%Noise_threshold=0.1;AMWFA_wz=3;
%X=X(:,((peaks(2,2))-3):((peaks(2,2))+3));
%Y=Y(:,((peaks(2,2)-3)+3):(((peaks(2,2))+3)+3));
X_temp=X;Xl=X_temp;Y_temp=Y;Yl=Y_temp;Spectra_Coll=[];F=[];
leftr=AMWFA_wz;rightr=AMWFA_wz;M_Window=AMWFA_wz;FittingV_Dr=[];
[m,n]=size(X_temp);
if n<M_Window
    nc=M_Window-n;
    ncc=zeros(m,nc);
    X_temp=[X_temp,ncc];
    Y_temp=[Y_temp,ncc];
end
for i_Total=1:m-M_Window+1-AMWFA_wz
    X_temp_Multi_SWFA=X_temp(i_Total:i_Total+M_Window-1,:);
    Xl=X_temp_Multi_SWFA;
    [Ul,dl,Vl]=svd(Xl,0);
    Vl=Vl(:,1:leftr);
    Xr=Yl;
    [Ur,dr,Vr]=svd(Xr,0);
    Vr=Vr(:,1:rightr);
    if leftr<=rightr
        Y_SWFA_Final_Sub=Vl'*Vr;
        [Uy,dy,Vy]=svd(Y_SWFA_Final_Sub,0); 
        if leftr>1
            d1=diag(dy);
        end
        if leftr==1
            d1=dy(1,1);
        end
        N=2*(1-d1);    
         for i=1:leftr
             Sl=Vl*Uy(:,i);
             Sr=Vr*Vy(:,i); 
             Sl=Sl/sum(Sl);
             Sr=Sr/sum(Sr);
             Sls(:,i)=Sl;
             Srs(:,i)=Sr;
         end   
    else
        Y_SWFA_Final_Sub=Vl'*Vr;
        [Uy,dy,Vy]=svd(Y_SWFA_Final_Sub,0);
        if leftr>1
            d1=diag(dy);
        end
        if leftr==1
            d1=dy(1,1);
        end
        N=2*(1-d1);    
    end
    FittingV_Dr=[FittingV_Dr d1];
    F=FittingV_Dr(1,:);
    Fi=find(F(1:end)>valve);
    [h,s]=size(Fi);
    sh=s/m;
%     if sh<0.1;
%     Fi=find(F(1:end)>0.8);
%     end
    Fit=F(Fi);
    R=mean(Fit);
end  
end
    