clc;clearvars -except mi;close all;
fileToRead = uigetfile('*.*', 'Pick a edf File Generated from NK data');

% 选择edf文档读入 | select and read the EDF file
name='subject01'; % prefix for the output .mat files
[hdr, record] = edfread(fileToRead);
global Fs;

%% 
  Fs=1000;
  
%2000hz
  Fs=2000;
  n_pass=[]; % indices of channels to exclude (bad or reference channels), e.g. n_pass=[10 24 37];

n_pass=sort(n_pass);

n_pole=88;%导联数量 | number of channels
%% 
% 参数设定 | parameter settings


%搜索区 | search region
mi=1;%第几分钟 | which minute to analyze
% search_left=1+60000*7.5;
% search_right=60000*9.5;
search_left=1+60*Fs*(mi-1);
search_right=60*Fs*mi;

global coef_thresh;%振荡峰阈值系数 | threshold coefficient for oscillation peaks
coef_thresh=5;
%% 
% 数据预处理 | data preprocessing
data=record(2:n_pole+1,search_left:search_right);
%双极导联 | bipolar montage
data_bipolar=record(2:n_pole,search_left:search_right)-record(3:n_pole+1,search_left:search_right);
%%
data_bipolar(n_pass,:)=[];
n_pole=n_pole-length(n_pass);
%%
%带通滤波 | band-pass filtering
disp('滤波');
global Flo;
Flo=80;%带通低频 | band-pass low cutoff
Fhi=249.4;%带通高频 | band-pass high cutoff
d=20;%d是陷波上下 | d is the lower/upper bound used for the notch
N=0.1*Fs;%FIR
F_TRAP=[50,100,150,200,249.4];%陷波 | notch frequencies
for i=1:n_pole-1
    data_wpd_t= FIR_BP(N,Fs,Flo,Fhi,data_bipolar(i,:));
    data_wpd_t(1:N)=data_wpd_t(N+1);
    data_wpd(i,:) = trap(Fs,F_TRAP,data_wpd_t);
    data_low_t= FIR_BP(N,Fs,d,Flo,data_bipolar(i,:));
    data_low_t(1:N)=data_low_t(N+1);
    data_low(i,:) = trap(Fs,F_TRAP,data_low_t);
    data_bipolar_t=FIR_BP(N,Fs,d,Fhi,data_bipolar(i,:));
    data_bipolar_t(1:N)=data_bipolar_t(N+1);
    data_bipolar_f(i,:) = trap(Fs,F_TRAP,data_bipolar_t);
    data_bipolar_f(i,1:N)=data_bipolar_f(i,N+1);
end
%%
%极值调整 | winsorization (clipping of extreme values)
disp('极值调整');
rate=0.0005;                             %极值调整率 | winsorization rate
for i=1:n_pole-1
    data_wpd_win(i,:)=winsorization(data_wpd(i,:),rate);
    data_low_win(i,:)=winsorization(data_low(i,:),rate);
end
%  data_wpd_win(:,1:500)=0;
%  data_low_win(:,1:500)=0;
%  data_bipolar_f(:,1:500)=0;
%%
%振荡峰阈值 | oscillation peak threshold
Nsamples = length(data);
% data_t=data_wpd_win;
% data_t=data_t-repmat(mean(data_wpd_win,2),1,Nsamples);
% data_t=data_t(:);
% thresh=coef_thresh*std(abs(data_t))+mean(abs(data_t));
% %%
data_t=data_wpd_win;
data_t=data_t(:);
data_t=data_t-mean(data_t);
thresh=coef_thresh*std(data_t);
clear data_t
%%
%信噪比&hurst | SNR and Hurst exponent
disp('信噪比');
for i=10%1:n_pole-1
    [tag_snr(i,:),tag_env(i,:),env(i,:)]=SNR(data_wpd_win(i,:),data_low_win(i,:),Fs);
   
end

%%
%GM频谱分析 | Gabor-Morlet time-frequency analysis
disp('GM频谱分析');

Flo_more =60;
Fhi = 250;
Nsteps = 100;
Bandwidth = 1/10;
global freq;
[freq gabor] = create_gabormorlet(Fs,Flo_more,Fhi,Nsteps,Bandwidth);
tf={};
for i=1:n_pole-1
    tf_temp  = gmfilterfast(data_bipolar_f(i,:),gabor);%data_bipolar_f
    tf= [tf,tf_temp];
end



%%
%特征提取 | feature extraction
disp('特征提取');
Ms=10;%特征平均滑动窗口长度 | sliding-window length for feature averaging

    [tag_ll,tag_ee,tag_teo,tag_hil] = FeatureExtraction(data_wpd_win,Ms);

