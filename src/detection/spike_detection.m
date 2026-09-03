
function [ SPIKETIME, W,W_CS,W_DX,W_SNEO,W_FD ] = spike_detection( X,Fs)


t=1:length(X);
t=t/Fs;
SPIKETIME=[];
bs = fir1(1024,[1/Fs*2,70/Fs*2]);%0.5 125
X=filtfilt(bs,1,X);

%% W_CS

w=0.01*Fs;

Xcs=[0,diff(X)];
for i=1+w:length(Xcs)-w
    cs(i)=sum(abs(Xcs(i-w:i+w)));
end
p_cs=find(cs>(mean(cs)+3*std(cs)));
  ws_cs(1)=p_cs(1);j=1;
for i=1:length(p_cs)-1
   
    if ((p_cs(i+1)-p_cs(i))>w)&&((p_cs(i)-ws_cs(j))>w)
         j=j+1;
        ws_cs(j)=p_cs(i+1);
        we_cs(j-1)=p_cs(i);
    end
    
end
we_cs(j)=p_cs(end);

[ W_CS,ws_cs,we_cs ] = duanchuli2( length(ws_cs),ws_cs,we_cs,length(X),Fs);
W_CS=W_CS*(max(X)-min(X))+min(X);
% ax1=subplot(5,1,1);
% 
% plot(t,X,t,W_CS);
% title('运用累加和的spike detection'); | title('spike detection using the cumulative sum')
%% W_DX
d_X=abs(diff(X));
%2ms滑动窗最大 | 2 ms sliding-window maximum
md_X=d_X;
n=100;
for i=n+1:(length(d_X)-n)
    md_X(i)=max(d_X(i-n:i+n));
end
p_dx=find(md_X>(mean(md_X)+3*std(md_X)));
if isempty(p_dx)
    ws_dx=[];we_dx=[];
else
  ws_dx(1)=p_dx(1);j=1;
for i=1:length(p_dx)-1
   
    if ((p_dx(i+1)-p_dx(i))>n)&&((p_dx(i)-ws_dx(j))>n)
         j=j+1;
        ws_dx(j)=p_dx(i+1);
        we_dx(j-1)=p_dx(i);
    end
    
end
we_dx(j)=p_dx(end);
end
% W_DX=zeros(1,length(X));
% W_DX=W_DX+min(X);
% for i=1:length(ws_dx)
%     W_DX(ws_dx(i):we_dx(i))=max(X);
% end
[ W_DX,ws_dx,we_dx ] = duanchuli2( length(ws_dx),ws_dx,we_dx,length(X),Fs);
W_DX=W_DX*(max(X)-min(X))+min(X);
% ax2=subplot(5,1,2);
% 
% plot(t,X,t,W_DX);
% title('运用差分的spike detection'); | title('spike detection using the first difference')

%% W_SNEO

for i=2:length(X)-1
   Tr(i)=abs(X(i)*X(i)-X(i-1)*X(i+1)) ;
end

Tr_X=Tr;
n=0.05*Fs;
for i=n+1:(length(Tr)-n)
    Tr_X(i)=max(Tr(i-n:i+n));
end

p_sneo=find(Tr_X>(mean(Tr_X)+std(Tr_X)));

ws_sneo=[];we_sneo=[];
  ws_sneo(1)=p_sneo(1);j=1;
  d_sneo=diff(p_sneo);
  [~,we_sneo]=find(d_sneo>Fs);
  ws_sneo=[ws_sneo,p_sneo(we_sneo+1)];
  we_sneo=[p_sneo(we_sneo),p_sneo(end)];
% for i=1:length(p_sneo)-1
%    
%     if ((p_sneo(i+1)-p_sneo(i))>Fs)&&((p_sneo(i)-ws_sneo(j))>100)
%          j=j+1;
%         ws_sneo(j)=p_sneo(i+1);
%         we_sneo(j-1)=p_sneo(i);
%     end
%     
% end
% we_sneo(j)=p_sneo(end);

W_SNEO=zeros(1,length(X));
W_SNEO=W_SNEO+min(X);
for i=1:length(ws_sneo)
    W_SNEO(ws_sneo(i):we_sneo(i))=max(X);
