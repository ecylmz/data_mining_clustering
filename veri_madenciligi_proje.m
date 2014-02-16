function varargout = veri_madenciligi_proje(varargin)
% VERI_MADENCILIGI_PROJE M-file for veri_madenciligi_proje.fig
%      VERI_MADENCILIGI_PROJE, by itself, creates a new VERI_MADENCILIGI_PROJE or raises the existing
%      singleton*.
%
%      H = VERI_MADENCILIGI_PROJE returns the handle to a new VERI_MADENCILIGI_PROJE or the handle to
%      the existing singleton*.
%
%      VERI_MADENCILIGI_PROJE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VERI_MADENCILIGI_PROJE.M with the given input arguments.
%
%      VERI_MADENCILIGI_PROJE('Property','Value',...) creates a new VERI_MADENCILIGI_PROJE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before veri_madenciligi_proje_openingfcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to veri_madenciligi_proje_openingfcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help veri_madenciligi_proje

% Last Modified by GUIDE v2.5 29-Jan-2014 20:00:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VERI_MADENCILIGI_proje_OpeningFcn, ...
                   'gui_OutputFcn',  @VERI_MADENCILIGI_proje_OutputFcn, ...
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


% --- Executes just before veri_madenciligi_proje is made visible.
function VERI_MADENCILIGI_proje_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to veri_madenciligi_proje (see VARARGIN)

% Choose default command line output for veri_madenciligi_proje
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% Default dataset load
data = Dataset(1);
axes(handles.benzerlik_figur);
affinity = CalculateAffinity(data);
imagesc(affinity);
axes(handles.giris_figur);
plot(handles.giris_figur,data(:,1),data(:,2),'.');
set(handles.giris_figur,'XMinorTick','on');
set(handles.dataset_table, 'Visible', 'off');
set(handles.dbscan_k_str,'visible','off');
set(handles.dbscan_eps_str,'visible','off');
set(handles.dbscan_k,'visible','off');
set(handles.dbscan_eps,'visible','off');
set(handles.sse_title,'Visible','off')
set(handles.sse_value,'Visible','off')
set(handles.dataset_table,'Data', data);

% UIWAIT makes veri_madenciligi_proje wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VERI_MADENCILIGI_proje_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in verisetleri.
function verisetleri_Callback(hObject, eventdata, handles)
% hObject    handle to verisetleri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns verisetleri contents as cell array
%        contents{get(hObject,'Value')} returns selected item from verisetleri
% Create time plot in proper axes

val = get(hObject,'Value');
switch val
    case 1
        data = Dataset(1);
    case 2
        data = Dataset(2);
    case 3
        data = Dataset(3);
    case 4
        data = Dataset(4);
    case 5
        data = Dataset(5);
    case 6
        data = Dataset(6);
    case 7
        data = Dataset(7);
    case 8
        data_file = uigetfile('*.dat')
        if data_file==0, %data_file == 0 | data_file == '',    % cancelled
            no_change = 1;
        else        % loading data
            eval([mfilename, '(''clear_traj'')']);
            eval(['load ' data_file]);
            tmp = find(data_file=='.');
            if tmp == [],   % data file has no extension.
                eval(['data=' data_file ';']);
            else
                eval(['data=' data_file(1:tmp-1) ';']);
            end
            if size(data, 2) ~= 2,
                fprintf('Given data is not 2-D!\n');
                no_change = 1;
            end
        end

end

affinity = CalculateAffinity(data);
axes(handles.benzerlik_figur);
imagesc(affinity);
set(handles.dataset_table,'Data', data);
axes(handles.giris_figur);
plot(handles.giris_figur,data(:,1),data(:,2),'.');
set(handles.giris_figur,'XMinorTick','on')


% --- Executes during object creation, after setting all properties.
function verisetleri_CreateFcn(hObject, eventdata, handles)
% hObject    handle to verisetleri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
a='Dataset 1';b='Dataset 2';c='Dataset 3';d='Dataset 4';e='Dataset 5';f='Dataset 6';g='Dataset 7';h='Custom';
s=char(a,b,c,d,e,f,g,h);
set(hObject,'String',s);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in algoritmalar.
function algoritmalar_Callback(hObject, eventdata, handles)
% hObject    handle to algoritmalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns algoritmalar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from algoritmalar



