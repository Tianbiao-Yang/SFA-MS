%[C,S]=constant(C,S,option);
% normalize resolution results, It  can also be used 
% for normalize spectra only.
%option=1: S constant length
%option=2: S constant maximum
%option=3: S constant sum
function [C,S]=constant(C,S,option);

[m,n]=size(S);
temp=find(max(S)<=abs(min(S)));
if ~isempty(temp)& ~isempty(C)
   S(:,temp)=-S(:,temp);
   C(:,temp)=-C(:,temp);
end

for i=1:n
   if option==1
      k=norm(S(:,i));
   elseif option==2
      k=max(S(:,i));
   elseif option==3
      k=sum(S(:,i));
   end
   if isempty(C)
      S(:,i)=S(:,i)/k;
   else
      S(:,i)=S(:,i)/k;
      C(:,i)=C(:,i)*k;
   end
end
