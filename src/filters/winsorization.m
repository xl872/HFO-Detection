function [data_win]=winsorization(data,rate)


%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp_data=[];
temp_data=data;
nTime=length(temp_data);%nTime时间长度 | nTime is the number of time samples
nMin=floor(nTime*rate);              
nMax=floor(nTime*(1-rate)); 
temp=zeros(nTime,1);index=zeros(nTime,1);


[temp,index]=sort(temp_data);

for i=1:nMin
    temp_data(index(i))=temp(nMin);
end
for i=nMax:nTime
    temp_data(index(i))=temp(nMax);
end
data_win=temp_data;
end