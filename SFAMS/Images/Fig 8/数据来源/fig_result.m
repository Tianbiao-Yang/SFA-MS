load e‘≠
load d‘≠
figure
plot(d1,'k')
hold on
plot(d2,'k')%
plot(d3,'k')
plot(d4,'k')%
plot(d5,'k')
plot(d6,'k')
plot(d7,'k')
plot(d8,'k')%
xlabel('Time(dots)')
ylabel('Intensity')
title('GC-MS serum metabolic profiling simultaneously in four kinds of mice')
figure
plot(e1,'k')
hold on
plot(e2,'k')%
plot(e3,'k')
plot(e4,'k')%
plot(e5,'k')
plot(e6,'k')
plot(e7,'k')
plot(e8,'k')%
xlabel('Time(dots)')
ylabel('Intensity')
title('Align GC-MS serum metabolic profiling simultaneously in four kinds of mice via SFAMS')
load qian
load hou
figure
subplot(2,1,1)
for i=1:14
plot(qian(:,i)',1:8, '-rs','MarkerFaceColor','k');
hold on
end
xlabel('Time£®dots£©')
ylabel('Sample')
axis([0 8700 0 9]);
title('GC-MS serum metabolic profiling')

subplot(2,1,2)
plot(hou(:,1)',1:8, '-rs','MarkerFaceColor','k');
hold on
plot(hou(1,2)',1, '-rs','MarkerFaceColor','k');
plot(hou(4:6,2)',4:6, '-rs','MarkerFaceColor','k');
plot(hou(8,2)',8, '-rs','MarkerFaceColor','k');
for i=3:14
plot(hou(:,i)',1:8, '-rs','MarkerFaceColor','k');
hold on
end
xlabel('Time£®dots£©')
ylabel('Sample')
axis([0 8700 0 9]);
title('Align GC-MS serum metabolic profiling via SFAMS')

