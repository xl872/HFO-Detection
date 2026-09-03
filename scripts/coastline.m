function coastline()
clc;clear all;close all;
n=input('导联数：');
Fs=input('采样频率(Hz)：');
left=input('起始时间(s)：');
right=input('结束时间(s)：');
fileToRead = uigetfile('*.*', 'Pick a edf File Generated from NK data');
[record,hdr] = readedf(fileToRead);
data=record(:,left*Fs+1:right*Fs);
for i=1:n
    CI(i)=sum(abs(diff(data(i,:))));
    m_CI(i)=CI(i)/length(data(i,:))*Fs;
    fprintf('导联%d的每秒平均CI为%.2f\n',i,m_CI(i));
end
end