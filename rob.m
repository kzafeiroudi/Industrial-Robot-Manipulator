
th = [q1 (q2-pi/2) (q3+pi/2) q4 q5 q6];
d = [l1 0 0 l3 0 (l4+lE)];
ang = [-90 0 90 -90 90 0];
a = [0 l2 0 0 0 0];
f1 = [];
f2 = [];
f3 = [];
f4 = [];
for i=1:6
    f1 = [f1; cos(th(i)) -sin(th(i))*cosd(ang(i)) sin(th(i))*sind(ang(i)) a(i)*cos(th(i))];
    f2 = [f2; sin(th(i)) cos(th(i))*cosd(ang(i)) -cos(th(i))*sind(ang(i)) a(i)*sin(th(i))];
    f3 = [f3; 0 sind(ang(i)) cosd(ang(i)) d(i)];
    f4 = [f4; 0 0 0 1];
end
a01 = [f1(1, :); f2(1, :); f3(1, :); f4(1, :)];
a01 = simplify(a01)
a12 = [f1(2, :); f2(2, :); f3(2, :); f4(2, :)];
a12 = simplify(a12)
a23 = [f1(3, :); f2(3, :); f3(3, :); f4(3, :)];
a23 = simplify(a23)
a34 = [f1(4, :); f2(4, :); f3(4, :); f4(4, :)];
a34 = simplify(a34)
a45 = [f1(5, :); f2(5, :); f3(5, :); f4(5, :)];
a45 = simplify(a45)
a5E = [f1(6, :); f2(6, :); f3(6, :); f4(6, :)];
a5E = simplify(a5E)