%%
%HFO检测 | HFO detection
disp('HFO检测');
%n_pole=n_pole-length(n_pass);

Nsamples = length(data);
fn_wtf=[];start_tf={};end_tf={};
for i=1:n_pole-1
    mtf(i,:)=max(tf{i}(freq>Flo,:));
end
t_mtf=mtf;
PHFO=[];
t_mtf(PHFO,:)=[];
[b_mtf,x_mtf]=hist(t_mtf(:),1000);
clear t_mtf;
y_mtf=cumsum(b_mtf/Nsamples/(n_pole-1-length(PHFO)));
threshold_mtf=min(x_mtf(y_mtf>0.95));
TTF1=min(x_mtf(y_mtf>0.975));
TTF2=min(x_mtf(y_mtf>0.975));
%%
for i=1:n_pole-1
    if any(PHFO==i)
        continue     
    end
    [fn_wtf(i,:),start_temp,end_temp,Nf{i},Fo{i},mH{i},sH{i}]=HFOdetection(data_wpd_win(i,:),data_bipolar_f(i,:),tag_ll(i,:),tag_ee(i,:),tag_teo(i,:),tag_hil(i,:),tag_snr(i,:),tag_env(i,:),tf{i},Fs,thresh,threshold_mtf,env(i,:),TTF2);
    start_tf{i}=start_temp;
    end_tf{i}=end_temp;
%     start_ts{i}=start_ts_temp;
%     end_ts{i}=end_ts_temp;
end
%%
for i=1:length(n_pass)
    tf=[tf(1:n_pass(i)-1),zeros(size(tf_temp)),tf(n_pass(i):end)];
%     start_ts=[start_ts(1:n_pass(i)-1),{[]},start_ts(n_pass(i):end)];
%     end_ts=[end_ts(1:n_pass(i)-1),{[]},end_ts(n_pass(i):end)];
%     fn_wts=[fn_wts(1:n_pass(i)-1,:);zeros(1,Nsamples);fn_wts(n_pass(i):end,:)];
    start_tf=[start_tf(1:n_pass(i)-1),{[]},start_tf(n_pass(i):end)];
    end_tf=[end_tf(1:n_pass(i)-1),{[]},end_tf(n_pass(i):end)];
    fn_wtf=[fn_wtf(1:n_pass(i)-1,:);zeros(1,Nsamples);fn_wtf(n_pass(i):end,:)];
    Nf=[Nf(1:n_pass(i)-1),{[]},Nf(n_pass(i):end)];
    Fo=[Fo(1:n_pass(i)-1),{[]},Fo(n_pass(i):end)];
    mH=[mH(1:n_pass(i)-1),{[]},mH(n_pass(i):end)];
    sH=[sH(1:n_pass(i)-1),{[]},sH(n_pass(i):end)];
    env=[env(1:n_pass(i)-1,:);zeros(1,Nsamples);env(n_pass(i):end,:)];
    data_wpd_win=[data_wpd_win(1:n_pass(i)-1,:);zeros(1,Nsamples);data_wpd_win(n_pass(i):end,:)];
    data_wpd=[data_wpd(1:n_pass(i)-1,:);zeros(1,Nsamples);data_wpd(n_pass(i):end,:)];
    data_bipolar_f=[data_bipolar_f(1:n_pass(i)-1,:);zeros(1,Nsamples);data_bipolar_f(n_pass(i):end,:)];
end
num_HFO=0;
n_pole=n_pole+length(n_pass);

for i=1:n_pole-1
%     num_HFO(i)=length(start_ts{i});
    num_HFO(i)=length(start_tf{i});
end
% num_HFO=num_HFO';
num_HFO=num_HFO';

sum(num_HFO)
%%
theta=[];delta=[];slow=[];
for i=1:length(Fo)
    theta=[theta;Fo{i}];
    delta=[delta;mH{i}];
    slow=[slow;sH{i}];
end
% rose(xiangwei)
save([name,'_angle_',num2str(mi),'.mat'],'theta','delta','slow');
%%
disp('片段输出');
Nsamples = length(data);
t = (1/Fs) * (1:Nsamples);
k=0.4*Fs;%前后延伸 | extension before and after the event

