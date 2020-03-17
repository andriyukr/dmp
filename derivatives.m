clear all;
clc;

syms t omega dt i

f1 = 2*sqrt(2)*cos(2*pi*t)/(3 - cos(4*pi*t)) + 1;
df1 = diff(f1, t);
ddf1 = diff(df1, t);

f2 = 2*sin(4*pi*t)/(3 - cos(4*pi*t)) + 2;
df2 = diff(f2, t);
ddf2 = diff(df2, t);

t1 = subs(f1, t, dt*i)
td1 = subs(df1, t, dt*i)
tdd1 = subs(ddf1, t, dt*i)
t2 = subs(f2, t, dt*i)
td2 = subs(df2, t, dt*i)
tdd2 = subs(ddf2, t, dt*i)