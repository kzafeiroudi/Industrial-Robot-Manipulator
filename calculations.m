clear all
close all
clc

syms q1 q2 q3 q4 q5 q6
syms l1 l2 l3 l4 lE

rob

a02 = a01*a12;
a02 = simplify(a02)
a03 = a02*a23;
a03 = simplify(a03)
a04 = a03*a34;
a04 = simplify(a04)
a05 = a04*a45;
a05 = simplify(a05)
a0E = a05*a5E;
a0E = simplify(a0E)

q4 = 0;
q5 = 0;
q6 = 0;

rob

b02 = a01*a12;
b03 = b02*a23;
b04 = b03*a34;
b05 = b04*a45;
b0E = b05*a5E;
b01 = simplify(a01);
b02 = simplify(b02);
b03 = simplify(b03);
b04 = simplify(b04);
b05 = simplify(b05);
b0E = simplify(b0E);

q = [q1 q2 q3];
p = b0E(1:3,4);
jL = jacobian(p,q);
bb = [0; 0; 1];
jA = [bb b01(1:3,3) b02(1:3,3)];
J = [jL ; jA];
D1 = det(jL);
D1 = simplify(D1);
D2 = det(jA);
D2 = simplify(D2);
I = inv(jL);
I = simplify(I);