for j=1:n_pole-1
Nwtf=length(cell2mat(start_tf(j)));
start_t=cell2mat(start_tf(j));
end_t=cell2mat(end_tf(j));
tf_temp=tf{j};
l=end_t-start_t;
if isempty(start_t)==0 
for i=1:(length(start_t))
    
    if (l(i)<Fs)&&(start_t(i)>k)&&(end_t(i)<(Nsamples-Fs+l(i)+k))
        start_temp(i)=start_t(i)-k;
        end_temp(i)=end_t(i)+Fs-l(i)-k;
    else if end_t(i)+Fs-l(i)-k>Nsamples
        start_temp(i)=start_t(i)-Fs+l(i);
        end_temp(i)=end_t(i);
        end
    end

figure('Visible','off');
% set (gcf,'Position',[0,50,1900,900], 'color','w') 

pd1=subplot(3,1,1);
    plot(t(start_temp(i):end_temp(i)),data_bipolar_f(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('biopolar iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data_bipolar_f(j,start_temp(i):end_temp(i))),max( data_bipolar_f(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data_bipolar_f(j,start_temp(i):end_temp(i))),max( data_bipolar_f(j,start_temp(i):end_temp(i)))],'r')
    hold off
pd2=subplot(3,1,2);
 plot(t(start_temp(i):end_temp(i)),data_wpd(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data_wpd(j,start_temp(i):end_temp(i))),max( data_wpd(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data_wpd(j,start_temp(i):end_temp(i))),max( data_wpd(j,start_temp(i):end_temp(i)))],'r')
    hold off
%text(0,0,['正向峰数：',num2str(Nf{j}(1,i)),' ','负向峰数：',num2str(Nf{j}(2,i))],'Units','normalized'); | text labels, number of positive peaks / number of negative peaks
%text(0,0,['mH：',num2str(mH{j}(i,:)),' ','sH：',num2str(sH{j}(2,i))],'Units','normalized'); | text labels, mH / sH

pd3=subplot(3,1,3);
plotTimeFreq(tf_temp(:,(start_temp(i):end_temp(i))), start_temp(i)/Fs, end_temp(i)/Fs, 0.5, freq(1), freq(end), 30);
hold on
plot([t(start_t(i)),t(start_t(i))],[0,Nsteps],'r')
plot([t(end_t(i)),t(end_t(i))],[0,Nsteps],'r')
hold off

%tag_ts(i)=sign(sum(fn_wts(j,start_temp(i):end_temp(i))));

linkaxes([pd1,pd2,pd3],'x')
set(gcf,'position',[200,300,600,400]);
print(gcf,[num2str(j),'_',num2str(i)],'-depsc','-r600');
zoom on
end
end
end

zip('HFOeps','*.eps');
delete('*.eps');

save([name,'_',num2str(mi)],'fn_wtf','data_wpd_win','data_bipolar_f','tf')
  beep;
 %clc;clearvars -except mi;
% %%
% 
% 
% %长段显示 | long-segment display
% disp('长段显示'); | disp('long-segment display')
% 
% [fn_size_a,fn_size_b]=size(fn_wtf);
% channel=1:10;%这里要设置为要看的探针上的导联号 | set this to the channel indices on the probe to inspect
% output=[(fn_wtf(channel,:)'*2-1).*repmat(max(abs(data_wpd_win(channel,:)')),fn_size_b,1),data_wpd_win(channel,:)'];
% T=array2table(output);
% fn_size_a=length(channel);
% name={};
% for i=1:fn_size_a
%     name_temp={['output',num2str(i)],['output',num2str(i+fn_size_a)]};
%     name=[name,{name_temp}];
% end
% 
% figure(111);
% stackedplot(T,name)
% 
% 
% %%
% %各道显示 | per-channel display
% disp('单道显示'); | disp('single-channel display')
% Nsamples = length(data_bipolar_f);
% t = (1/Fs) * (1:Nsamples);
% 
% j=8;%导联号 | channel index
% 
% figure(2); dd1=subplot(3,1,1);
% plot(t,[data_bipolar_f(j,:);mapminmax(fn_wtf(j,:),min(data_bipolar_f(j,:)),max(data_bipolar_f(j,:)))]), axis tight
% xlabel('Time (sec)'), ylabel('Amplitude'), title('bipolar iEEG Data');
% dd2=subplot(3,1,2);
% plot(t,[data_wpd_win(j,:);mapminmax(fn_wtf(j,:),min(data_wpd_win(j,:)),max(data_wpd_win(j,:)))]), axis tight
% xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
% dd3=subplot(3,1,3);
% plotTimeFreq(tf{j}, 0, Nsamples/Fs, 0.5, freq(1), freq(end), 10);
% hold on
% plot(t,fn_wtf(j,:)*Nsteps,'r')
% hold off
% linkaxes([dd1,dd2,dd3],'x')
% % 
