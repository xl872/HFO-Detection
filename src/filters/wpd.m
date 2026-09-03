function[data_wpd,data_low]= wpd(data,left,right,d,Fs)

%left和right是带通上下界 | left and right are the band-pass lower/upper bounds
%d是带通区间可接受最大误差 | d is the maximum acceptable error of the band edges
%Fs是采样频率 | Fs is the sampling frequency


i=0;%小波层数 | wavelet decomposition level
t_min=d;
t_max=d;
while (t_min>=d)||(t_max>=d)
    i=i+1;
    s=0:(Fs/2^(i+1)):Fs/2;
    s_min=abs(s-left);
    t_min=min(s_min);
    s_max=abs(s-right);
    t_max=min(s_max);      
end
a_left=find(s_min==t_min)-1;%小波带通下限截止节点 | wavelet-packet node at the lower cutoff
a_right=find(s_max==t_max)-2;%小波带通上限截止节点 | wavelet-packet node at the upper cutoff

level=i;%7层小波包分解,例如采样4000hz：2000-1000-500-250-125-62.5-31-15 | 7-level wavelet-packet decomposition, e.g. at 4000 Hz the band edges are 2000-1000-500-250-125-62.5-31-15
motherwave='db4';%母小波512：256-128-64-32-16-8-4-2-1-.5-.25 | mother wavelet, for 512 Hz the band edges are 256-128-64-32-16-8-4-2-1-.5-.25

%%%%%%%%%%%%%%%%%%%%%%%
wpdTree=wpdec(data,level,motherwave,'shannon');
for j=1:a_right+1
    temp(j,:)=wprcoef(wpdTree,[i,j-1]);
end

data_low=sum(temp(1:a_left,:),1);
data_wpd=sum(temp(a_left+1:a_right(1)+1,:),1);

 end


