function [start_temp,end_temp,N,Fo,mH,sH,P_HFO,F_HFO,MF_HFO,F_R,CI] = screen(start_temp,end_temp,tf,data,thresh,env,TTF,raw_data,NER)
%screen 筛选更置信的HFO | screen keeps the more confident HFO candidates
%   SD_COEF是幅度阈值系数（峰值倍数） | SD_COEF is the amplitude threshold coefficient (multiple of the peak)
%   STEP是峰间距阈值步长 | STEP is the step size of the peak-interval threshold
Nwtf=min(length(start_temp),length(end_temp));
tag_HFO=[];temp_Npks=[];temp_Ntrs=[];Fo=[];mH=[];sH=[];P_HFO=[];F_HFO=[];MF_HFO=[];F_R=[];N=[];CI=[];
global freq;global Flo;global Fs; global spike;
mtf=max(tf(freq>Flo,:));
m_data=mean(data);
data=data-m_data;
W=ones(1,length(data));
if spike
    [~,W] = spike_detection(raw_data,Fs);
    if isempty(W)
        W=zeros(1,length(data));
    end
end
    [yupper,ylower]=envelope(data,0.01*Fs,'peak');
    e=yupper-ylower;
    
temp_low=FIR_BP(0.1*Fs,Fs,5,10,raw_data);
for i=1:Nwtf
    tag_HFO(i)=0;temp_Npks(i)=0;temp_Ntrs(i)=0;Fo(i,[1:2])=0;mH(i,[1:2])=0;sH(i,[1:2])=0;P_HFO(i)=0;F_HFO(i)=0;MF_HFO(i)=0;F_R(i)=0;N(i,[1:10])=0;CI(i)=0;
    %mH(i)=zeros(1,20);sH(i)=zeros(1,20);
    if (end_temp(i)-start_temp(i)<(Fs/Flo*4))||(start_temp(i)<=0.4*Fs)||(end_temp(i)>=(length(data)-0.6*Fs))||(end_temp(i)-start_temp(i)>0.4*Fs)%||(abs(mean(raw_data(start_temp(i)-0.1*Fs:start_temp(i)))-mean(raw_data(end_temp(i):end_temp(i)+0.1*Fs)))>0.5*(max(raw_data(start_temp(i):end_temp(i)))-min(raw_data(start_temp(i):end_temp(i)))))%这里0.1*Fs是FIR里的N参数 | here 0.1*Fs is the N parameter of the FIR filter
        continue
    end
     %棘慢波检测 | spike-and-slow-wave detection
%     [~,I]= max(data(start_temp(i):end_temp(i)));
%     if (start_temp(i)+I+0.02*Fs)<end_temp(i)
%         [pks_t,loc_pks]=findpeaks(raw_data(start_temp(i)+I-0.02*Fs:start_temp(i)+I+0.02*Fs));
%         [trs_t,loc_trs]=findpeaks(-1.*raw_data(start_temp(i)+I-0.02*Fs:start_temp(i)+I+0.02*Fs));  
%     else
%         [pks_t,loc_pks]=findpeaks(raw_data(start_temp(i)+I-0.02*Fs:end_temp(i)));
%         [trs_t,loc_trs]=findpeaks(-1.*raw_data(start_temp(i)+I-0.02*Fs:end_temp(i))); 
%     end
%     if (length(pks_t)==2)&&(length(trs_t)==1)
%         if(loc_pks(1)<loc_trs)&&(loc_trs<loc_pks(2))&&((pks_t(1)-trs_t)<0.1*(pks_t(2)-trs_t))     
%             continue
%         end
%     end  

    
    [temp_pks,temp_loc_pks]=findpeaks(data(start_temp(i):end_temp(i)),'minpeakheight',0.5*thresh);
    befor_pks=findpeaks(data(start_temp(i)-0.2*Fs:start_temp(i)),'minpeakheight',0.4*thresh);
    if end_temp(i)+0.1*Fs<=length(data)
        after_pks=findpeaks(data(end_temp(i):end_temp(i)+0.2*Fs),'minpeakheight',0.4*thresh);
    else 
        after_pks=[];
    end    
    [temp_trs,temp_loc_trs]=findpeaks(-1.*data(start_temp(i):end_temp(i)),'minpeakheight',0.5*thresh);  
    Npks(i)=length(temp_pks);    
    Ntrs(i)=length(temp_trs);        
    %t_tf=max(tf(:,start_temp(i):end_temp(i)),[],2);%plot(freq,t_tf);
