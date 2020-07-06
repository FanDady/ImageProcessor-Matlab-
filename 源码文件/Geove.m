function varargout = Geove(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Geove_OpeningFcn, ...
                   'gui_OutputFcn',  @Geove_OutputFcn, ...
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



function Geove_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

global user_flag;
global lock_flag;
user_flag=0;
lock_flag=0;

Login = imread('login.png'); 
set(handles.LoginButton,'CData',Login);
guidata(hObject, handles);



function varargout = Geove_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


%���ñ���ͼ��
function figure1_CreateFcn(hObject, eventdata, handles)
Background=axes('units','normalized','pos',[0 0 1 1]);
uistack(Background,'bottom');
img=imread('geove.png');
image(img);
colormap gray
set(Background,'handlevisibility','off','visible','off');


%�����˺�����
function Account_Callback(hObject, eventdata, handles)
global user_flag;
ID=get(hObject,'String');
if (str2num(ID)~=0)
    user_flag=1;
end


function Account_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%������������
function Lock_Callback(hObject, eventdata, handles)
global lock_flag;
password=get(hObject,'String');
if (str2num(password)~=0)
    lock_flag=1;
end


function Lock_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%���õ�¼��ť
function LoginButton_Callback(hObject, eventdata, handles)
global user_flag;
global lock_flag;
if user_flag~=1 && lock_flag==1
    errordlg('������ѧ��','��ʾ','modal')
end
if user_flag==1 && lock_flag~=1
    errordlg('����������','��ʾ','modal')
end
if user_flag~=1 && lock_flag~=1
    errordlg('������ѧ�ź�����','��ʾ','modal')
end
if user_flag==1 && lock_flag==1
    close(Geove);
    run('Serein.m');
    
end
