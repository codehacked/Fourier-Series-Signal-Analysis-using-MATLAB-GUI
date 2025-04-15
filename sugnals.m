clc
clear all
T=2*pi;
wo=(2*pi)/(2*pi);
syms t
k=-2:2
x1=sin((2*pi*t)/T);
x2=abs(sin((2*pi*t)/T));
ak1=(1/T)*(int(x1*exp(-j*k*wo*t),t,0,T));
ans1=vpa(ak1,length(k))
ak2=(1/T)*int(x2*exp(-j*k*wo*t),t,0,T);
ans2=vpa(ak2,length(k))
subplot 211
stem(k,imag(ans1))
subplot 212
stem(k,ans2)
