function varargout = HFOgui(varargin)
% HFOGUI MATLAB code for HFOgui.fig
%      HFOGUI, by itself, creates a new HFOGUI or raises the existing
%      singleton*.
%
%      H = HFOGUI returns the handle to a new HFOGUI or the handle to
%      the existing singleton*.
%
%      HFOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HFOGUI.M with the given input arguments.
%
%      HFOGUI('Property','Value',...) creates a new HFOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HFOgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HFOgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HFOgui

% Last Modified by GUIDE v2.5 24-Oct-2020 21:44:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HFOgui_OpeningFcn, ...
                   'gui_OutputFcn',  @HFOgui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before HFOgui is made visible.
function HFOgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HFOgui (see VARARGIN)

% Choose default command line output for HFOgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HFOgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HFOgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_readEDF.
function pushbutton_readEDF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_readEDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 选择edf文档读入 | select and read the EDF file

fileToRead = uigetfile('*.*', 'Pick a edf File Generated from NK data');
% if get(handles.unipolar,'value')
%     [ record,hdr] = readedf(fileToRead);%单极导联 | monopolar montage
% elseif get(handles.bipolar,'value')
    [hdr, record] = edfread(fileToRead);%双极导联 | bipolar montage
% end
global Fs;
Fs=hdr.frequency(1);
Fs=round(Fs/100)*100;
set(handles.edit4,'string',num2str(Fs));
setappdata(0,'raw_record',record);
setappdata(0,'hdr',hdr);
set(handles.edit1,'string',fileToRead)

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_main.
function pushbutton_main_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global spike
spike=get(handles.spike,'value');
record=getappdata(0,'raw_record');
n_order=getappdata(0,'n_order');
n_pass=get(handles.edit2,'string');
n_pass=str2num(n_pass);
n_pass=sort(n_pass);
%n_pass=[12 22 32 40 48 56 66];
global n_pole;
n_start=get(handles.edit22,'string');
n_start=str2num(n_start);
n_pole=get(handles.edit3,'string');
n_pole=str2num(n_pole);
if ~isempty(n_order)
    record=record(n_order,:);
    n_pole=length(n_order);
    n_start=1;
end
% 参数设定 | parameter settings

global Fs;
Fs=get(handles.edit4,'string');
Fs=str2num(Fs);



%搜索区间 | search interval
mi_l=get(handles.edit5,'string');
mi_l=str2num(mi_l);
mi_r=get(handles.edit15,'string');
mi_r=str2num(mi_r);
% mi=2;%第几分钟 | mi=2; which minute to analyze
search_left=1+60*Fs*mi_l;
search_right=60*Fs*mi_r;
global coef_thresh;%振荡峰阈值系数 | threshold coefficient for oscillation peaks
coef_thresh=5;
%% 
% 数据预处理 | data preprocessing

if get(handles.unipolar,'value')
    data=record(n_start:n_start+n_pole-1,search_left:search_right);
    data_bipolar=data-repmat(mean(data),n_pole,1);%公共平均参考 | common average reference
    n_pole=n_pole+1;
elseif get(handles.noref,'value')
    data=record(n_start:n_start+n_pole-1,search_left:search_right);
    data_bipolar=data;%无参考 | no re-referencing
    n_pole=n_pole+1;
elseif get(handles.bipolar,'value') %双极导联参考 | bipolar reference
    data=record(n_start:n_start+n_pole-1,search_left:search_right);
    data_bipolar=record(n_start:n_start+n_pole-2,search_left:search_right)-record(n_start+1:n_start+n_pole-1,search_left:search_right);%双极导联 | bipolar montage
end
data_bipolar(n_pass,:)=[];
n_pole=n_pole-length(n_pass);
clear record
%%
%带通滤波 | band-pass filtering
disp('滤波');
global Flo;global Fhi;
Flo=get(handles.Flo,'string');%带通低频 | band-pass low cutoff
Flo=str2num(Flo);
Fhi=get(handles.Fhi,'string');%带通高频 | band-pass high cutoff
Fhi=str2num(Fhi);
d=20;%d是陷波上下 | d is the lower/upper bound used for the notch
N=0.1*Fs;%FIR
F_TRAP=[50,100,150,200,249.4];%陷波 | notch frequencies
for i=1:n_pole-1
    data_wpd_t= FIR_BP(N,Fs,Flo,Fhi,data_bipolar(i,:));
    data_wpd_t(1:N)=data_wpd_t(N+1);
    data_wpd(i,:) = trap(Fs,F_TRAP,data_wpd_t);
    data_low_t= FIR_BP(N,Fs,1,Flo,data_bipolar(i,:));
    data_low_t(1:N)=data_low_t(N+1);
    data_low(i,:) = trap(Fs,F_TRAP,data_low_t);
    data_bipolar_t=FIR_BP(N,Fs,0.1,Fhi,data_bipolar(i,:));
    data_bipolar_t(1:N)=data_bipolar_t(N+1);
    data_bipolar_f(i,:) = trap(Fs,F_TRAP,data_bipolar_t);
    data_bipolar_f(i,1:N)=data_bipolar_f(i,N+1);
end
%%
%极值调整 | winsorization (clipping of extreme values)
disp('极值调整');
rate=0.00005;                             %极值调整率 | winsorization rate
for i=1:n_pole-1
    data_wpd_win(i,:)=winsorization(data_wpd(i,:),rate);
    data_low_win(i,:)=winsorization(data_low(i,:),rate);
end
%%
% %振荡峰阈值 | oscillation peak threshold
 Nsamples = length(data);
% % data_t=data_wpd_win;
% % data_t=data_t-repmat(mean(data_wpd_win,2),1,Nsamples);
% % data_t=data_t(:);
% % thresh=coef_thresh*std(abs(data_t))+mean(abs(data_t));
data_t=data_wpd_win;
data_t=data_t(:);
data_t=data_t-mean(data_t);
thresh=coef_thresh*std(data_t);
clear data_t

%%
%信噪比&hurst | SNR and Hurst exponent
disp('信噪比');
for i=1:n_pole-1
    [tag_snr(i,:),tag_env(i,:),env(i,:)]=SNR(data_wpd_win(i,:),data_low_win(i,:),Fs);
   
end
%%
%GM频谱分析 | Gabor-Morlet time-frequency analysis


Flo_more =Flo-10;
Nsteps = 100;
Bandwidth = 1/10;
global freq;
[freq gabor] = create_gabormorlet(Fs,Flo_more,Fhi,Nsteps,Bandwidth);
tf={};
for i=1:n_pole-1
    tf_temp  = gmfilterfast(data_wpd_win(i,:),gabor);
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
%thresh=0;
%%
NER=get(handles.NER,'value');
for i=1:n_pole-1
    if any(PHFO==i)
        continue     
    end
    [fn_wtf(i,:),start_temp,end_temp,Nf{i},Fo{i},mH{i},sH{i},P_HFO{i},F_HFO{i},MF_HFO{i},F_R{i},CI{i}]=HFOdetection(data_wpd_win(i,:),data_bipolar_f(i,:),tag_ll(i,:),tag_ee(i,:),tag_teo(i,:),tag_hil(i,:),tag_snr(i,:),tag_env(i,:),tf{i},Fs,NER,threshold_mtf,env(i,:),TTF2);
    start_tf{i}=start_temp;
    end_tf{i}=end_temp;
