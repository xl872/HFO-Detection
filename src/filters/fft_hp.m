function [ y2 ] = fft_hp(y,T,Fs)
%y为数据，T是截止频率 | y is the signal, T is the cutoff frequency
len=length(y);               %y为数据 | y is the signal
ffy=fft(y);
T=len/Fs*T;                   %T为截止频率，只保留频率大于T。 | T is the cutoff frequency, only frequencies above T are kept
ffy2=ffy(T+1:len-T);
y2=ifft(ffy2,len);                    %y2为滤波后的函数 | y2 is the filtered signal

end

        