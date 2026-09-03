function [ Nwtf,start_tf,end_tf ] = duanchuli( Nwtf,start_tf,end_tf,Nsamples)
%选段处理 | segment post-processing
%   太近的段合并，两端延长 | merge segments that are too close and extend both ends
global Fs;
temp_HFO=[];

for i=1:Nwtf-1
    temp_HFO(i)=1;
    if (start_tf(i+1)-end_tf(i)<=Fs*0.005)
        temp_HFO(i)=0;
    end
 
end
  a=[1 temp_HFO];
start_tf(a==0)=[];
end_tf(temp_HFO==0)=[];
Nwtf=min(length(start_tf),length(end_tf));
for i=1:Nwtf
   if (end_tf(i)-start_tf(i)<=Fs*0.01)&&(start_tf(i)>Fs*0.01)&&(end_tf(i)<(Nsamples-Fs*0.01))
   start_tf(i)=start_tf(i)-Fs*0.005;
    end_tf(i)=end_tf(i)+Fs*0.005;
   end
end


end

