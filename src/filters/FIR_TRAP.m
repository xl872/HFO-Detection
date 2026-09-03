function [y] = FIR_TRAP(N,Fs,F_TRAP,x,n)
%UNTITLED 此处显示有关此函数的摘要 | MATLAB template placeholder, summary of this function goes here
%   此处显示详细说明 | MATLAB template placeholder, detailed explanation goes here
% 滤波器长度 | filter length
%x是数据 | x is the input signal
%n是陷波上下频率 | n is the lower/upper frequency of the notch band

%各种滤波器的特征频率 | characteristic frequencies of the filters
F_TRAP=sort([F_TRAP(:)-n;F_TRAP(:)+n]);


%以采样频率的一般，对频率归一化 | normalize the frequencies by half the sampling rate (Nyquist)


F_TRAP=F_TRAP*2/Fs;


%b=fir1(N-1,wn_bandpass,'bandpass');
b = fir1(N,F_TRAP','DC-1');


y=filtfilt(b,1,x);


end