%     start_ts{i}=start_ts_temp;
%     end_ts{i}=end_ts_temp;
end

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
    P_HFO=[P_HFO(1:n_pass(i)-1),{[]},P_HFO(n_pass(i):end)];
    F_HFO=[F_HFO(1:n_pass(i)-1),{[]},F_HFO(n_pass(i):end)];
    MF_HFO=[MF_HFO(1:n_pass(i)-1),{[]},MF_HFO(n_pass(i):end)];
    F_R=[F_R(1:n_pass(i)-1),{[]},F_R(n_pass(i):end)];
    CI=[CI(1:n_pass(i)-1),{[]},CI(n_pass(i):end)];
    env=[env(1:n_pass(i)-1,:);zeros(1,Nsamples);env(n_pass(i):end,:)];
    data_wpd_win=[data_wpd_win(1:n_pass(i)-1,:);zeros(1,Nsamples);data_wpd_win(n_pass(i):end,:)];
    data_wpd=[data_wpd(1:n_pass(i)-1,:);zeros(1,Nsamples);data_wpd(n_pass(i):end,:)];
    data_bipolar_f=[data_bipolar_f(1:n_pass(i)-1,:);zeros(1,Nsamples);data_bipolar_f(n_pass(i):end,:)];
    data_bipolar=[data_bipolar(1:n_pass(i)-1,:);zeros(1,Nsamples);data_bipolar(n_pass(i):end,:)];
    data_low_win=[data_low_win(1:n_pass(i)-1,:);zeros(1,Nsamples);data_low_win(n_pass(i):end,:)];
end

num_HFO=0;%num_HFO_more=0;n_pole=n_pole+length(n_pass);
n_pole=n_pole+length(n_pass);
for i=1:n_pole-1
    num_HFO(i)=length(start_tf{i});
    %num_HFO_more(i)=length(start_tf{i});
    TorF{i}=ones(1,min(length(start_tf{i}),length(end_tf{i})));
    ED{i}=zeros(1,min(length(start_tf{i}),length(end_tf{i})));
