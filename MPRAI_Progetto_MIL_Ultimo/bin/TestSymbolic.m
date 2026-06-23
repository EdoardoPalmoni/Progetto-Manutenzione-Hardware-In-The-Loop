clear all;
clc;

omega = sym('omega',[3 1],'real');
syms z1 z2 real;

e1 = [1 0 0]';
e2 = [0 1 0]';
e3 = [0 0 1]';

b = 2*z2*cross(omega,e3) + z1*cross(omega,cross(omega,e3));
v1 = inner(e2,b)
v2 = inner(e1,-b)
v4 = inner(e3,-b)


function v3 = inner(v1,v2)
    v3 = v1'*v2;
end