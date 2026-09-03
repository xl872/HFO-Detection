function [tag_wtf_ll,tag_wtf_ee,tag_wtf_teo,tag_wtf_hil] = FeatureExtraction(data_wpd_winsorize,Ms)
%特征筛选法 | feature-based screening
%   此处显示详细说明 | MATLAB template placeholder, detailed explanation goes here
[n_pole,Nsamples] = size(data_wpd_winsorize);
ll=abs(diff(data_wpd_winsorize,1,2));
ee=data_wpd_winsorize.^2;
teo=data_wpd_winsorize.^2-[zeros(n_pole,1),data_wpd_winsorize(:,2:Nsamples).*data_wpd_winsorize(:,1:Nsamples-1)];
hil=abs(hilbert(data_wpd_winsorize));

tag_ll=zeros(n_pole,Nsamples);
tag_ee=zeros(n_pole,Nsamples);
tag_teo=zeros(n_pole,Nsamples);
tag_hil=zeros(n_pole,Nsamples);

for i=1:(Nsamples-Ms)
    t_ll(:,i)=mean(ll(:,i:i+Ms-2),2);
    t_ee(:,i)=mean(ee(:,i:i+Ms-1),2);
    t_teo(:,i)=mean(teo(:,i:i+Ms-1),2);
    t_hil(:,i)=mean(hil(:,i:i+Ms-1),2);
end

for i=1:n_pole
    t_hil(i,:)=abs(t_hil(i,:)-mean(t_hil(i,:)));
end

clear ll ee teo hil;
%%
[b_ll,x_ll]=hist(t_ll(:),100);
y_ll=cumsum(b_ll/Nsamples/n_pole);
threshold_ll=min(x_ll(y_ll>0.75));
[b_ee,x_ee]=hist(t_ee(:),100);
y_ee=cumsum(b_ee/Nsamples/n_pole);
threshold_ee=min(x_ee(y_ee>0.75));
[b_teo,x_teo]=hist(t_teo(:),100);
y_teo=cumsum(b_teo/Nsamples/n_pole);
threshold_teo=min(x_teo(y_teo>0.75));
[b_hil,x_hil]=hist(t_hil(:),100);
y_hil=cumsum(b_hil/Nsamples/n_pole);
threshold_hil=min(x_hil(y_hil>0.75));
for j=1:n_pole
for i=1:(Nsamples-Ms)
   if t_ll(j,i)>threshold_ll
        tag_ll(j,i:i+Ms-1)=1;
    end
    if t_ee(j,i)>threshold_ee
        tag_ee(j,i:i+Ms-1)=1;
    end
    if t_teo(j,i)>threshold_teo
        tag_teo(j,i:i+Ms-1)=1;
    end
    if t_hil(j,i)>threshold_hil
        tag_hil(j,i:i+Ms-1)=1;
    end
end
end
clear t_ll t_ee t_teo t_hil
dtf_ll=diff(tag_ll,1,2);
dtf_ee=diff(tag_ee,1,2);
dtf_teo=diff(tag_teo,1,2);
dtf_hil=diff(tag_hil,1,2);




for j=1:n_pole
    m_ll=0;n_ll=0;
    m_ee=0;n_ee=0;
    m_teo=0;n_teo=0;
    m_hil=0;n_hil=0;
    start_ll=[];end_ll=[];
    start_ee=[];end_ee=[];
    start_hil=[];end_hil=[];
    start_teo=[];end_teo=[];
    for i=1:Nsamples-1

        if dtf_ll(j,i)==1
            m_ll=m_ll+1;
            start_ll(m_ll)=i;        
        end
        if dtf_ll(j,i)==-1
            n_ll=n_ll+1;
            end_ll(n_ll)=i;        
        end

        if dtf_ee(j,i)==1
            m_ee=m_ee+1;
            start_ee(m_ee)=i;        
        end
        if dtf_ee(j,i)==-1
            n_ee=n_ee+1;
            end_ee(n_ee)=i;        
        end

        if dtf_teo(j,i)==1
            m_teo=m_teo+1;
            start_teo(m_teo)=i;        
        end
        if dtf_teo(j,i)==-1
            n_teo=n_teo+1;
            end_teo(n_teo)=i;        
        end

        if dtf_hil(j,i)==1
            m_hil=m_hil+1;
            start_hil(m_hil)=i;        
        end
        if dtf_hil(j,i)==-1
            n_hil=n_hil+1;
            end_hil(n_hil)=i;        
        end

    end


Nwtf_ll=length(start_ll);
Nwtf_ee=length(start_ee);
Nwtf_teo=length(start_teo);
Nwtf_hil=length(start_hil);

 [ Nwtf_ll,start_ll,end_ll ] = duanchuli( Nwtf_ll,start_ll,end_ll,Nsamples);
 [ Nwtf_ee,start_ee,end_ee ] = duanchuli( Nwtf_ee,start_ee,end_ee,Nsamples);
 [ Nwtf_teo,start_teo,end_teo ] = duanchuli( Nwtf_teo,start_teo,end_teo,Nsamples); 
 [ Nwtf_hil,start_hil,end_hil ] = duanchuli( Nwtf_hil,start_hil,end_hil,Nsamples); 

 [tag_wtf_ll(j,:)] = NewWindow( Nsamples,Nwtf_ll,start_ll,end_ll);
 [tag_wtf_ee(j,:)] = NewWindow( Nsamples,Nwtf_ee,start_ee,end_ee);
 [tag_wtf_teo(j,:)] = NewWindow( Nsamples,Nwtf_teo,start_teo,end_teo);
 [tag_wtf_hil(j,:)] = NewWindow( Nsamples,Nwtf_hil,start_hil,end_hil);
end
end

