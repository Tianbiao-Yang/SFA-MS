function [Xc,Z]= airPLS(X,lambda,order,wep,p,itermax)
%% ��������
% load p1p2 
% X=p1;lambda=10e9;order=2;wep=0.1;p=0.5;itermax=20;nargin=2.5;
%% ����У��
if nargin < 6
    itermax=20;
  if nargin < 5
     p=0.05;
    if nargin < 4
       wep=0.1;
      if nargin < 3
          order=2;
          if nargin < 2
               lambda=10e7;
              if nargin < 1
                   error('airPLS:NotEnoughInputs','Not enough input arguments. See airPLS.');
              end    
          end  
      end  
    end
  end
end
[m,n]=size(X);
wi = [1:ceil(n*wep) floor(n-n*wep):n];
D = diff(speye(n), order);
DD = lambda*D'*D;
for i=1:m
    w=ones(n,1);
    x=X(i,:);
    for j=1:itermax
        W=spdiags(w, 0, n, n);
        C = chol(W + DD);
        z = (C\(C'\(w .* x')))';
        d = x-z;
        dssn= abs(sum(d(d<0)));
        if(dssn<0.001*sum(abs(x))) 
            break;
        end
        w(d>=0) = 0;
        w(wi)   = p;
        w(d<0)  = j*exp(abs(d(d<0))/dssn);
    end
    Z(i,:)=z;                   %���˵�������ʹԭ���׷��𽥱�У��
end
Xc=X-Z;                         %У�����ߺ�ľ���
end
