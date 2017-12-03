function animate_simulation_3(t,x)
n=length(t);
dt=diff(t);
o0=[0;0;0];
figure(2)
for i=1:n-1
    q1=x(i,1);
    q2=x(i,3);
    q3=x(i,5);
    o1=[cos(q1);sin(q1)];
    o2=[cos(q1)+cos(q1+q2);sin(q1)+sin(q1+q2)];
    o3=[cos(q1)+cos(q1+q2)+cos(q1+q2+q3);sin(q1)+sin(q1+q2)+sin(q1+q2+q3)];
   hold on;
    plot([o0(1) o1(1) o2(1) o3(1)],[o0(2) o1(2) o2(2) o3(2)])
    plot(o1(1),o1(2),'rx','LineWidth',2)
    plot(o2(1),o2(2),'rx','LineWidth',2)
     plot(o3(1),o3(2),'rx','LineWidth',2)
     
    axis square
    xlim([-3,3]);
    ylim([-3,3]);
    grid on;
    drawnow();
    pause(dt/3)
    clf
end