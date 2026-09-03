load events_annotated.mat; % gold-standard events for the analyzed channels (events.samples, 2 x N)
a=events.samples;
%  start_gold=a(1,:);
%  end_gold=a(2,:);
start_gold=a(1,1:110);
end_gold=a(2,1:110);
start_gold=start_gold-60000+400;
end_gold=end_gold-60000+400;
HFO_gold=zeros(1,length(data));
for i=1:length(start_gold)
    HFO_gold(start_gold(i):end_gold(i))=1;
end
k=41;
start_test=start_tf{k};
end_test=end_tf{k};
acc=[];pp=[];
for i=1:length(start_gold)
    if sum(fn_wtf(k,start_gold(i):end_gold(i)))>0
        acc(i)=1;
    else acc(i)=0;
    end
end
for i=1:length(start_test)
    if sum(HFO_gold(start_test(i):end_test(i)))>0
        pp(i)=1;
    else pp(i)=0;
    end
end
ss_event=sum(acc)/length(start_gold)
ss=sum((fn_wtf(k,:)).*(HFO_gold))/sum(HFO_gold)
sp=sum((1-fn_wtf(k,:)).*(1-HFO_gold))/sum(1-HFO_gold)
ppv=sum(pp)/length(start_test)
%%
% Nsamples = length(data);
% t = (1/Fs) * (1:Nsamples);
% j=k;
% figure(2); 
% ax1=subplot(3,1,1);
% plot(t,[data_bipolar(j,:);mapminmax(HFO_gold,min(data_bipolar(j,:)),max(data_bipolar(j,:)));mapminmax(fn_wtf(j,:),min(data_bipolar(j,:)),max(data_bipolar(j,:)))]), axis tight
% xlabel('Time (sec)'), ylabel('Amplitude'), title('bipolar iEEG Data');
% ax2=subplot(3,1,2);
% plot(t,[data_wpd_win(j,:);mapminmax(HFO_gold,min(data_wpd_win(j,:)),max(data_wpd_win(j,:)));mapminmax(fn_wtf(j,:),min(data_wpd_win(j,:)),max(data_wpd_win(j,:)))]), axis tight
% xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
% ax3=subplot(3,1,3);
% plotTimeFreq(tf{j}, 0, Nsamples/Fs, 0.5, freq(1), freq(end), 10);
% hold on
% plot(t,[HFO_gold*Nsteps;fn_wtf(j,:)*Nsteps],'r')
% linkaxes([ax1,ax2,ax3],'x')
% hold off

%%
load HFO.mat;
load TorF.mat;
S=HFO{1};
E=HFO{2};
TP=0;FP=0;FN=0;
name='lyc';
for i=1:length(TorF)
    if ~isempty(TorF{i})
        for j=1:length(TorF{i})
            switch TorF{i}(j)
                case 1
                    TP=TP+E{i}(j)-S{i}(j)+1;
                case 0
                    FP=FP+E{i}(j)-S{i}(j)+1;
            end
        end
    end
    if exist([name,num2str(i)])
        eval(['FN=FN+length(',[name,num2str(i)],');']);
    end
end
load window.mat;
TN=size(window,1)*size(window,2)-sum(sum(window))-FN;
SP=TN/(TN+FP);