end
[ W_SNEO,ws_sneo,we_sneo ] = duanchuli2( length(ws_sneo),ws_sneo,we_sneo,length(X),Fs);
[ W_SNEO,ws_sneo,we_sneo ] = duanchuli2( length(ws_sneo),ws_sneo,we_sneo,length(X),Fs);
W_SNEO=W_SNEO*(max(X)-min(X))+min(X);
% ax3=subplot(5,1,3);
% 
% plot(t,X,t,W_SNEO);
% title('运用SNEO的spike detection'); | title('spike detection using SNEO')

%% W_FD
n=0.01*Fs;
for i=1:length(X)-n
    tX=X(i:i+n);
    aux_tX=sqrt(diff(tX).^2+1);
    L=sum(aux_tX);
    N=length(tX);
    j= 2:N;
    dist=sqrt((1-j).^2+(-1*tX(2:N)+tX(1)).^2);
    d = max(dist);
    fd_X(i) = log10(n)/(log10(n) + log10(d/L));
end

p_fd=find(fd_X>(mean(fd_X)+std(fd_X)));
  ws_fd(1)=p_fd(1);j=1;
for i=1:length(p_fd)-1
   
    if ((p_fd(i+1)-p_fd(i))>100)&&((p_fd(i)-ws_fd(j))>0.01*Fs)
         j=j+1;
        ws_fd(j)=p_fd(i+1);
        we_fd(j-1)=p_fd(i);
    end
    
end
we_fd(j)=p_fd(end);
[ W_FD,ws_fd,we_fd ] = duanchuli2( length(ws_fd),ws_fd,we_fd,length(X),Fs);

W_FD=W_FD*(max(X)-min(X))+min(X);
% ax4=subplot(5,1,4);
% 
% plot(t,X,t,W_FD);
% title('运用FD的spike detection'); | title('spike detection using FD')
%% W_peak 峰和谷点前后各延长Fs*0.2s | W_peak, extend each peak/trough by Fs*0.2 s on both sides

%% W
W=sign(0.5*mapminmax(W_CS,0,1)+mapminmax(W_DX,0,1)+0.5*mapminmax(W_FD,0,1)+mapminmax(W_SNEO,0,1)-1);
W(W<=0)=0;
W=W*(max(X)-min(X))+min(X);

[~,WS]=find(diff(W)>0);
[~,WE]=find(diff(W)<0);
%[ W,WS,WE ] = duanchuli( length(WS),WS,WE,length(W),Fs);
%W=W*(max(X)-min(X))+min(X);

J=ones(1,length(WS));
for i=1:length(WS)
   
  %  if对X(WS(i):WE(i))找峰/谷点，并对该点前后1ms求diff的平均，这个值的abs小于某个阈值 或 没有峰/谷 | find peaks/troughs in X(WS(i):WE(i)), average diff within 1 ms around each, reject if abs is below a threshold or no peak/trough exists
        [pks{i},locs] =findpeaks(abs(X(WS(i):WE(i))));
        if isempty(pks{i})
             J(i)=0;
%         elseif (mean(abs(diff(X(locs-100:locs-10))))+mean(abs(diff(X(locs+10:locs+100)))))/2<(mean(diff(X))+std(diff(X)))
%         J(i)=0;
        end
end
WE(J==0)=[];
WS(J==0)=[];
W=zeros(1,length(X));

for i=1:length(WS)
    W(WS(i):WE(i))=1;
    [pkst,locst] =findpeaks(X(WS(i):WE(i)));
    [pkstl,locstl] =findpeaks(-X(WS(i):WE(i)));
    pkst=[pkst,-pkstl];
    locst=[locst,locstl];
    pkst=abs(pkst-mean(X(WS(i):WE(i))));
    SPIKETIME(i)=WS(i)+locst(pkst==max(pkst))-1;
end
SPIKETIME=SPIKETIME/Fs;
[ W,WS,WE] = duanchuli2( length(WS),WS,WE,length(X),Fs);

% ax5=subplot(5,1,5);
% plot(t,X,t,W*(max(X)-min(X))+min(X));
% title('综合的spike detection'); | title('combined spike detection')
% disp('spike number:')
% spikenum=length(WS)
% % end
% linkaxes([ax1,ax2,ax3,ax4,ax5],'x')
end
