function [y] = FIR_BP(N,Fs,Fl,Fh,x)
%UNTITLED 此处显示有关此函数的摘要 | MATLAB template placeholder, summary of this function goes here
%   此处显示详细说明 | MATLAB template placeholder, detailed explanation goes here
% 滤波器长度 | filter length


%各种滤波器的特征频率 | characteristic frequencies of the filters

fp_bandpass=[Fl Fh];

%以采样频率的一般，对频率归一化 | normalize the frequencies by half the sampling rate (Nyquist)
wn_bandpass=fp_bandpass*2/Fs;



b=fir1(N,wn_bandpass,'bandpass');


y=filtfilt(b,1,x);


end