% --- Executes during object creation, after setting all properties.
function algoritmalar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to algoritmalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
a='K-Means';b='Gauss';c='Fuzzy C-Means';d='Complete Link';e='DBSCAN';
s=char(a,b,c,d,e);
set(hObject,'String',s);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calistir.
function calistir_Callback(hObject, eventdata, handles)
% hObject    handle to calistir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = get(handles.dataset_table,'Data');
algoritma_val = get(handles.algoritmalar,'Value');
kume_sayisi = double(get(handles.kume_sayisi,'Value'));


switch algoritma_val
    case 1
        % k-means
        tic;
        [cidx,~,sumd]=kmeans(data,kume_sayisi);
        sse_value=sse(sumd);
        calisma_suresi = toc;
        axes(handles.cikis_figur);
        scatter(data(:,1),data(:,2),15,cidx,'filled')
        set(handles.cikis_figur,'XMinorTick','on')
        set(handles.sse_value,'String',sse_value);
        set(handles.sse_title,'Visible','on')
        set(handles.sse_value,'Visible','on')
    case 2
        % gaussian
        tic;
        gauss = gmdistribution.fit(data,kume_sayisi,'Regularize', 1e-5);
        cidx = cluster(gauss,data);
        calisma_suresi = toc;
        axes(handles.cikis_figur);
        scatter(data(:,1),data(:,2),15,cidx,'filled')
        set(handles.cikis_figur,'XMinorTick','on')
    case 3
        % fcm
        tic;
        [~,U,~] = fcm(data,kume_sayisi);
        cidx=zeros(length(data),1);
        for i=1:kume_sayisi
        index= find(U(i, :) == max(U));
           for k=1:length(index)
                cidx(index(k))=i;
           end 
        end
        calisma_suresi = toc;
        axes(handles.cikis_figur);
        scatter(data(:,1),data(:,2),15,cidx,'filled')
        set(handles.cikis_figur,'XMinorTick','on')
    case 4
        % Complete Link
        % http://www.mathworks.com/help/stats/linkage.html
        tic;
        Z = linkage(data,'ward','euclidean');
        c = cluster(Z,'maxclust',kume_sayisi);
        calisma_suresi = toc;
        axes(handles.cikis_figur);
        scatter(data(:,1),data(:,2),15,c,'filled') 
        set(handles.cikis_figur,'XMinorTick','on')
    case 5
        k = str2double(get(handles.dbscan_k,'String'));
        eps = str2double(get(handles.dbscan_eps,'String'));
        if isnan(eps)
            eps = [];
        end
        tic;
        [cidx,type]=dbscan(data,k,eps);
        calisma_suresi = toc;
        axes(handles.cikis_figur);
        scatter(data(:,1),data(:,2),15,cidx,'filled')
        set(handles.cikis_figur,'XMinorTick','on')
        set(handles.dbscan_k_str,'Visible','on')
        set(handles.dbscan_k,'Visible','on')
        set(handles.dbscan_eps_str,'Visible','on')
        set(handles.dbscan_eps,'Visible','on')
end
set(handles.calisma_suresi,'String',num2str(calisma_suresi,6));
if algoritma_val ~= 5
    set(handles.dbscan_k_str,'Visible','off')
    set(handles.dbscan_k,'Visible','off')
    set(handles.dbscan_eps_str,'Visible','off')
    set(handles.dbscan_eps,'Visible','off')
end
if algoritma_val ~= 1
    set(handles.sse_title,'Visible','off')
    set(handles.sse_value,'Visible','off')
end


% --- Executes on slider movement.
function kume_sayisi_Callback(hObject, eventdata, handles)
% hObject    handle to kume_sayisi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function kume_sayisi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kume_sayisi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
a='1';b='2';c='3';d='4';e='5';f='6';g='7';h='8';j='9';k='10';
s=char(a,b,c,d,e,f,g,h,j,k);
set(hObject,'String',s);
set(hObject,'Value',2);

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function dbscan_k_Callback(hObject, eventdata, handles)
% hObject    handle to dbscan_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbscan_k as text
%        str2double(get(hObject,'String')) returns contents of dbscan_k as a double


% --- Executes during object creation, after setting all properties.
function dbscan_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbscan_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dbscan_eps_Callback(hObject, eventdata, handles)
% hObject    handle to dbscan_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbscan_eps as text
%        str2double(get(hObject,'String')) returns contents of dbscan_eps as a double


% --- Executes during object creation, after setting all properties.
function dbscan_eps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbscan_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
