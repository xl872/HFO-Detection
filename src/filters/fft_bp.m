function [ y2 ] = fft_bp(y,Tl,Th,Fs)
%y为数据，T是截止频率 | y is the signal, T is the cutoff frequency
len=length(y);               %y为数据 | y is the signal
ffy=fft(y);
Tl=len/Fs*Tl;                   %T为截止频率，只保留频率大于T。 | T is the cutoff frequency, only frequencies above T are kept
Th=len/Fs*Th; 
ffy2=ffy([[Tl+1:Th+1],[len-Th,len-Tl]]);
y2=real(ifft(ffy2,len));                    %y2为滤波后的函数 | y2 is the filtered signal

end

        