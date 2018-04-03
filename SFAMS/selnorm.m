function y=selnorm(x,thres);
%函数 selnorm 用于对数据矩阵进行选择性标准化，以消除不等性方差的对体系组分数估计的影响。
%输入参数：
%	1、x 为一2维数据矩阵，该矩阵的每一行为一个光谱；每一列为一个色谱（或一		
%	   滴定曲线，或一动力学系统的连续时间记录，等）；
%	2、 thres为标准化阈值。
%输出参数：
%	1、 y 为经选择性标准化后得到的数据矩阵。可直接用于函数seqrank的特征结构跟踪分析，以得到化学秩图
[m,n]=size(x);
    for i=1:m
       if sum(x(i,:))>=thres
          y(i,:)=x(i,:)./sum(x(i,:))*thres;
       else
          y(i,:)=x(i,:);
       end
    end
end
