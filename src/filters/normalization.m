function [data_nom]=normalization(data,rate)


sign_data=sign(data);


%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp_data=[];
temp_data=data;
nTime=int32(size(temp_data,1));%nTime时间长度 | nTime is the number of time samples
nMin=int32(nTime*rate);              
nMax=int32(nTime*(1-rate)); 
temp=zeros(nTime,1);index=zeros(nTime,1);

[temp,index]=sort(temp_data);

for i=1:nMin
    temp_data(index(i))=temp(nMin);
end
for i=nMax:nTime
    temp_data(index(i))=temp(nMax);
end

%%
temp_data=temp_data*1000000;
temp_data=abs(temp_data);
data_nom=100./(1+100*exp(-0.12.*temp_data));
temp_data=sign_data.*data_nom;
data_nom=temp_data;

end

%save data_wpd_winsorize data_wpd_winsorize
%save data_winsorize data_winsorize




