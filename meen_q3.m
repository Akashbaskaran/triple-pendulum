function meen_q3()
clear all
global f;
f = 1;
tspan=0:0.05:20;
x0=[0;0;0;0;0;0];
[t,y]=ode45(@myfunc,tspan,x0);
% figure(1)
plot(t,y(:,2),t,y(:,4),t,y(:,6));
xlabel('time (s)');ylabel('joint velocities (rad/sec)');grid on;
animate_simulation_3(t,y)
 


 function dy=myfunc(t,y)
dy=zeros(6,1);
g=9.81;
l1=1;
l2=1; l3=1;
lc1=0.5;
lc2=0.5; lc3=0.5;
m1=1;
m2=1; m3=1;
g=9.81;
I1=1;
I2=1; I3=1;


D= [I1+I2+I3+lc1^2*m1+(l1^2 + lc2^2)*m2+(l1^2 + l2^2 + lc3^2)*m3+2*l1*(lc2*m2 + l2*m3)*cos(y(3)) + 2*lc3*m3*(l2 *cos(y(5)) + l1*cos(y(3) + y(5)))  I2+I3+lc2^2*m2+(l2^2 + lc3^2)*m3 + l1*(lc2*m2+l2*m3)*cos(y(3)) ...
   + 2*l2*lc3*m3*cos(y(5))+ l1*lc3*m3*cos(y(3) + y(5))  I3+lc3^2*m3 + l2*lc3*m3*cos(y(5)) + l1*lc3*m3*cos(y(3) + y(5));I2+I3+lc2^2*m2+(l2^2 + lc3^2)*m3 + l1*(lc2*m2 + l2*m3)*cos(y(3)) + 2*l2*lc3*m3 *cos(y(5)) ... 
   + l1*lc3*m3*cos(y(3) + y(5)) I2+I3+lc2^2*m2+(l2^2 + lc3^2)*m3 + 2*l2*lc3*m3*cos(y(5)) I3+lc3^2*m3+l2*lc3*m3*cos(y(5)); I3 + lc3^2*m3 + l2*lc3*m3*cos(y(5)) + l1*lc3*m3*cos(y(3) + y(5)) I3 + lc3^2*m3 + ...
   l2*lc3*m3*cos(y(5)) I3 + lc3^2*m3];

C=[(-1).*l1.*((lc2.*m2+l2.*m3).*sin(y(3))+lc3.*m3.*sin(y(3)+y(5))).* ...
 y(4)+(-1).*lc3.*m3.*(l2.*sin(y(5))+l1.*sin(y(3)+y(5))).* ...
 y(6),(-1).*l1.*((lc2.*m2+l2.*m3).*sin(y(3))+lc3.* ...
 m3.*sin(y(3)+y(5))).*(y(2)+y(4))+(-1) ...
 .*lc3.*m3.*(l2.*sin(y(5))+l1.*sin(y(3)+y(5))).*y(6),(-1) ...
 .*lc3.*m3.*(l2.*sin(y(5))+l1.*sin(y(3)+y(5))).*(y(2)+ ...
 y(4)+y(6));l1.*((lc2.*m2+l2.*m3).*sin(y(3))+lc3.*m3.*sin(y(3)+y(5))).*y(2)+(-1).*l2.*lc3.*m3.*sin(y(5)).*y(6),(-1).*l2.*lc3.*m3.*sin(y(5)).*y(6),(-1).*l2.*lc3.*m3.*sin(y(5)).*(y(2)+y(4)+y(6));...
 lc3.*m3.*((l2.*sin(y(5))+l1.*sin(y(3)+y(5))).*y(2)+l2.*sin(y(5)).*y(4)),l2.*lc3.*m3.*sin(y(5)).*(y(2)+y(4)),0];

G=[g.*((lc1.*m1+l1.*m2+l1.*m3).*cos(y(1))+(lc2.*m2+l2.*m3).*cos( ...
y(1)+y(3))+lc3.*m3.*cos(y(1)+y(3)+y(5)));g.*((lc2.*m2+l2.*m3).*cos(y(1)+ ...
y(3))+lc3.*m3.*cos(y(1)+y(3)+y(5)));g.*lc3.*m3.*cos(y(1)+y(3)+y(5))];

Cp=D\C;
Gp=D\G;
global f;

if f == 1
    tau = [15;0;0];
else 
    tau = [0;0;0];
end

% tau = [0;0;0];

if y(1) > pi/2
    f = 0;
end

taup=D\tau;
dy(1)=y(2);
dy(2)=-Cp(1,1)*y(2) -Cp(1,2)*y(4)-Cp(1,3)*y(6) -Gp(1)+ taup(1);
dy(3)=y(4);
dy(4)=-Cp(2,1)*y(2)-Cp(2,2)*y(4)-Cp(2,3)*y(6)- Gp(2)+taup(2) ;
dy(5)=y(6);
dy(6)=-Cp(3,1)*y(2)-Cp(3,2)*y(4)-Cp(3,3)*y(6)- Gp(3)+taup(3) ;


