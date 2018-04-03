function [pos,dx]=peak_position(x,hpw)
%¼ì²â·åµÄÎ»ÖÃ
dx = -cwt(x,2*hpw,'haar');
pos=find(sign(-sign(diff(sign(dx))+0.5)+1))';

