clc; close all; clear all;

AB = 1;
AC = AB;
BC = (AC+AB)/3;
% AB = 1;
% BC = 0.85;
% AC = 1.56;

s = (AB + AC + BC)/2; %semi-perimeter
R = sqrt((s-BC)*(s-AC)*(s-AB)/s);

alpha = acosd((AB^2 + AC^2 - BC^2)/(2*AB*AC));
beta = acosd((AB^2 + BC^2 - AC^2)/(2*AB*BC));
gamma = acosd((AC^2 + BC^2 - AB^2)/(2*AC*BC));

theta = 0;

A = [0,0];
B = [AB*cosd(theta),AB*sind(theta)];
C = [AC*cosd(theta+alpha),AC*sind(theta+alpha)];

xpo = [A(1,1), B(1,1), C(1,1)];
ypo = [A(1,2), B(1,2), C(1,2)];
xmin = min(xpo); xmax = max(xpo);
ymin = min(ypo); ymax = max(ypo);

x = xmin:0.001:2*xmax;
y = ymin:0.001:2*ymax;

I = [(BC*A(1,1)+AC*B(1,1)+AB*C(1,1))/(AB+BC+AC), (BC*A(1,2)+AC*B(1,2)+AB*C(1,2))/(AB+BC+AC)];

P = [A(1,1) + (s - BC)*cosd(alpha+theta),A(1,2) + (s - BC)*sind(alpha+theta)];
Q = [A(1,1) + (s - BC)*cosd(theta),A(1,2) + (s - BC)*sind(theta)];
S = [B(1,1) - (s - AC)*cosd(beta-theta),B(1,2) + (s-AC)*sind(beta-theta)];

y_alpha = ((A(1,2)-I(1,2))/(A(1,1)-I(1,1))).*x + A(1,2) - ((A(1,2)-I(1,2))/(A(1,1)-I(1,1)))*A(1,1);
y_beta = ((B(1,2)-I(1,2))/(B(1,1)-I(1,1))).*x + B(1,2) - ((B(1,2)-I(1,2))/(B(1,1)-I(1,1)))*B(1,1);
y_gamma = ((C(1,2)-I(1,2))/(C(1,1)-I(1,1))).*x + C(1,2) - ((C(1,2)-I(1,2))/(C(1,1)-I(1,1)))*C(1,1);

y_AB = ((A(1,2)-B(1,2))/(A(1,1)-B(1,1))).*x + A(1,2) - ((A(1,2)-B(1,2))/(A(1,1)-B(1,1)))*A(1,1);
y_AC = ((A(1,2)-C(1,2))/(A(1,1)-C(1,1))).*x + A(1,2) - ((A(1,2)-C(1,2))/(A(1,1)-C(1,1)))*A(1,1);
y_PQ = ((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1))).*x + P(1,2) - ((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1)))*P(1,1);


Lx = (P(1,2)-B(1,2)+((B(1,2)-I(1,2))/(B(1,1)-I(1,1)))*B(1,1) - (P(1,2)-Q(1,2))/(P(1,1)-Q(1,1))*P(1,1))/((B(1,2)-I(1,2))/(B(1,1)-I(1,1))-((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1))));
Ly = ((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1)))*Lx + P(1,2) - ((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1)))*P(1,1);
Kx = (P(1,2)-C(1,2)+((C(1,2)-I(1,2))/(C(1,1)-I(1,1)))*C(1,1) - (P(1,2)-Q(1,2))/(P(1,1)-Q(1,1))*P(1,1))/((C(1,2)-I(1,2))/(C(1,1)-I(1,1))-((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1))));
Ky = ((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1)))*Kx + P(1,2) - ((P(1,2)-Q(1,2))/(P(1,1)-Q(1,1)))*P(1,1);
L = [Lx,Ly];
K = [Kx,Ky];

M = [L(1,1)-I(1,1), L(1,2)-I(1,2);K(1,1)-I(1,1),K(1,2)-I(1,2)];
b = 0.5.*[(L(1,1)^2-I(1,1)^2+L(1,2)^2-I(1,2)^2);((K(1,1)^2-I(1,1)^2+K(1,2)^2-I(1,2)^2))];
Z = (M\b)';
r = sqrt((I(1,1)-Z(1,1))^2 + (I(1,2)-Z(1,2))^2);

figure(1);
scatter(A(1,1),A(1,2),'filled','bl');
hold on;
text(A(1,1)+0.02,A(1,2)-0.02,'A');
scatter(B(1,1),B(1,2),'filled','bl');
text(B(1,1)+0.02,B(1,2)-0.02,'B');
scatter(C(1,1),C(1,2),'filled','bl');
text(C(1,1)+0.02,C(1,2)-0.02,'C');
scatter(I(1,1),I(1,2),'filled','bl');
text(I(1,1)+0.02,I(1,2)-0.02,'I');
scatter(P(1,1),P(1,2),'filled','bl');
text(P(1,1)+0.01,P(1,2)+0.03,'P');
scatter(Q(1,1),Q(1,2),'filled','bl');
text(Q(1,1)+0.02,Q(1,2)+0.02,'Q');
scatter(S(1,1),S(1,2),'filled','bl');
text(S(1,1)+0.02,S(1,2)-0.02,'S');
scatter(L(1,1),L(1,2),'filled','bl');
text(L(1,1)+0.02,L(1,2)-0.02,'L');
scatter(K(1,1),K(1,2),'filled','bl');
text(K(1,1)+0.02,K(1,2)-0.02,'K');
scatter(Z(1,1),Z(1,2),'filled','bl');
text(Z(1,1)+0.02,Z(1,2)-0.02,'Z');
plot([A(1,1) B(1,1)], [A(1,2) B(1,2)],'bl');
plot([A(1,1) C(1,1)], [A(1,2) C(1,2)],'bl');
plot([C(1,1) B(1,1)], [C(1,2) B(1,2)],'bl');
plot([I(1,1) P(1,1)], [I(1,2) P(1,2)],'bl');
plot([I(1,1) Q(1,1)], [I(1,2) Q(1,2)],'bl');
plot([P(1,1) Q(1,1)], [P(1,2) Q(1,2)],'bl');
plot(x,y_alpha);
plot(x,y_beta);
plot(x,y_gamma);
viscircles(I,R);
viscircles(Z,r);
 axis([xmin xmax ymin ymax]);