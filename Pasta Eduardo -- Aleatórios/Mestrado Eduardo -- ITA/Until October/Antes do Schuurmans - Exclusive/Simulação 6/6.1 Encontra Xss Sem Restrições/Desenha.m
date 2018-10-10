Main;

N = size(Dif1,1);

for i=1:N
   clf('reset'); 
   xM = Dif1(i,:);
   xM2 = Dif2(i,:);
   
   x = xk0(1);
   y = xk0(2);
   u1 = xM(1);
   v1 = xM(2);
   u2 = xM2(1);
   v2 = xM2(2);
   plot(x, y, '*r');
   hold on
   quiver(x,y,u1,v1);
   hold on
   quiver(x,y,u2,v2,'Color' ,'magenta');
   axis([-2 12 -2 12]);
   grid on;
   
   pause(0.00005);
end