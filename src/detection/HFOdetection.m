function [fn_wtf,start_tf,end_tf,Nf,Fo,mH,sH,P_HFO,F_HFO,MF_HFO,F_R,CI]=HFOdetection(data,raw_data,tag_ll,tag_ee,tag_teo,tag_hil,tag_snr,tag_env,tf,Fs,NER,threshold_mtf,env,TTF2)
warning off
%Fs是采样频率 | Fs is the sampling frequency
%coef_thresh是判断峰的阈值 | coef_thresh is the threshold coefficient for peak detection
global freq;global Flo;global coef_thresh;

Nsamples = length(data);

m_data=mean(data);
data=data-m_data;
%tf=tf/mean(mean(tf));
mtf=max(tf(freq>Flo,:));

[b_mtf,x_mtf]=hist(mtf(:),1000);
y_mtf=cumsum(b_mtf/Nsamples);
%  threshold_mtf=min(x_mtf(y_mtf>0.9));


 TTF=mean(mtf);
 threshold_mtf=mean(mtf)+2*std(mtf);

wtf=(sign(mtf-threshold_mtf)+1)/2;
% wtf=(sign(mtf-mean(mtf)-std(mtf))+1)/2;
wtf(1)=0;
wtf(end)=0;

%thresh=mean(abs(data))*coef_thresh;
thresh_own=coef_thresh*std(data);
thresh=thresh_own; %max(thresh,thresh_own);


[pks,loc_p]=findpeaks(data,'minpeakheight',thresh*0.5);
[trs,loc_t]=findpeaks(-1.*data,'minpeakheight',thresh*0.5);
trs=-1.*trs;

%%
pks_trs=zeros(Nsamples,1);
pks_trs(loc_p)=pks;
pks_trs(loc_t)=trs;
dtf=diff(wtf);
m=1;n=1;
start_tf=[];end_tf=[];
for i=1:Nsamples-1
    if dtf(i)==1
        start_tf(m)=i;
        m=m+1;
    end
    if dtf(i)==-1
        end_tf(n)=i;
        n=n+1;
    end
end
Nwtf=min(length(start_tf),length(end_tf));
tag_HFO=[];
for i=1:Nwtf
    tag_HFO(i)=0;
    temp_HFO{i}=pks_trs(start_tf(i):end_tf(i));
    temp_pks=temp_HFO{i}(temp_HFO{i}>0);
    temp_trs=temp_HFO{i}(temp_HFO{i}<0);
    Npks=length(temp_pks);    
    Ntrs=length(temp_trs);  

    if (Npks>3)&&(Ntrs>3)
        tag_HFO(i)=1;
    end
end
start_tf(tag_HFO==0)=[];
end_tf(tag_HFO==0)=[];
Nwtf=min(length(start_tf),length(end_tf));

%%
%时间长度筛选 | duration screening

tag2_HFO=[];
for i=1:Nwtf
    tag2_HFO(i)=1;
    if (end_tf(i)-start_tf(i)>=Fs*0.5)||((end_tf(i)-start_tf(i)<=Fs*0.01))
        tag2_HFO(i)=0;
    end
end
start_tf(tag2_HFO==0)=[];
end_tf(tag2_HFO==0)=[];
% start_tf(start_tf>10)=start_tf(start_tf>10)-10;
% end_tf(end_tf<(Nsamples-10))=end_tf(end_tf<(Nsamples-10))+10;
Nwtf=min(length(start_tf),length(end_tf));
%%
%综合 | fuse all feature tags into one decision
n_wtf=zeros(1,Nsamples);
if Nwtf~=0
    for i=1:Nwtf
        n_wtf(start_tf(i):end_tf(i))=1;
    end
    n_wtf=n_wtf(1:Nsamples);
end
n_wtf=sign(mapminmax(3*n_wtf+tag_ll-0.5+tag_ee-0.5+2*tag_teo+tag_hil-0.5+2*tag_snr-0.5+2.5*tag_env-0.5));%综合 | fuse all feature tags into one decision
n_wtf(n_wtf<0)=0;
n_wtf=[0,n_wtf];
n_wtf(end)=0;
n_dtf=diff(n_wtf);
nm=1;nn=1;
start_tf=[];
end_tf=[];
for i=1:Nsamples
    if n_dtf(i)==1
        start_tf(nm)=i;
        nm=nm+1;
    end
    if n_dtf(i)==-1
        end_tf(nn)=i;
        nn=nn+1;
    end
end

Nwtf=min(length(start_tf),length(end_tf));
tag2_HFO=[];
for i=1:Nwtf
    tag2_HFO(i)=1;
    if (end_tf(i)-start_tf(i)>=Fs*0.5)||((end_tf(i)-start_tf(i)<=Fs*0.01))
        tag2_HFO(i)=0;
    end
end
start_tf(tag2_HFO==0)=[];
end_tf(tag2_HFO==0)=[];
Nwtf=min(length(start_tf),length(end_tf));

%%
%合并接近项、延长两端 | merge nearby segments and extend both ends
%    [ Nwtf,start_tf,end_tf ] = duanchuli( Nwtf,start_tf,end_tf,Nsamples);

%%

[start_tf,end_tf,Nf,Fo,mH,sH,P_HFO,F_HFO,MF_HFO,F_R,CI] = screen(start_tf,end_tf,tf,data+m_data,thresh,env,TTF,raw_data,NER);

Nwtf=min(length(start_tf),length(end_tf));
%新的窗 | new window (binary mask of detected segments)
 fn_wtf = NewWindow( Nsamples,Nwtf,start_tf,end_tf);


end