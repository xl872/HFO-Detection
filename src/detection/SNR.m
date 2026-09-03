function [tag_snr,tag_env,env] = SNR(data_wpd,data_low,Fs)
%UNTITLED 此处显示有关此函数的摘要 | MATLAB template placeholder, summary of this function goes here
%   此处显示详细说明 | MATLAB template placeholder, detailed explanation goes here
bp_lot=sign(data_wpd);
lp_lot=sign(data_low+data_wpd);


bp_lot=abs([diff(data_wpd),0]);
bp_lot=mapminmax(bp_lot);
lp_lot=abs([diff(data_low),0]);
lp_lot=mapminmax(lp_lot);

N=length(bp_lot);
% tem_lot=data_low+data_wpd;

T=0.016*Fs;%0.1
for i=1:T
    signal(:,i)=bp_lot(i:N-T+i);
    noise(:,i)=lp_lot(i:N-T+i);
end
signal=signal.^2;
noise=noise.^2;
signal=sum(signal,2);
noise=sum(noise,2);
SNR=10*log10(signal./noise);
for i=1:T-1
  signal_t(i)=mean(bp_lot(N-2*T+i:N-T+1+i).^2);
  noise_t(i)=mean(lp_lot(N-2*T+i:N-T+1+i).^2);
  end  
SNR_t=10*log10(signal_t./noise_t);
SNR=[SNR;SNR_t'];
SNR=abs(SNR);

%Envelop=Env(data_wpd);
Envelop=data_wpd;
T=0.016*Fs;%0.032
%滑动窗口局部最大 | sliding-window local maximum
for i=1:T
    LMSNR(:,i)=SNR(i:N-T+i);
    LMENV(:,i)=Envelop(i:N-T+i);
    LMENV_E(:,i)=-Envelop(i:N-T+i);
end

for i=1:T-1
  LMSNR_t(i,:)=SNR(N-2*T+i+2:N-T+1+i);
  LMENV_t(i,:)=Envelop(N-2*T+i+2:N-T+1+i);
  LMENV_tE(i,:)=-Envelop(N-2*T+i+2:N-T+1+i);
end  
  

LMSNR=[LMSNR;LMSNR_t];
LMSNR=max(LMSNR,[],2);%mean(LMSNR,2);
LMSNR=(LMSNR-mean(LMSNR))/mean(LMSNR);%归一化 | normalization
LMSNR(LMSNR<=0)=0;
tag_snr=sign(LMSNR);

LMENV=[LMENV;LMENV_t];
LMENV_E=[LMENV_E;LMENV_tE];
LMENV=max(LMENV,[],2);
LMENV_E=max(LMENV_E,[],2);
env=[zeros(T/2,1);LMENV(1:length(LMENV)-T/2)];
env_e=[zeros(T/2,1);LMENV_E(1:length(LMENV)-T/2)];
env=env+env_e;
LMENV=LMENV-mean(LMENV);
%LMENV=(LMENV-3*std(LMENV));%归一化 | LMENV=(LMENV-3*std(LMENV)); normalization
tag_env=sign([zeros(T/2,1);LMENV(1:length(LMENV)-T/2)]);

end