%     t=floor(0.5*Fs-end_temp(i)+start_temp(i))/2;
    temp=tf(:,start_temp(i)-floor((0.5*Fs-end_temp(i)+start_temp(i)-1)/2):end_temp(i)+ceil((0.5*Fs-end_temp(i)+start_temp(i)-1)/2));
    Nx=10;      
   Ntt=mapminmax(temp,0,1);
    for j=1:100/Nx
        for jj=1:10
            Nt(j,jj)=sum(sum(Ntt(Nx*(j-1)+1:Nx*j,0.5*Fs/10*(jj-1)+1:0.5*Fs/10*jj)));
        end
    end
    Nt=sign(Nt-mean(mean(Nt)));
    Nt(Nt<0)=0;
    N(i,:)=[512,256,128,64,32,16,8,4,2,1]*Nt;
    t_tf=max(temp,[],2);%t_tf=nanmean(temp,2);%plot(freq,t_tf);
    [row,~]=find(temp==max(max(temp)));
    [pks,loc_p]=findpeaks(t_tf,'minpeakheight',TTF);
    if  (~isempty(pks))&&((Npks(i)>=3)||(Ntrs(i)>=3))&&(max(abs(data(start_temp(i):end_temp(i))))>0.8*thresh)...
            &&(max(W(start_temp(i):end_temp(i)))>0||mean(raw_data(start_temp(i):end_temp(i)))-mean(raw_data([start_temp(i)-0.2*Fs:start_temp(i),end_temp(i):end_temp(i)+0.2*Fs]))>2*std(raw_data))...
        &&(max(diff([0,find(diff(temp_loc_pks)>(1.2*Fs/Flo)),Npks(i)]))>=3||max(diff([0,find(diff(temp_loc_trs)>(1.2*Fs/Flo)),Ntrs(i)]))>=3)
        

        if (freq(loc_p(end))>=Flo+1)&&((length(befor_pks)<Flo/7)||(length(after_pks)<Flo/7))&&(NER==0||(max(env(start_temp(i):end_temp(i)))>(3*median(env([max(1,start_temp(i)-0.25*Fs):start_temp(i),end_temp(i):min(end_temp(i)+0.25*Fs,length(data))])))))%&&(temp_Npks(i)>=3)&&(temp_Ntrs(i)>=3)
            %&&mean(befor_pks)<0.25*mean(temp_pks)%(STEPpks<STEP)&&(STEPtrs<STEP)&&(m_mtf>TTF)&&
            %&&(freq(row)>61)%&&mean(befor_pks)<0.5*mean(temp_pks)%%&&(SDpks<SD_COEF)&&(SDtrs<SD_COEF)
        %if (STEPpks<STEP)&&(STEPtrs<STEP)&&(m_mtf>TTF)&&(find(max(t_tf))>min(find(freq>Flo)))
            
            %THETA1-3,DELTA4-7
            
            
            %renew startPoint
            e_max=max(e(start_temp(i):end_temp(i)));
            if e(start_temp(i))<(e_max/2)
               start_temp(i)= find(e(start_temp(i):end_temp(i))>=(e_max/2),1,'first')+start_temp(i)-1;
            else
               start_temp(i)= find(e(1:start_temp(i))<=(e_max/2),1,'last');
            end
            if e(end_temp(i))<(e_max/2)
              end_temp(i)= find(e(start_temp(i):end_temp(i))>=(e_max/2),1,'last')+start_temp(i)-1;
            else
               end_temp(i)= find(e(end_temp(i):end)<=(e_max/2),1,'first')+end_temp(i)-1;
            end
                         
            
            theta=bandpass(raw_data(start_temp(i):end_temp(i)),[1,3],Fs);
            delta=bandpass(raw_data(start_temp(i):end_temp(i)),[4,7],Fs);
            slow=bandpass(raw_data(start_temp(i):end_temp(i)),[0.5,7],Fs);
            y=[];
            y=hilbert(theta);
            y=y./abs(y);
            Fo(i,1)=sum(y.*data(start_temp(i):end_temp(i)));Fo(i,2)=angle(Fo(i,1));%mean(angle(y))*180/pi;%theta
            y=[];
            y=hilbert(delta);y=y./abs(y);
            mH(i,1)=sum(y.*data(start_temp(i):end_temp(i)));mH(i,2)=angle(mH(i,1));%mean(angle(y))*180/pi;%delta
            y=[];
            y=hilbert(slow);y=y./abs(y);
            sH(i,1)=sum(y.*data(start_temp(i):end_temp(i)));sH(i,2)=angle(sH(i,1));%mean(angle(y))*180/pi;%slow
            
            P_HFO(i)=20*log10(max(abs(data(start_temp(i):end_temp(i))+m_data)));
            [~,time]=find(tf==max(max(temp)));
            [~,F_p]=findpeaks(tf(:,time),'minpeakheight',0.8*max(max(temp)));%
            if isempty(F_p)
                continue
            end
            F_HFO(i)=freq(F_p(end));
            
            temp=tf(freq>Flo,start_temp(i):end_temp(i));
            temp=temp/sum(sum(temp));
            MF_HFO(i)=sum(freq(freq>Flo)*temp);

            n=0:1999;
            y=fft(temp_low(start_temp(i):end_temp(i)),length(n));    %对信号进行快速Fourier变换 | FFT of the signal
            mag=abs(y);     %求得Fourier变换后的振幅 | magnitude of the Fourier transform
            f=n*Fs/length(n);    %频率序列 | frequency vector
            [~,L_HFO]=max(mag(f>=5&f<=10));
            L_HFO=f(L_HFO+find(f>=5,1)-1);
            F_R(i)=F_HFO(i)/L_HFO;
            tag_HFO(i)=1;
            
            CI(i)=sum(diff(data(start_temp(i):end_temp(i))))/length(data(start_temp(i):end_temp(i)));%海岸线参数 | coastline index (CI)
            


           
        end
    end   
end
if ~isempty(find(tag_HFO==0))
    
start_temp(tag_HFO==0)=[];
end_temp(tag_HFO==0)=[];
%temp_Npks(temp_Npks==0)=[];
%temp_Ntrs(temp_Ntrs==0)=[];
N(tag_HFO==0,:)=[];%nengliangtezheng
Fo(tag_HFO==0,:)=[];
mH(tag_HFO==0,:)=[];
sH(tag_HFO==0,:)=[];
P_HFO(tag_HFO==0)=[];
F_HFO(tag_HFO==0)=[];
MF_HFO(tag_HFO==0)=[];
F_R(tag_HFO==0)=[];
CI(tag_HFO==0)=[];
end
end