end
num_HFO=num_HFO';
%num_HFO_more=num_HFO_more';
%sum(num_HFO)
output_sum=sum(num_HFO);
set(handles.edit6,'string',num2str(output_sum));
set(handles.popupmenu1,'string',num2str([1:n_pole-1]'));
set(handles.popupmenu1,'value',1);
pole=get(handles.popupmenu1,'value');
set(handles.popupmenu2,'string',num2str([1:num_HFO(pole)]'));
AllData.data_bipolar_f=data_bipolar_f;
AllData.data_bipolar=data_bipolar;
AllData.data_wpd_win=data_wpd_win;
AllData.data_low=data_low_win;
AllData.tf=tf;
AllData.start_tf=start_tf;
AllData.end_tf=end_tf;
AllData.Nf=Nf;
AllData.fn_wtf=fn_wtf;
AllData.TorF=TorF;
AllData.ED=ED;
AllData.num_HFO=num_HFO;
AllData.angle_theta=Fo;
AllData.angle_delta=mH;
AllData.angle_slow=sH;
AllData.P_HFO=P_HFO;
AllData.F_HFO=F_HFO;
AllData.MF_HFO=MF_HFO;
AllData.F_R=F_R;
AllData.CI=CI;
setappdata(0,'AllData',AllData);
disp('完成');
function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function rawEEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rawEEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate rawEEG


% --- Executes on button press in pushbutton_showmany.
function pushbutton_showmany_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_showmany (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('长段显示');
global Fs;
AllData=getappdata(0,'AllData');

% left=str2double(get(handles.edit7,'string'));
% right=str2double(get(handles.edit8,'string'));
channel=str2num(get(handles.edit7,'string'));%left:right;%这里要设置为要看的探针上的导联号 | set this to the channel indices on the probe to inspect
[~,fn_size_b]=size(AllData.fn_wtf);fn_size_a=length(channel);
output=[((AllData.fn_wtf(channel,:)').*repmat(max((AllData.data_wpd_win(channel,:)'))-min((AllData.data_wpd_win(channel,:)')),fn_size_b,1) ...
    +repmat(min((AllData.data_wpd_win(channel,:)')),fn_size_b,1)),AllData.data_wpd_win(channel,:)',repmat((1:fn_size_b)'/Fs,1,fn_size_a)];
T=array2table(output);

name={};
for i=1:fn_size_a
    name_temp={['output',num2str(i)],['output',num2str(i+fn_size_a)]};
    name=[name,{name_temp}];
end

figure(1);
hdr=getappdata(0,'hdr');
n_order=getappdata(0,'n_order');
if isempty(n_order)
    n_start=get(handles.edit22,'string');
    n_start=str2num(n_start);
    n_pole=get(handles.edit3,'string');
    n_pole=str2num(n_pole);
    n_order=n_start:n_pole+n_start-1;
end

if isfield(hdr,'label')
label=hdr.label;
else 
label=num2cell(1:size(AllData.data_wpd_win,1));
end

stackedplot(T,name,'DisplayLabels',label(n_order(channel)),'XVariable',['output',num2str(fn_size_a*3)])


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_showone.
function pushbutton_showone_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_showone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('单道显示');
AllData=getappdata(0,'AllData');
global Fs;global freq;global coef_thresh;
data=AllData.data_wpd_win;
Nsamples = length(data);
t = (1/Fs) * (1:Nsamples);
Nsteps = 100;
data_bipolar=AllData.data_bipolar_f;
data_low=AllData.data_low;
hdr=getappdata(0,'hdr');
n_order=getappdata(0,'n_order');
if isempty(n_order)
    n_start=get(handles.edit22,'string');
    n_start=str2num(n_start);
    n_pole=get(handles.edit3,'string');
    n_pole=str2num(n_pole);
    n_order=n_start:n_pole+n_start-1;
end
if isfield(hdr,'label')
label=hdr.label;
else 
label=1:size(data,1);
end


fn_wtf=AllData.fn_wtf;
data_wpd_win=AllData.data_wpd_win;
tf=AllData.tf;
j=str2num(get(handles.edit9,'string'));%导联号 | channel index
setappdata(0,'one_signal',j);
%figure(2); dd1=subplot(3,1,1);
axes(handles.rawEEG);
plot(t,[data_bipolar(j,:);mapminmax(fn_wtf(j,:),min(data_bipolar(j,:)),max(data_bipolar(j,:)))]), axis tight
xlabel('Time (sec)'), ylabel('Amplitude'), title(label(n_order(j)));

axes(handles.LowPass);
plot(t,[data_low(j,:);mapminmax(fn_wtf(j,:),min(data_low(j,:)),max(data_low(j,:)))]), axis tight
xlabel('Time (sec)'), ylabel('Amplitude'), title('lowpass iEEG Data');

% dd2=subplot(3,1,2);
axes(handles.BandPass);
plot(t,[data_wpd_win(j,:);mapminmax(fn_wtf(j,:),min(data_wpd_win(j,:)),max(data_wpd_win(j,:))); ...
    ones(1,length(t))*(0.4*coef_thresh*std(data_wpd_win(j,:))+mean(data_wpd_win(j,:))); ...
    ones(1,length(t))*(-0.4*coef_thresh*std(data_wpd_win(j,:))+mean(data_wpd_win(j,:))); ...
    ones(1,length(t))*(0.5*coef_thresh*std(data_wpd_win(j,:))+mean(data_wpd_win(j,:))); ...
    ones(1,length(t))*(-0.5*coef_thresh*std(data_wpd_win(j,:))+mean(data_wpd_win(j,:))); ...
    ones(1,length(t))*(0.8*coef_thresh*std(data_wpd_win(j,:))+mean(data_wpd_win(j,:))); ...
    ones(1,length(t))*(-0.8*coef_thresh*std(data_wpd_win(j,:))+mean(data_wpd_win(j,:))); ...
    ]), axis tight
xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
% dd3=subplot(3,1,3);
axes(handles.GM);
temp_tf=tf{j};
temp_tf(:,1:0.2*Fs)=min(min(tf{j}));
temp_tf(:,end-0.2*Fs:end)=min(min(tf{j}));
plotTimeFreq(temp_tf, 0, Nsamples/Fs, 0.5, freq(1), freq(end), 10);
hold on
plot(t,fn_wtf(j,:)*Nsteps,'r')
hold off
linkaxes([handles.rawEEG,handles.LowPass,handles.BandPass,handles.GM],'x')
% linkaxes([dd1,dd2,dd3],'x')


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_showHFO.
function pushbutton_showHFO_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_showHFO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
global Fs;global freq;global Flo;
rawdata=AllData.data_bipolar_f;
data=AllData.data_wpd_win;
data_low=AllData.data_low;
fn_wtf=AllData.fn_wtf;
Nsamples = length(data);
t = (1/Fs) * (1:Nsamples);
k=0.4*Fs;%前后延伸 | extension before and after the event
Nsteps = 100;
j=get(handles.popupmenu1,'value');%导联号 | channel index
i=get(handles.popupmenu2,'value');%HFO号 | HFO index
%Nwtf=length(cell2mat(AllData.start_tf(j)));
start_t=cell2mat(AllData.start_tf(j));
end_t=cell2mat(AllData.end_tf(j));
tf_temp=AllData.tf{j};
l=end_t-start_t;
if isempty(start_t)==0
    if (l(i)<Fs)&&(start_t(i)>k)&&(end_t(i)<(Nsamples-Fs+l(i)+k))
        start_temp(i)=start_t(i)-k;
        end_temp(i)=end_t(i)+Fs-l(i)-k;
    elseif end_t(i)+Fs-l(i)-k>=Nsamples
        start_temp(i)=start_t(i)-Fs+l(i);
        end_temp(i)=end_t(i);
    elseif (start_t(i)<=k)
        start_temp(i)=1;
        end_temp(i)=Fs;  
    end

    axes(handles.rawEEG);

    plot([t(start_t(i)),t(start_t(i))],[min(rawdata(j,start_temp(i):end_temp(i))),max( rawdata(j,start_temp(i):end_temp(i)))],'r')
    hold on
    plot([t(end_t(i)),t(end_t(i))],[min(rawdata(j,start_temp(i):end_temp(i))),max( rawdata(j,start_temp(i):end_temp(i)))],'r')
    hold on
    plot(t(start_temp(i):end_temp(i)),rawdata(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('biopolar iEEG Data');
    hold off
    axes(handles.LowPass);
    plot(t(start_temp(i):end_temp(i)),data_low(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('lowpass iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data_low(j,start_temp(i):end_temp(i))),max( data_low(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data_low(j,start_temp(i):end_temp(i))),max( data_low(j,start_temp(i):end_temp(i)))],'r')
    hold off
    axes(handles.BandPass);
    plot(t(start_temp(i):end_temp(i)),data(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data(j,start_temp(i):end_temp(i))),max( data(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data(j,start_temp(i):end_temp(i))),max( data(j,start_temp(i):end_temp(i)))],'r')
    hold off
    if get(handles.ShowTime,'value')
     text(k/Fs,0.05,[num2str(AllData.start_tf{j}(i)/Fs),'s'],'Units','normalized');
     text((k+l(i))/Fs,0.05,[num2str(AllData.end_tf{j}(i)/Fs),'s'],'Units','normalized');
    end
    axes(handles.GM);
    data_tf=tf_temp(:,(start_temp(i):end_temp(i)));
    TimeLo=start_temp(i)/Fs;
    TimeHi=end_temp(i)/Fs;
    TimeStep=0.1;
    FreqLo=freq(1);
    FreqHi=freq(end);
    FreqStep=20;
    [Nfreq Ntime] = size(data_tf);

x = linspace(TimeLo,TimeHi,Ntime);
Xtick = TimeLo : TimeStep : TimeHi;

logy = linspace(log(FreqLo),log(FreqHi),Nfreq);
Ytick = FreqLo : FreqStep : FreqHi;
imagesc(x,logy,data_tf);
set(handles.GM, ...
    'XTick', Xtick, ...
    'XTickLabel', arrayfun(@num2str, Xtick, 'UniformOutput', false), ...
    'Ydir','normal', ...
    'YTick', log(Ytick), ...
    'YTickLabel', arrayfun(@num2str, Ytick, 'UniformOutput', false));
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
hold on
plot([t(start_t(i)),t(start_t(i))],[0,Nsteps],'r')
plot([t(end_t(i)),t(end_t(i))],[0,Nsteps],'r')
hold off
linkaxes([handles.rawEEG,handles.LowPass,handles.BandPass,handles.GM],'x')

P_HFO=20*log10(max(abs(data(j,start_temp(i):end_temp(i)))));
set(handles.edit18,'string',num2str(P_HFO));

temp=tf_temp(freq>60,start_t(i):end_t(i));
max_p=max(max(temp));
[row,time]=find(tf_temp==max_p);
[pks,loc_p]=findpeaks(tf_temp(:,time),'minpeakheight',0.8*max_p);
F_HFO=freq(max(loc_p));
set(handles.edit19,'string',num2str(F_HFO));


temp=tf_temp(freq>Flo,start_t(i):end_t(i));
temp=temp/sum(sum(temp));
MF_HFO=sum(freq(freq>Flo)*temp);
set(handles.edit26,'string',num2str(MF_HFO));

temp_low=FIR_BP(0.1*Fs,Fs,5,10,rawdata(j,:));
n=0:1999;
y=fft(temp_low(start_temp(i):end_temp(i)),length(n));    %对信号进行快速Fourier变换 | FFT of the signal
mag=abs(y);     %求得Fourier变换后的振幅 | magnitude of the Fourier transform
f=n*Fs/length(n);    %频率序列 | frequency vector

[~,L_HFO]=max(mag(find(f>=5&f<=10)));
L_HFO=f(L_HFO+find(f>=5,1)-1);
F_R=F_HFO/L_HFO;
set(handles.edit20,'string',num2str(F_R));

set(handles.StartTime,'string',num2str(start_t(i)/Fs));
set(handles.StopTime,'string',num2str(end_t(i)/Fs));


    set(handles.TorF,'value',AllData.TorF{j}(i))
    set(handles.ED,'value',AllData.ED{j}(i))
   % plotTimeFreq(tf_temp(:,(start_temp(i):end_temp(i))), start_temp(i)/Fs, end_temp(i)/Fs, 0.5, freq(1), freq(end), 10,handles.GM);
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
pole=get(handles.popupmenu1,'value');
AllData=getappdata(0,'AllData');
num_HFO=AllData.num_HFO;
if num_HFO(pole)==0
    set(handles.popupmenu2,'string','no HFO');
else
set(handles.popupmenu2,'string',num2str([1:num_HFO(pole)]'));
end
set(handles.popupmenu2,'value',1);
set(handles.TorF,'value',1)
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.TorF,'value',1)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_showbytime.
function pushbutton_showbytime_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_showbytime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
global Fs;global freq;



data=AllData.data_wpd_win;
Nsamples = length(data);
t = (1/Fs) * (1:Nsamples);
fn_wtf=AllData.fn_wtf;
j=str2double(get(handles.edit10,'string'));%导联号 | channel index


start_temp=str2double(get(handles.edit11,'string'))*Fs;
end_temp=str2double(get(handles.edit12,'string'))*Fs;
tf_temp=AllData.tf{j};
if isempty(start_temp)==0
    

    axes(handles.rawEEG)
    plot(t(start_temp:end_temp),mapminmax(fn_wtf(j,start_temp:end_temp),min(AllData.data_bipolar_f(j,start_temp:end_temp)),max(AllData.data_bipolar_f(j,start_temp:end_temp))),'r');
    hold on
    plot(t(start_temp:end_temp),AllData.data_bipolar_f(j,start_temp:end_temp)), axis tight
    hold off
    xlabel('Time (sec)'), ylabel('Amplitude'), title('biopolar iEEG Data');
    axes(handles.LowPass)
    plot(t(start_temp:end_temp),mapminmax(fn_wtf(j,start_temp:end_temp),min(AllData.data_low(j,start_temp:end_temp)),max(AllData.data_low(j,start_temp:end_temp))),'r');
    hold on
    plot(t(start_temp:end_temp),AllData.data_low(j,start_temp:end_temp)), axis tight
    hold off
    xlabel('Time (sec)'), ylabel('Amplitude'), title('lowpass iEEG Data');
    axes(handles.BandPass)
    plot(t(start_temp:end_temp),mapminmax(fn_wtf(j,start_temp:end_temp),min(AllData.data_wpd_win(j,start_temp:end_temp)),max(AllData.data_wpd_win(j,start_temp:end_temp))),'r');
    hold on
    plot(t(start_temp:end_temp),AllData.data_wpd_win(j,start_temp:end_temp)), axis tight
    hold off
    xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
    
    axes(handles.GM)
    data=tf_temp(:,(start_temp:end_temp));
    TimeLo=start_temp/Fs;
    TimeHi=end_temp/Fs;
    TimeStep=0.1;
    FreqLo=freq(1);
    FreqHi=freq(end);
    FreqStep=20;
    [Nfreq Ntime] = size(data);

x = linspace(TimeLo,TimeHi,Ntime);
Xtick = TimeLo : TimeStep : TimeHi;

logy = linspace(log(FreqLo),log(FreqHi),Nfreq);
Ytick = FreqLo : FreqStep : FreqHi;
imagesc(x,logy,data);
set(handles.GM, ...
    'XTick', Xtick, ...
    'XTickLabel', arrayfun(@num2str, Xtick, 'UniformOutput', false), ...
    'Ydir','normal', ...
    'YTick', log(Ytick), ...
    'YTickLabel', arrayfun(@num2str, Ytick, 'UniformOutput', false));
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
hold on
plot(t(start_temp:end_temp),fn_wtf(j,start_temp:end_temp)*100,'r');
hold off
linkaxes([handles.rawEEG,handles.LowPass,handles.BandPass,handles.GM],'x')


set(handles.edit18,'string',' ');
set(handles.edit19,'string',' ');
set(handles.edit20,'string',' ');
set(handles.edit26,'string',' ');


end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
 for i=1:length(AllData.TorF)
    acc(i)=sum(AllData.TorF{i});
    total(i)=length(AllData.TorF{i});
 end
 TorF=AllData.TorF;
set(handles.edit13,'string',num2str(100*sum(acc)/sum(total)));
save TorF TorF






function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function BandPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BandPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate BandPass


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
start_HFO=AllData.start_tf;
end_HFO=AllData.end_tf;
HFO={start_HFO,end_HFO};
window=AllData.fn_wtf;
TorF=AllData.TorF;

save window window
save HFO HFO
save TorF TorF



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
%保存图像 | save figures
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set(hObject,'toolbar','figure') 
AllData=getappdata(0,'AllData');


data_bipolar_f=AllData.data_bipolar_f;
data_wpd=AllData.data_wpd_win;
Nsamples = length(AllData.data_wpd_win);
global Fs;global freq;global n_pole;
t = (1/Fs) * (1:Nsamples);
k=0.4*Fs;%前后延伸 | extension before and after the event
start_tf=AllData.start_tf;
end_tf=AllData.end_tf;
tf=AllData.tf;
for j=1:n_pole-1
%Nwtf=length(cell2mat(start_tf(j)));
start_t=cell2mat(start_tf(j));
end_t=cell2mat(end_tf(j));
tf_temp=tf{j};
l=end_t-start_t;
if isempty(start_t)==0
for i=1:length(start_t)
    
    if (l(i)<Fs)&&(start_t(i)>k)&&(end_t(i)<=(Nsamples-Fs+l(i)+k))
        start_temp(i)=start_t(i)-k;
        end_temp(i)=end_t(i)+Fs-l(i)-k;
    else if end_t(i)+Fs-l(i)-k>Nsamples
        start_temp(i)=start_t(i)-Fs+l(i);
        end_temp(i)=end_t(i);
        end
    end

figure('Visible','off');
pd1=subplot(3,1,1);
    plot(t(start_temp(i):end_temp(i)),data_bipolar_f(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('biopolar iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data_bipolar_f(j,start_temp(i):end_temp(i))),max( data_bipolar_f(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data_bipolar_f(j,start_temp(i):end_temp(i))),max( data_bipolar_f(j,start_temp(i):end_temp(i)))],'r')
    hold off
    zoom on
pd2=subplot(3,1,2);
 plot(t(start_temp(i):end_temp(i)),data_wpd(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data_wpd(j,start_temp(i):end_temp(i))),max( data_wpd(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data_wpd(j,start_temp(i):end_temp(i))),max( data_wpd(j,start_temp(i):end_temp(i)))],'r')
    hold off
%text(0,0,['正向峰数：',num2str(Nf{j}(1,i)),' ','负向峰数：',num2str(Nf{j}(2,i))],'Units','normalized'); | text labels, number of positive peaks / number of negative peaks
%text(0,0,['mH：',num2str(mH{j}(i,:)),' ','sH：',num2str(sH{j}(2,i))],'Units','normalized'); | text labels, mH / sH
zoom on
pd3=subplot(3,1,3);
plotTimeFreq(tf_temp(:,(start_temp(i):end_temp(i))), start_temp(i)/Fs, end_temp(i)/Fs, 0.1, freq(1), freq(end), 30);
hold on
plot([t(start_t(i)),t(start_t(i))],[0,100],'r')
plot([t(end_t(i)),t(end_t(i))],[0,100],'r')
hold off
%tag_ts(i)=sign(sum(fn_wts(j,start_temp(i):end_temp(i))));
set(gcf,'position',[200,300,600,400]);
print(gcf,[num2str(j),'_',num2str(i)],'-depsc','-r600');
zoom on
end
end
end
zip('HFOeps','*.eps');
delete('*.eps');
beep;



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
theta=[];delta=[];slow=[];
for i=1:length(AllData.angle_theta)
    theta=[theta;AllData.angle_theta{i}];
    delta=[delta;AllData.angle_delta{i}];
    slow=[slow;AllData.angle_slow{i}];
end
mi_l=get(handles.edit5,'string');
mi_r=get(handles.edit15,'string');

P_HFO=AllData.P_HFO;
F_HFO=AllData.F_HFO;
MF_HFO=AllData.MF_HFO;
F_R=AllData.F_R;
Nf=AllData.Nf;
CI=AllData.CI;
save(['TONGJI-',mi_l,'-',mi_r,'.mat'], 'P_HFO', 'F_HFO', 'MF_HFO', 'F_R', 'Nf', 'CI')
figure(3); 
subplot(2,3,1);compass(theta(:,1));
subplot(2,3,2);compass(delta(:,1));
subplot(2,3,3);compass(slow(:,1));
subplot(2,3,4);rose(theta(:,2));
subplot(2,3,5);rose(theta(:,2));
subplot(2,3,6);rose(theta(:,2));
theta=[];delta=[];slow=[];
    theta=AllData.angle_theta;
    delta=AllData.angle_delta;
    slow=AllData.angle_slow;
save (['angle-',mi_l,'-',mi_r,'.mat'], 'theta', 'delta', 'slow')
ED=AllData.ED;
save ED ED




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over HFO_T.


% --- Executes on button press in TorF.
function TorF_Callback(hObject, eventdata, handles)
% hObject    handle to TorF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AllData=getappdata(0,'AllData');
j=get(handles.popupmenu1,'value');%导联号 | channel index
i=get(handles.popupmenu2,'value');%HFO号 | HFO index
TorF=AllData.TorF{j};
if ~isempty(TorF)
AllData.TorF{j}(i)=get(handles.TorF,'value');
end
setappdata(0,'AllData',AllData);

% Hint: get(hObject,'Value') returns toggle state of TorF


% --------------------------------------------------------------------
function uitoggletool6_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'WindowButtonDownFcn','');
set(gcf,'WindowButtonUpFcn','');

% set(gcf,'WindowButtonDownFcn',@ButttonDownFcn);
function ButtonDownFcn(src,event, handles)
Y=get(gca,'YLim');                                              % y range of current axes 
Ymin=Y(1);
Ymax=Y(2);
pt = get(gca,'CurrentPoint');    %获取当前点坐标 | get the current point coordinates
x_start = pt(1,1);
setappdata(0,'x_start',x_start);

% set(gcf,'WindowButtonMotionFcn',@ButtonMotionFcn); %设置鼠标移动响应 | set the mouse-motion callback
hold on
plot([x_start,x_start],[Ymin,Ymax],'b')
hold off
fprintf('x_start=%f\n',x_start);


function ButtonUpFcn(src,event,handles)
Y=get(gca,'YLim');                                              % y range of current axes 
Ymin=Y(1);
Ymax=Y(2);
pt = get(gca,'CurrentPoint'); 
x_stop = pt(1,1);
setappdata(0,'x_stop',x_stop);
hold on
plot([x_stop,x_stop],[Ymin,Ymax],'b')
hold off
fprintf('x_stop=%f\n',x_stop);
% set(gcf, 'WindowButtonMotionFcn', '');    %取消鼠标移动响应 | remove the mouse-motion callback





% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitoggletool6_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'WindowButtonDownFcn',@ButtonDownFcn);
set(gcf,'WindowButtonUpFcn',@ButtonUpFcn);


% --------------------------------------------------------------------
function uitoggletool6_OffCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'WindowButtonDownFcn','');
set(gcf,'WindowButtonUpFcn','');


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
%计算选段 | compute the selected segment
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x_start=getappdata(0,'x_start');
x_stop=getappdata(0,'x_stop');
AllData=getappdata(0,'AllData');
global Fs;global freq;global Flo;
data=AllData.data_wpd_win;
Nsamples = length(data);
t = (1/Fs) * (1:Nsamples);
Nsteps = 100;
data_bipolar=AllData.data_bipolar;
rawdata=AllData.data_bipolar_f;
fn_wtf=AllData.fn_wtf;
Nsamples = length(data);
j=str2num(get(handles.edit9,'string'));%导联号 getappdata(0,'one_signal');% | channel index
tf_temp=AllData.tf{j};

x_start=floor(x_start*Fs);
x_stop=floor(x_stop*Fs);

P_HFO=20*log10(max(abs(data(j,x_start:x_stop))));
set(handles.edit18,'string',num2str(P_HFO));

temp=tf_temp(freq>60,x_start:x_stop);
max_p=max(max(temp));
[row,time]=find(tf_temp==max_p);

[pks,loc_p]=findpeaks(tf_temp(:,time),'minpeakheight',0.7*max_p);
if isempty(loc_p)
    loc_p=find(tf_temp(:,time)==max_p);
end
F_HFO=freq(max(loc_p));
set(handles.edit19,'string',num2str(F_HFO));

temp=tf_temp(freq>Flo,x_start:x_stop);
temp=temp/sum(sum(temp));
MF_HFO=sum(freq(freq>Flo)*temp);
set(handles.edit26,'string',num2str(MF_HFO));

temp_low=FIR_BP(0.1*Fs,Fs,5,10,rawdata(j,:));
n=0:1999;
y=fft(temp_low(x_start:x_stop),length(n));    %对信号进行快速Fourier变换 | FFT of the signal
mag=abs(y);     %求得Fourier变换后的振幅 | magnitude of the Fourier transform
f=n*Fs/length(n);    %频率序列 | frequency vector

[~,L_HFO]=max(mag(find(f>=5&f<=10)));
L_HFO=f(L_HFO+find(f>=5,1)-1);
F_R=F_HFO/L_HFO;
set(handles.edit20,'string',num2str(F_R));

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
%确认 | confirm
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;global freq;global Flo;
start_new=floor(getappdata(0,'x_start')*Fs);
stop_new=floor(getappdata(0,'x_stop')*Fs);
AllData=getappdata(0,'AllData');
j=str2num(get(handles.edit9,'string'));%导联号 getappdata(0,'one_signal');% | channel index
AllData.num_HFO(j)=AllData.num_HFO(j)+1;
AllData.start_tf{j}=sort([AllData.start_tf{j},start_new]);
AllData.end_tf{j}=sort([AllData.end_tf{j},stop_new]);
AllData.fn_wtf(j,:)= NewWindow( length(AllData.data_wpd_win(j,:)),AllData.num_HFO(j),AllData.start_tf{j},AllData.end_tf{j});
i=find(AllData.start_tf{j}==start_new);

tf=AllData.tf{j};
temp=tf(:,start_new-floor((0.5*Fs-stop_new+start_new-1)/2):stop_new+ceil((0.5*Fs-stop_new+start_new-1)/2));
Nx=10;      
Ntt=mapminmax(temp,0,1);
    for k=1:100/Nx
        for jj=1:10
            Nt(k,jj)=sum(sum(Ntt(Nx*(k-1)+1:Nx*k,0.5*Fs/10*(jj-1)+1:0.5*Fs/10*jj)));
        end
    end
Nt=sign(Nt-mean(mean(Nt)));
Nt(Nt<0)=0;
Nf=[512,256,128,64,32,16,8,4,2,1]*Nt;

raw_data=AllData.data_bipolar_f(j,:);
data=AllData.data_wpd_win(j,:);
theta=bandpass(raw_data(start_new:stop_new),[1,3],Fs);
delta=bandpass(raw_data(start_new:stop_new),[4,7],Fs);
slow=bandpass(raw_data(start_new:stop_new),[0.5,7],Fs);
y=[];
y=hilbert(theta);
y=y./abs(y);
Fo(:,1)=sum(y.*data(start_new:stop_new));Fo(:,2)=angle(Fo(:,1));%mean(angle(y))*180/pi;%theta
y=[];
y=hilbert(delta);y=y./abs(y);
mH(:,1)=sum(y.*data(start_new:stop_new));mH(:,2)=angle(mH(:,1));%mean(angle(y))*180/pi;%delta
y=[];
y=hilbert(slow);y=y./abs(y);
sH(:,1)=sum(y.*data(start_new:stop_new));sH(:,2)=angle(sH(:,1));%mean(angle(y))*180/pi;%slow

CI= sum(diff(data(start_new:stop_new)))/length(data(start_new:stop_new));%海岸线参数 | coastline index (CI)

P_HFO=str2num(get(handles.edit18,'string'));
F_HFO=str2num(get(handles.edit19,'string'));
MF_HFO=str2num(get(handles.edit26,'string'));
F_R=str2num(get(handles.edit20,'string'));
if i==1
    AllData.Nf{j}=[Nf;AllData.Nf{j}];
    AllData.TorF{j}=[1,AllData.TorF{j}];
    AllData.ED{j}=[0,AllData.ED{j}];
    AllData.angle_theta{j}=[Fo;AllData.angle_theta{j}];
    AllData.angle_delta{j}=[mH;AllData.angle_delta{j}];
    AllData.angle_slow{j}=[sH;AllData.angle_slow{j}];
    AllData.P_HFO{j}=[P_HFO,AllData.P_HFO{j}];
    AllData.F_HFO{j}=[F_HFO,AllData.F_HFO{j}];
    AllData.MF_HFO{j}=[MF_HFO,AllData.MF_HFO{j}];
    AllData.F_R{j}=[F_R,AllData.F_R{j}];
    AllData.CI{j}=[CI,AllData.CI{j}]; 
elseif i==AllData.num_HFO(j)
    AllData.Nf{j}=[AllData.Nf{j};Nf];
    AllData.TorF{j}=[AllData.TorF{j},1];
    AllData.ED{j}=[AllData.ED{j},0];
    AllData.angle_theta{j}=[AllData.angle_theta{j};Fo];
    AllData.angle_delta{j}=[AllData.angle_delta{j};mH];
    AllData.angle_slow{j}=[AllData.angle_slow{j};sH];
    AllData.P_HFO{j}=[AllData.P_HFO{j},P_HFO];
    AllData.F_HFO{j}=[AllData.F_HFO{j},F_HFO];
    AllData.MF_HFO{j}=[AllData.MF_HFO{j},MF_HFO];
    AllData.F_R{j}=[AllData.F_R{j},F_R];
    AllData.CI{j}=[AllData.CI{j},CI];   
else
    AllData.Nf{j}=[AllData.Nf{j}(1:i-1,:);Nf;AllData.Nf{j}(1+i:end,:)];
    AllData.TorF{j}=[AllData.TorF{j}(1:i-1),1,AllData.TorF{j}(1+i:end)];
    AllData.ED{j}=[AllData.ED{j}(1:i-1),0,AllData.ED{j}(1+i:end)];
    AllData.angle_theta{j}=[AllData.angle_theta{j}(1:i-1,:);Fo;AllData.angle_theta{j}(1+i:end,:)];
    AllData.angle_delta{j}=[AllData.angle_delta{j}(1:i-1,:);mH;AllData.angle_delta{j}(1+i:end,:)];
    AllData.angle_slow{j}=[AllData.angle_slow{j}(1:i-1,:);sH;AllData.angle_slow{j}(1+i:end,:)];
    AllData.P_HFO{j}=[AllData.P_HFO{j}(1:i-1),P_HFO,AllData.P_HFO{j}(1+i:end)];
    AllData.F_HFO{j}=[AllData.F_HFO{j}(1:i-1),F_HFO,AllData.F_HFO{j}(1+i:end)];
    AllData.MF_HFO{j}=[AllData.MF_HFO{j}(1:i-1),MF_HFO,AllData.MF_HFO{j}(1+i:end)];
    AllData.F_R{j}=[AllData.F_R{j}(1:i-1),F_R,AllData.F_R{j}(1+i:end)];
    AllData.CI{j}=[AllData.CI{j}(1:i-1),CI,AllData.CI{j}(1+i:end)];   
end
setappdata(0,'AllData',AllData);

pole=get(handles.popupmenu1,'value');
num_HFO=AllData.num_HFO;
if num_HFO(pole)==0
    set(handles.popupmenu2,'string','no HFO');
else
set(handles.popupmenu2,'string',num2str([1:num_HFO(pole)]'));
end
set(handles.popupmenu2,'value',1);
set(handles.TorF,'value',1)
disp('确认');

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
now_HFO=get(handles.popupmenu2,'value');
now_channel=get(handles.popupmenu1,'value');
AllData=getappdata(0,'AllData');

if now_HFO>1
   set(handles.popupmenu2,'value',now_HFO-1);
    set(handles.TorF,'value',AllData.TorF{now_channel}(now_HFO))
    set(handles.ED,'value',AllData.ED{now_channel}(now_HFO))
    pushbutton_showHFO_Callback(hObject, eventdata, handles);
else
 beep;
end

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
now_HFO=get(handles.popupmenu2,'value');
now_channel=get(handles.popupmenu1,'value');
AllData=getappdata(0,'AllData');
num_HFO=AllData.num_HFO(now_channel);
if now_HFO<num_HFO
   set(handles.popupmenu2,'value',now_HFO+1);
    set(handles.TorF,'value',AllData.TorF{now_channel}(now_HFO))
    set(handles.ED,'value',AllData.ED{now_channel}(now_HFO))
    pushbutton_showHFO_Callback(hObject, eventdata, handles);
else
 beep;
end


% --- Executes on button press in radiobutton11.
function bipolar_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton12.
function unipolar_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Flo_Callback(hObject, eventdata, handles)
% hObject    handle to Flo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Flo as text
%        str2double(get(hObject,'String')) returns contents of Flo as a double


% --- Executes during object creation, after setting all properties.
function Flo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Flo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fhi_Callback(hObject, eventdata, handles)
% hObject    handle to Fhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fhi as text
%        str2double(get(hObject,'String')) returns contents of Fhi as a double


% --- Executes during object creation, after setting all properties.
function Fhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NER.
function NER_Callback(hObject, eventdata, handles)
% hObject    handle to NER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NER


% --- Executes on button press in ShowTime.
function ShowTime_Callback(hObject, eventdata, ~)
% hObject    handle to ShowTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowTime


% --- Executes on button press in Channel.
function Channel_Callback(hObject, eventdata, handles)
% hObject    handle to Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n_order=[];
setappdata(0,'n_order',n_order);
hdr=getappdata(0,'hdr');
label=hdr.label;
ChannelChose;
h_channel=guihandles;
set(h_channel.Label,'string',char(label));



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in refresh.
function refresh_Callback(hObject, eventdata, handles)
% hObject    handle to refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Refresh;
AllData=getappdata(0,'AllData');
pole=get(handles.popupmenu1,'value');
num_HFO=AllData.num_HFO;
if num_HFO(pole)==0
    set(handles.popupmenu2,'string','no HFO');
    set(handles.TorF,'value',0)
    set(handles.ED,'value',0)
else
    set(handles.popupmenu2,'string',num2str([1:num_HFO(pole)]'));
    set(handles.TorF,'value',1)
    set(handles.ED,'value',AllData.ED{pole}(1))
end
set(handles.popupmenu2,'value',1);



    
%  for i=1:length(AllData.TorF)
%     acc(i)=sum(AllData.TorF{i});
%     total(i)=length(AllData.TorF{i});
%  end


% --- Executes on button press in Network.
function Network_Callback(hObject, eventdata, handles)
% hObject    handle to Network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
global Fs;
data_wpd_win=AllData.data_wpd_win;
start_tf=AllData.start_tf;
end_tf=AllData.end_tf;
startPoint=start_tf;

mi_l=get(handles.edit5,'string');

mi_r=get(handles.edit15,'string');

% env
HFOsort=[];n=0;
for i=1:length(start_tf)
    [yupper,ylower]=envelope(data_wpd_win(i,:),0.01*Fs,'peak');
    e=yupper-ylower;
    
    if ~isempty(start_tf{i})
        for j=1:length(start_tf{i})
%             e_max=max(e(start_tf{i}(j):end_tf{i}(j)));
%             if e(start_tf{i}(j))<(e_max/2)
%                startPoint{i}(j)= find(e(start_tf{i}(j):end_tf{i}(j))>=(e_max/2),1,'first')+start_tf{i}(j)-1;
%             else
%                startPoint{i}(j)= find(e(1:start_tf{i}(j))<=(e_max/2),1,'last');
%             end
            n=n+1;
            HFOsort(n,:)=[start_tf{i}(j),i,j];
        end
    end
end
[Timesort,sortofHFO]=sort(HFOsort(:,1));
HFOsort=HFOsort(sortofHFO,:);
N=zeros(length(start_tf),length(start_tf));
Cov=zeros(length(start_tf),length(start_tf));
tframe=get(handles.edit28,'string');
if isempty(tframe)
    tframe0=0;tframe1=0.05;
else 
    tframe=str2num(tframe);
    if length(tframe)>1
        tframe0=tframe(1)
        tframe1=tframe(2)
    else
        tframe0=0;tframe1=tframe
    end
end
for i=1:n
    temp=find(Timesort(i+1:n)>=(Timesort(i)+tframe0*Fs)&Timesort(i+1:n)<=(Timesort(i)+tframe1*Fs)&HFOsort(i+1:n,2)~=HFOsort(i,2))+i;
    for j=1:length(temp)
        N(HFOsort(i,2),HFOsort(temp(j),2))=N(HFOsort(i,2),HFOsort(temp(j),2))+1;
        Cov(HFOsort(i,2),HFOsort(temp(j),2))=Cov(HFOsort(i,2),HFOsort(temp(j),2))+...
            max(xcorr(mapminmax(data_wpd_win(HFOsort(i,2),start_tf{HFOsort(i,2)}(HFOsort(i,3)):end_tf{HFOsort(temp(j),2)}(HFOsort(temp(j),3))),-1,1),...
            mapminmax(data_wpd_win(HFOsort(temp(j),2),start_tf{HFOsort(i,2)}(HFOsort(i,3)):end_tf{HFOsort(temp(j),2)}(HFOsort(temp(j),3))),-1,1),'coeff'));
    end
end
save(['N',num2str(tframe*1000),'-',mi_l,'-',mi_r,'.mat'],'N')
for i=1:size(N,1)
    for j=1:size(N,2)
        if N(i,j)~=0
            Cov(i,j)=Cov(i,j)/N(i,j);
        end
    end
end    
save(['Cov',num2str(tframe*1000),'-',mi_l,'-',mi_r,'.mat'],'Cov')

Np=get(handles.NetworkPoint,'string');
if isempty(Np)
    s1=sum(N,1);s2=sum(N,2)';
    Np=find(s1~=0|s2~=0);
else    
    Np=str2num(Np);
    Np=sort(Np);
end
N=N(Np,Np);

hdr=getappdata(0,'hdr');
if isfield(hdr,'label')
label=hdr.label;
else 
label=num2cell(1:size(AllData.data_wpd_win,1));
end
IDS=label(Np);

PP=get(handles.PolePosition,'value');
if PP==1
fileToRead = uigetfile('*.*', 'Pick a channel position File(txt)');
p=importdata('fileToRead');
position=p.data;
position=position(Np,:);
bg=digraph(N,IDS);
c=mapminmax(sum(N,2)'./(sum(N,1)+sum(N,2)'),min(bg.Edges.Weight),max(bg.Edges.Weight));
figure('Name','Network')
p=plot(bg,'XData',position(:,1),'YData',position(:,2),'ZData',position(:,3),...
    'EdgeCdata',bg.Edges.Weight,...
    'NodeCdata',c);
p.Marker = 'o';
p.MarkerSize=7;  
end
bg=biograph(N,IDS);
set(bg.nodes,'shape','circle','color',[1,1,1],'lineColor',[0,0,0]);
 set(bg,'layoutType','radial');
 bg.showWeights='on';
 set(bg.nodes,'textColor',[0,0,0],'lineWidth',2,'fontsize',9);
 set(bg,'arrowSize',12,'edgeFontSize',9);
 view(bg);



function NetworkPoint_Callback(hObject, eventdata, handles)
% hObject    handle to NetworkPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NetworkPoint as text
%        str2double(get(hObject,'String')) returns contents of NetworkPoint as a double


% --- Executes during object creation, after setting all properties.
function NetworkPoint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NetworkPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PolePosition.
function PolePosition_Callback(hObject, eventdata, handles)
% hObject    handle to PolePosition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PolePosition


% --- Executes on button press in ED.
function ED_Callback(hObject, eventdata, handles)
% hObject    handle to ED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
j=get(handles.popupmenu1,'value');%导联号 | channel index
i=get(handles.popupmenu2,'value');%HFO号 | HFO index
ED=AllData.ED{j};
if ~isempty(ED)
AllData.ED{j}(i)=get(handles.ED,'value');
end
setappdata(0,'AllData',AllData);
% Hint: get(hObject,'Value') returns toggle state of ED



function StartTime_Callback(hObject, eventdata, handles)
% hObject    handle to StartTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartTime as text
%        str2double(get(hObject,'String')) returns contents of StartTime as a double


% --- Executes during object creation, after setting all properties.
function StartTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StopTime_Callback(hObject, eventdata, handles)
% hObject    handle to StopTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopTime as text
%        str2double(get(hObject,'String')) returns contents of StopTime as a double


% --- Executes during object creation, after setting all properties.
function StopTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton21. 
% 修正起始点 | correct the start point
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllData=getappdata(0,'AllData');
global Fs;global freq;global Flo;
rawdata=AllData.data_bipolar_f;
data=AllData.data_wpd_win;
data_low=AllData.data_low;

Nsamples = length(data);
t = (1/Fs) * (1:Nsamples);
k=0.4*Fs;%前后延伸 | extension before and after the event
Nsteps = 100;
j=get(handles.popupmenu1,'value');%导联号 | channel index
i=get(handles.popupmenu2,'value');%HFO号 | HFO index
%Nwtf=length(cell2mat(AllData.start_tf(j)));
AllData.start_tf{j}(i)=str2num(get(handles.StartTime,'string'))*Fs;
AllData.end_tf{j}(i)=str2num(get(handles.StopTime,'string'))*Fs;

tf_temp=AllData.tf{j};
x_start=AllData.start_tf{j}(i);
x_stop=AllData.end_tf{j}(i);

P_HFO=20*log10(max(abs(data(j,x_start:x_stop))));
set(handles.edit18,'string',num2str(P_HFO));

temp=tf_temp(freq>60,x_start:x_stop);
max_p=max(max(temp));
[~,time]=find(tf_temp==max_p(1));

[~,loc_p]=findpeaks(tf_temp(:,time),'minpeakheight',0.7*max_p);
if isempty(loc_p)
    loc_p=find(tf_temp(:,time)==max_p);
end
F_HFO=freq(max(loc_p));
set(handles.edit19,'string',num2str(F_HFO));

temp=tf_temp(freq>Flo,x_start:x_stop);
temp=temp/sum(sum(temp));
MF_HFO=sum(freq(freq>Flo)*temp);
set(handles.edit26,'string',num2str(MF_HFO));

temp_low=FIR_BP(0.1*Fs,Fs,5,10,rawdata(j,:));
n=0:1999;
y=fft(temp_low(x_start:x_stop),length(n));    %对信号进行快速Fourier变换 | FFT of the signal
mag=abs(y);     %求得Fourier变换后的振幅 | magnitude of the Fourier transform
f=n*Fs/length(n);    %频率序列 | frequency vector

[~,L_HFO]=max(mag(find(f>=5&f<=10)));
L_HFO=f(L_HFO+find(f>=5,1)-1);
F_R=F_HFO/L_HFO;
set(handles.edit20,'string',num2str(F_R));

temp=tf_temp(:,x_start-floor((0.5*Fs-x_stop+x_start-1)/2):x_stop+ceil((0.5*Fs-x_stop+x_start-1)/2));
Nx=10;      
Ntt=mapminmax(temp,0,1);
    for k=1:100/Nx
        for jj=1:10
            Nt(k,jj)=sum(sum(Ntt(Nx*(k-1)+1:Nx*k,0.5*Fs/10*(jj-1)+1:0.5*Fs/10*jj)));
        end
    end
Nt=sign(Nt-mean(mean(Nt)));
Nt(Nt<0)=0;
Nf=[512,256,128,64,32,16,8,4,2,1]*Nt;


data=AllData.data_wpd_win(j,:);
theta=bandpass(rawdata(x_start:x_stop),[1,3],Fs);
delta=bandpass(rawdata(x_start:x_stop),[4,7],Fs);
slow=bandpass(rawdata(x_start:x_stop),[0.5,7],Fs);
y=[];
y=hilbert(theta);
y=y./abs(y);
Fo(:,1)=sum(y.*data(x_start:x_stop));Fo(:,2)=angle(Fo(:,1));%mean(angle(y))*180/pi;%theta
y=[];
y=hilbert(delta);y=y./abs(y);
mH(:,1)=sum(y.*data(x_start:x_stop));mH(:,2)=angle(mH(:,1));%mean(angle(y))*180/pi;%delta
y=[];
y=hilbert(slow);y=y./abs(y);
sH(:,1)=sum(y.*data(x_start:x_stop));sH(:,2)=angle(sH(:,1));%mean(angle(y))*180/pi;%slow

CI= sum(diff(data(x_start:x_stop)))/length(data(x_start:x_stop));%海岸线参数 | coastline index (CI)

    AllData.Nf{j}(i,:)=Nf;
    AllData.angle_theta{j}(i,:)=Fo;
    AllData.angle_delta{j}(i,:)=mH;
    AllData.angle_slow{j}(i,:)=sH;
    AllData.P_HFO{j}(i)=P_HFO;
    AllData.F_HFO{j}(i)=F_HFO;
    AllData.MF_HFO{j}(i)=MF_HFO;
    AllData.F_R{j}(i)=F_R;
    AllData.CI{j}(i)=CI; 



setappdata(0,'AllData',AllData);

k=0.4*Fs;%前后延伸 | extension before and after the event
start_t=cell2mat(AllData.start_tf(j));
end_t=cell2mat(AllData.end_tf(j));
l=end_t-start_t;
if isempty(start_t)==0
    if (l(i)<Fs)&&(start_t(i)>k)&&(end_t(i)<(Nsamples-Fs+l(i)+k))
        start_temp(i)=start_t(i)-k;
        end_temp(i)=end_t(i)+Fs-l(i)-k;
    elseif end_t(i)+Fs-l(i)-k>=Nsamples
        start_temp(i)=start_t(i)-Fs+l(i);
        end_temp(i)=end_t(i);
    elseif (start_t(i)<=k)
        start_temp(i)=1;
        end_temp(i)=Fs;  
    end

    axes(handles.rawEEG);

    plot([t(start_t(i)),t(start_t(i))],[min(rawdata(j,start_temp(i):end_temp(i))),max( rawdata(j,start_temp(i):end_temp(i)))],'r')
    hold on
    plot([t(end_t(i)),t(end_t(i))],[min(rawdata(j,start_temp(i):end_temp(i))),max( rawdata(j,start_temp(i):end_temp(i)))],'r')
    hold on
    plot(t(start_temp(i):end_temp(i)),rawdata(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('biopolar iEEG Data');
    hold off
    axes(handles.LowPass);
    plot(t(start_temp(i):end_temp(i)),data_low(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('lowpass iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data_low(j,start_temp(i):end_temp(i))),max( data_low(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data_low(j,start_temp(i):end_temp(i))),max( data_low(j,start_temp(i):end_temp(i)))],'r')
    hold off
    axes(handles.BandPass);
    plot(t(start_temp(i):end_temp(i)),data(j,start_temp(i):end_temp(i))), axis tight
    xlabel('Time (sec)'), ylabel('Amplitude'), title('bandpass iEEG Data');
    hold on
    plot([t(start_t(i)),t(start_t(i))],[min(data(j,start_temp(i):end_temp(i))),max( data(j,start_temp(i):end_temp(i)))],'r')
    plot([t(end_t(i)),t(end_t(i))],[min(data(j,start_temp(i):end_temp(i))),max( data(j,start_temp(i):end_temp(i)))],'r')
    hold off
    if get(handles.ShowTime,'value')
     text(k/Fs,0.05,[num2str(AllData.start_tf{j}(i)/Fs),'s'],'Units','normalized');
     text((k+l(i))/Fs,0.05,[num2str(AllData.end_tf{j}(i)/Fs),'s'],'Units','normalized');
    end
    axes(handles.GM);
    data_tf=tf_temp(:,(start_temp(i):end_temp(i)));
    TimeLo=start_temp(i)/Fs;
    TimeHi=end_temp(i)/Fs;
    TimeStep=0.1;
    FreqLo=freq(1);
    FreqHi=freq(end);
    FreqStep=20;
    [Nfreq Ntime] = size(data_tf);

x = linspace(TimeLo,TimeHi,Ntime);
Xtick = TimeLo : TimeStep : TimeHi;

logy = linspace(log(FreqLo),log(FreqHi),Nfreq);
Ytick = FreqLo : FreqStep : FreqHi;
imagesc(x,logy,data_tf);
set(handles.GM, ...
    'XTick', Xtick, ...
    'XTickLabel', arrayfun(@num2str, Xtick, 'UniformOutput', false), ...
    'Ydir','normal', ...
    'YTick', log(Ytick), ...
    'YTickLabel', arrayfun(@num2str, Ytick, 'UniformOutput', false));
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
hold on
plot([t(start_t(i)),t(start_t(i))],[0,Nsteps],'r')
plot([t(end_t(i)),t(end_t(i))],[0,Nsteps],'r')
hold off
linkaxes([handles.rawEEG,handles.LowPass,handles.BandPass,handles.GM],'x')


set(handles.StartTime,'string',num2str(start_t(i)/Fs));
set(handles.StopTime,'string',num2str(end_t(i)/Fs));
disp('修正完成');
end


% --- Executes on button press in spike.
function spike_Callback(hObject, eventdata, handles)
% hObject    handle to spike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spike
