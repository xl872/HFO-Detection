function [x] = trap(Fs,F_TRAP,x)
%UNTITLED 此处显示有关此函数的摘要 | MATLAB template placeholder, summary of this function goes here
%   此处显示详细说明 | MATLAB template placeholder, detailed explanation goes here
for i=1:length(F_TRAP)
f0=F_TRAP(i);fs=Fs;r=0.9;
w0=2*pi*f0/fs;
b=[1 -2*cos(w0) 1];
a=[1 -2*r*cos(w0) r*r];
x=filter(b,a,x);
end
end

