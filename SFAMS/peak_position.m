function [pos,dx]=peak_position(x,hpw)
%�����λ��
dx = -cwt(x,2*hpw,'haar');
pos=find(sign(-sign(diff(sign(dx))+0.5)+1))';

