function varargout = project(varargin)
% PROJECT MATLAB code for project.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help project

% Last Modified by GUIDE v2.5 19-May-2023 01:21:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_OpeningFcn, ...
                   'gui_OutputFcn',  @project_OutputFcn, ...
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


% --- Executes just before project is made visible.
function project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project (see VARARGIN)

% Choose default command line output for project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RECT.
function RECT_Callback(hObject, eventdata, handles)
% hObject    handle to RECT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=str2num(get(handles.amp,'string'));
T=1;
wo=2*pi/T;
d=str2num(get(handles.dtc,'string'));
z=1-d;
to=str2num(get(handles.shf,'string'));
k=1:4;
if(d==0.5)
    syms t
a01=(2/T)*(int(a,t,to,T+to))
ak1=(2/T)*(int(a*cos(k*wo*t),t,to,T+to))
bk1=(2/T)*(int(a*sin(k*wo*t),t,to,T+to))
z3=a01+ak1*cos(k*wo*t)'+bk1*sin(k*wo*t)'
ans1=vpa(z3,length(k))
elseif(d<0.5)
    y=2*d;
    syms t
a01=(2/T)*(int(a,t,to,(y*T)+to))
ak1=(2/T)*(int(a*cos(k*wo*t),t,to,(y*T)+to))
bk1=(2/T)*(int(a*sin(k*wo*t),t,to,(y*T)+to))
z3=a01+ak1*cos(k*wo*t)'+bk1*sin(k*wo*t)'
ans1=vpa(z3,length(k))
elseif(d>0.5)
    y=2*(d-0.5);
    syms t
a01=(2/T)*(int(a,t,to,((1+y)*T)+to))
ak1=(2/T)*(int(a*cos(k*wo*t),t,to,((1+y)*T)+to))
bk1=(2/T)*(int(a*sin(k*wo*t),t,to,((1+y)*T)+to))
z3=a01+ak1*cos(k*wo*t)'+bk1*sin(k*wo*t)'
ans1=vpa(z3,length(k))
end
%subplot 211
%ezplot(ans1)
t=-4:0.01:4;
%n=input('enter the time period:');

if (d==0.5)
for i=1:numel(t);
    if(-4*(T)<t(i))&&(t(i)<-(3)*(T))
     x(i)=a;
    elseif(-(2)*T<t(i))&&(t(i)<=-(1)*T)
    x(i)=a;
    elseif(t(i)>0)&&((1)*T>=t(i))
     x(i)=a;
    elseif((2)*T<t(i))&&(t(i)<=(3)*T)
    x(i)=a;
    else 
        x(i)=0;
    end
 
end
elseif(d<0.5)
    for i=1:numel(t);
        y=2*d;
    if(-4*T<t(i))&&(t(i)<-((4-y)*T))
     x(i)=a;
    elseif(-(2)*T<t(i))&&(t(i)<=-(2-y)*T)
    x(i)=a;
    elseif(t(i)>0)&&(y*(1)*T>=t(i))
     x(i)=a;
    elseif(2*T<t(i))&&(t(i)<=(2+y)*T)
    x(i)=a;
    a;
    else 
        x(i)=0;
 end
    end
    elseif(d>0.5)
        y=2*(d-0.5);
    for i=1:numel(t);
    if(-4*(T)<t(i))&&(t(i)<-(3-y)*(T))
     x(i)=a;
    elseif(-(2)*T<t(i))&&(t(i)<=-(1-y)*T)
    x(i)=a;
    elseif(t(i)>0)&&((1+y)*T>=t(i))
     x(i)=a;
    elseif((2)*T<t(i))&&(t(i)<=(3+y)*T)
    x(i)=a;
    else 
        x(i)=0;
 end
    end
end
t1=t-(-to);
%subplot 212
 plot(t1,x)
title('rectangular wave')
xlabel('time')
ylabel('x(t)')
   grid on
   



% --- Executes on button press in TRI.
function TRI_Callback(hObject, eventdata, handles)
% hObject    handle to TRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in CHR.
function CHR_Callback(hObject, eventdata, handles)
% hObject    handle to CHR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function amp_Callback(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp as text
%        str2double(get(hObject,'String')) returns contents of amp as a double


% --- Executes during object creation, after setting all properties.
function amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function shf_Callback(hObject, eventdata, handles)
% hObject    handle to shf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shf as text
%        str2double(get(hObject,'String')) returns contents of shf as a double


% --- Executes during object creation, after setting all properties.
function shf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dtc_Callback(hObject, eventdata, handles)
% hObject    handle to dtc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dtc as text
%        str2double(get(hObject,'String')) returns contents of dtc as a double


% --- Executes during object creation, after setting all properties.
function dtc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rc_Callback(hObject, eventdata, handles)
% hObject    handle to rc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rc as text
%        str2double(get(hObject,'String')) returns contents of rc as a double
a=str2num(get(handles.amp,'string'));
T=1;
wo=2*pi/T;
d=str2num(get(handles.dtc,'string'));
z=1-d;
to=str2num(get(handles.shf,'string'));
k=1:4;
if(d==0.5)
    syms t
a01=(2/T)*(int(a,t,to,T+to))
ak1=(2/T)*(int(a*cos(k*wo*t),t,to,T+to))
bk1=(2/T)*(int(a*sin(k*wo*t),t,to,T+to))
z3=a01+ak1*cos(k*wo*t)'+bk1*sin(k*wo*t)'
ans1=vpa(z3,length(k))
elseif(d<0.5)
    y=2*d;
    syms t
a01=(2/T)*(int(a,t,to,(y*T)+to))
ak1=(2/T)*(int(a*cos(k*wo*t),t,to,(y*T)+to))
bk1=(2/T)*(int(a*sin(k*wo*t),t,to,(y*T)+to))
z3=a01+ak1*cos(k*wo*t)'+bk1*sin(k*wo*t)'
ans1=vpa(z3,length(k))
elseif(d>0.5)
    y=2*(d-0.5);
    syms t
a01=(2/T)*(int(a,t,to,((1+y)*T)+to))
ak1=(2/T)*(int(a*cos(k*wo*t),t,to,((1+y)*T)+to))
bk1=(2/T)*(int(a*sin(k*wo*t),t,to,((1+y)*T)+to))
z3=a01+ak1*cos(k*wo*t)'+bk1*sin(k*wo*t)'
ans1=vpa(z3,length(k))
end
%subplot 211
ezplot(ans1)

% --- Executes during object creation, after setting all properties.
function rc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tc_Callback(hObject, eventdata, handles)
% hObject    handle to tc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tc as text
%        str2double(get(hObject,'String')) returns contents of tc as a double


% --- Executes during object creation, after setting all properties.
function tc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cc_Callback(hObject, eventdata, handles)
% hObject    handle to cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc as text
%        str2double(get(hObject,'String')) returns contents of cc as a double


% --- Executes during object creation, after setting all properties.
function cc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
