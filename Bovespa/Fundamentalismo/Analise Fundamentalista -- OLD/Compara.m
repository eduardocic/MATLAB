function varargout = Compara(varargin)
% COMPARA MATLAB code for Compara.fig
%      COMPARA, by itself, creates a new COMPARA or raises the existing
%      singleton*.
%
%      H = COMPARA returns the handle to a new COMPARA or the handle to
%      the existing singleton*.
%
%      COMPARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPARA.M with the given input arguments.
%
%      COMPARA('Property','Value',...) creates a new COMPARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Compara_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Compara_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Compara

% Last Modified by GUIDE v2.5 06-Mar-2017 14:35:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Compara_OpeningFcn, ...
                   'gui_OutputFcn',  @Compara_OutputFcn, ...
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


% --- Executes just before Compara is made visible.
function Compara_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Compara (see VARARGIN)

cla reset;
set(handles.TELA_Caixa1, 'String', '');    
set(handles.TELA_Caixa1, 'Enable','off'); 
set(handles.TELA_Caixa1, 'Value',0); 
set(handles.TELA_Caixa2, 'String', '');    
set(handles.TELA_Caixa2, 'Enable','off');  
set(handles.TELA_Caixa2, 'Value',0); 
set(handles.TELA_Caixa3, 'String', '');    
set(handles.TELA_Caixa3, 'Enable','off');    
set(handles.TELA_Caixa3, 'Value',0); 
set(handles.TELA_Caixa4, 'String', '');    
set(handles.TELA_Caixa4, 'Enable','off');    
set(handles.TELA_Caixa4, 'Value',0); 
set(handles.TELA_Caixa5, 'String', '');    
set(handles.TELA_Caixa5, 'Enable','off');    
set(handles.TELA_Caixa5, 'Value',0); 
set(handles.TELA_Caixa6, 'String', '');    
set(handles.TELA_Caixa6, 'Enable','off');
set(handles.TELA_Caixa6, 'Value',0); 
set(handles.TELA_Caixa7, 'String', '');    
set(handles.TELA_Caixa7, 'Enable','off');    
set(handles.TELA_Caixa7, 'Value',0); 
set(handles.TELA_Caixa8, 'String', '');    
set(handles.TELA_Caixa8, 'Enable','off'); 
set(handles.TELA_Caixa8, 'Value',0); 
set(handles.TELA_Caixa9, 'String', '');    
set(handles.TELA_Caixa9, 'Enable','off');    
set(handles.TELA_Caixa9, 'Value',0); 
set(handles.TELA_Caixa10, 'String', '');    
set(handles.TELA_Caixa10, 'Enable','off');
set(handles.TELA_Caixa10, 'Value',0); 
set(handles.TELA_Caixa11, 'String', '');    
set(handles.TELA_Caixa11, 'Enable','off');    
set(handles.TELA_Caixa11, 'Value',0); 
set(handles.TELA_Caixa12, 'String', '');    
set(handles.TELA_Caixa12, 'Enable','off'); 
set(handles.TELA_Caixa12, 'Value',0); 
set(handles.TELA_Caixa13, 'String', '');    
set(handles.TELA_Caixa13, 'Enable','off');    
set(handles.TELA_Caixa13, 'Value',0); 
set(handles.TELA_Caixa14, 'String', '');    
set(handles.TELA_Caixa14, 'Enable','off');    
set(handles.TELA_Caixa14, 'Value',0); 
set(handles.TELA_Caixa15, 'String', '');    
set(handles.TELA_Caixa15, 'Enable','off');    
set(handles.TELA_Caixa15, 'Value',0); 
set(handles.TELA_Caixa16, 'String', '');    
set(handles.TELA_Caixa16, 'Enable','off');  
set(handles.TELA_Caixa16, 'Value',0); 


% Choose default command line output for Compara
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Compara wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Compara_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in TELA_BotaoCarregaEmpresas.
function TELA_BotaoCarregaEmpresas_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_BotaoCarregaEmpresas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -------------------------------------------------------------------------
% (*) Prepara a tela para an�lise.
cla reset;
set(handles.TELA_Caixa1, 'String', '');    
set(handles.TELA_Caixa1, 'Enable','off'); 
set(handles.TELA_Caixa1, 'Value',0); 
set(handles.TELA_Caixa2, 'String', '');    
set(handles.TELA_Caixa2, 'Enable','off');  
set(handles.TELA_Caixa2, 'Value',0); 
set(handles.TELA_Caixa3, 'String', '');    
set(handles.TELA_Caixa3, 'Enable','off');    
set(handles.TELA_Caixa3, 'Value',0); 
set(handles.TELA_Caixa4, 'String', '');    
set(handles.TELA_Caixa4, 'Enable','off');    
set(handles.TELA_Caixa4, 'Value',0); 
set(handles.TELA_Caixa5, 'String', '');    
set(handles.TELA_Caixa5, 'Enable','off');    
set(handles.TELA_Caixa5, 'Value',0); 
set(handles.TELA_Caixa6, 'String', '');    
set(handles.TELA_Caixa6, 'Enable','off');
set(handles.TELA_Caixa6, 'Value',0); 
set(handles.TELA_Caixa7, 'String', '');    
set(handles.TELA_Caixa7, 'Enable','off');    
set(handles.TELA_Caixa7, 'Value',0); 
set(handles.TELA_Caixa8, 'String', '');    
set(handles.TELA_Caixa8, 'Enable','off'); 
set(handles.TELA_Caixa8, 'Value',0); 
set(handles.TELA_Caixa9, 'String', '');    
set(handles.TELA_Caixa9, 'Enable','off');    
set(handles.TELA_Caixa9, 'Value',0); 
set(handles.TELA_Caixa10, 'String', '');    
set(handles.TELA_Caixa10, 'Enable','off');
set(handles.TELA_Caixa10, 'Value',0); 
set(handles.TELA_Caixa11, 'String', '');    
set(handles.TELA_Caixa11, 'Enable','off');    
set(handles.TELA_Caixa11, 'Value',0); 
set(handles.TELA_Caixa12, 'String', '');    
set(handles.TELA_Caixa12, 'Enable','off'); 
set(handles.TELA_Caixa12, 'Value',0); 
set(handles.TELA_Caixa13, 'String', '');    
set(handles.TELA_Caixa13, 'Enable','off');    
set(handles.TELA_Caixa13, 'Value',0); 
set(handles.TELA_Caixa14, 'String', '');    
set(handles.TELA_Caixa14, 'Enable','off');    
set(handles.TELA_Caixa14, 'Value',0); 
set(handles.TELA_Caixa15, 'String', '');    
set(handles.TELA_Caixa15, 'Enable','off');    
set(handles.TELA_Caixa15, 'Value',0); 
set(handles.TELA_Caixa16, 'String', '');    
set(handles.TELA_Caixa16, 'Enable','off');  
set(handles.TELA_Caixa16, 'Value',0); 

% -------------------------------------------------------------------------
% (*) A primeira parte do programa selecionar� A PASTA a qual tem os
%     arquivos '*.mat'.
DiretorioRaiz = uigetdir();

% -------------------------------------------------------------------------
% (*) A segunda parte selecionar� os arquivos '*.mat' dentro da pasta
%     selecionada. Essa sele��o pode ser m�ltipla, bastando apenas segurar
%     o bot�o CTRL enquanto seleciona os arquivos.
[Empresa,~,~] = uigetfile(fullfile(DiretorioRaiz, '*.mat'), 'MultiSelect', 'on');
addpath(DiretorioRaiz);
clear DiretorioRaiz;

% -------------------------------------------------------------------------
% (*) Verifica a quantidade m�xima de empresas selecionadas e j� abre o GUI
%     para a sele��o do 'Indicador' desejado e do per�odo levado em conta.
Empresa = cellstr(Empresa);
n       = max(size(Empresa));
if (n == 1)
    handles.Empresa{1} = load(Empresa{1});
else
    for i=1:n
        handles.Empresa{i} = load(Empresa{i});
    end
end
handles.totalEmpresas = n;

% -------------------------------------------------------------------------
% (*) Defini��o do sistemas de Cores
handles.Cor = {'b-o','g-o','r-o','c-o','m-o','y-o','k-o','b-.o','g-.o','r-.o','c-.o','m-.o','y-.o',...
               'k-.o'}; 
   
% -------------------------------------------------------------------------
% (*) Flag para saber se tem a quantidade de empresas listadas. 
flag = linspace(0,0,16);
for i=1:n
    flag(i) = 1;
end
% handles.flag = flag;
    
% -------------------------------------------------------------------------
% (*) Preenche as posi��es com os nomes das empresas.
%
% 1� Posi��o
if (flag(1) == 1)
    set(handles.TELA_Caixa1, 'String', handles.Empresa{1}.o.Nome);
    set(handles.TELA_Caixa1, 'Enable','on');   
else
    set(handles.TELA_Caixa1, 'Enable','off');    
end

% 2� Posi��o
if (flag(2) == 1)
    set(handles.TELA_Caixa2, 'String', handles.Empresa{2}.o.Nome);    
    set(handles.TELA_Caixa2, 'Enable','on');   
else
    set(handles.TELA_Caixa2, 'Enable','off');    
end
    
% 3� Posi��o
if (flag(3) == 1)
    set(handles.TELA_Caixa3, 'String', handles.Empresa{3}.o.Nome);    
    set(handles.TELA_Caixa3, 'Enable','on');   
else
    set(handles.TELA_Caixa3, 'Enable','off');    
end

% 4� Posi��o
if (flag(4) == 1)
    set(handles.TELA_Caixa4, 'String', handles.Empresa{4}.o.Nome);
    set(handles.TELA_Caixa4, 'Enable','on');   
else
    set(handles.TELA_Caixa4, 'Enable','off');    
end

% 5� Posi��o
if (flag(5) == 1)
    set(handles.TELA_Caixa5, 'String', handles.Empresa{5}.o.Nome);
    set(handles.TELA_Caixa5, 'Enable','on');   
else
    set(handles.TELA_Caixa5, 'Enable','off');    
end

% 6� Posi��o
if (flag(6) == 1)
    set(handles.TELA_Caixa6, 'String', handles.Empresa{6}.o.Nome);    
    set(handles.TELA_Caixa6, 'Enable','on');   
else
    set(handles.TELA_Caixa6, 'Enable','off');    
end

% 7� Posi��o
if (flag(7) == 1)
    set(handles.TELA_Caixa7, 'String', handles.Empresa{7}.o.Nome);    
    set(handles.TELA_Caixa7, 'Enable','on');   
else
    set(handles.TELA_Caixa7, 'Enable','off');    
end

% 8� Posi��o
if (flag(8) == 1)
    set(handles.TELA_Caixa8, 'String', handles.Empresa{8}.o.Nome);    
    set(handles.TELA_Caixa8, 'Enable','on');   
else
    set(handles.TELA_Caixa8, 'Enable','off');    
end

% 9� Posi��o
if (flag(9) == 1)
    set(handles.TELA_Caixa9, 'String', handles.Empresa{9}.o.Nome);    
    set(handles.TELA_Caixa9, 'Enable','on');   
else
    set(handles.TELA_Caixa9, 'Enable','off');    
end

% 10� Posi��o
if (flag(10) == 1)
    set(handles.TELA_Caixa10, 'String', handles.Empresa{10}.o.Nome);    
    set(handles.TELA_Caixa10, 'Enable','on');   
else
    set(handles.TELA_Caixa10, 'Enable','off');    
end

% 11� Posi��o
if (flag(11) == 1)
    set(handles.TELA_Caixa11, 'String', handles.Empresa{11}.o.Nome);    
    set(handles.TELA_Caixa11, 'Enable','on');   
else
    set(handles.TELA_Caixa11, 'Enable','off');    
end

% 12� Posi��o
if (flag(12) == 1)
    set(handles.TELA_Caixa12, 'String', handles.Empresa{12}.o.Nome);    
    set(handles.TELA_Caixa12, 'Enable','on');   
else
    set(handles.TELA_Caixa12, 'Enable','off');    
end

% 13� Posi��o
if (flag(13) == 1)
    set(handles.TELA_Caixa13, 'String', handles.Empresa{13}.o.Nome);  
    set(handles.TELA_Caixa13, 'Enable','on');   
else
    set(handles.TELA_Caixa13, 'Enable','off');    
end

% 14� Posi��o
if (flag(14) == 1)
    set(handles.TELA_Caixa14, 'String', handles.Empresa{14}.o.Nome);    
    set(handles.TELA_Caixa14, 'Enable','on');   
else
    set(handles.TELA_Caixa14, 'Enable','off');    
end

% 15� Posi��o
if (flag(15) == 1)
    set(handles.TELA_Caixa15, 'String', handles.Empresa{15}.o.Nome); 
    set(handles.TELA_Caixa15, 'Enable','on');   
else
    set(handles.TELA_Caixa15, 'Enable','off');    
end

% 16� Posi��o
if (flag(16) == 1)
    set(handles.TELA_Caixa16, 'String', handles.Empresa{16}.o.Nome); 
    set(handles.TELA_Caixa16, 'Enable','on');   
else
    set(handles.TELA_Caixa16, 'Enable','off');    
end

% -------------------------------------------------------------------------
% Choose default command line output for BovespaFundamentus
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);



% --- Executes on selection change in TELA_Indicadores.
function TELA_Indicadores_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Indicadores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TELA_Indicadores contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TELA_Indicadores


% --- Executes during object creation, after setting all properties.
function TELA_Indicadores_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TELA_Indicadores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TELA_Anual.
function TELA_Anual_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Anual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Anual


% --- Executes on button press in TELA_Trimestral.
function TELA_Trimestral_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Trimestral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Trimestral


% --- Executes on selection change in TELA_Periodo.
function TELA_Periodo_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Periodo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TELA_Periodo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TELA_Periodo


% --- Executes during object creation, after setting all properties.
function TELA_Periodo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TELA_Periodo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TELA_Grafico.
function TELA_Grafico_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Grafico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TELA_Caixa1.
function TELA_Caixa1_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa1


% --- Executes on button press in TELA_Caixa2.
function TELA_Caixa2_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa2


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in TELA_Caixa3.
function TELA_Caixa3_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa3


% --- Executes on button press in TELA_Caixa4.
function TELA_Caixa4_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa4


% --- Executes on button press in TELA_Caixa5.
function TELA_Caixa5_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa5


% --- Executes on button press in TELA_Caixa6.
function TELA_Caixa6_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa6


% --- Executes on button press in TELA_Caixa7.
function TELA_Caixa7_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa7


% --- Executes on button press in TELA_Caixa8.
function TELA_Caixa8_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa8


% --- Executes on button press in TELA_Caixa9.
function TELA_Caixa9_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa9


% --- Executes on button press in TELA_Caixa10.
function TELA_Caixa10_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa10


% --- Executes on button press in TELA_Caixa11.
function TELA_Caixa11_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa11


% --- Executes on button press in TELA_Caixa12.
function TELA_Caixa12_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa12


% --- Executes on button press in TELA_Caixa13.
function TELA_Caixa13_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa13


% --- Executes on button press in TELA_Caixa14.
function TELA_Caixa14_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa14


% --- Executes on button press in TELA_Caixa15.
function TELA_Caixa15_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa15


% --- Executes on button press in TELA_Caixa16.
function TELA_Caixa16_Callback(hObject, eventdata, handles)
% hObject    handle to TELA_Caixa16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TELA_Caixa16


% --- Executes when selected object is changed in TELA_Indicadores.
function TELA_Indicadores_SelectionChangeFcn(hObject, eventdata, handles)

% -------------------------------------------------------------------------
% (*) Pega todos os dados salvos pelo 'guidata', ou seja, leio eles 
%     OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
handles = guidata(hObject);

% (*) Verifica qual o indicador que ser� selecionado por vez.
Indicador = get(hObject,'String');

% -------------------------------------------------------------------------
% (*) Verifica qual a empresa que est� selecionada.
flag(1)  = get(handles.TELA_Caixa1,'Value');
flag(2)  = get(handles.TELA_Caixa2,'Value');
flag(3)  = get(handles.TELA_Caixa3,'Value');
flag(4)  = get(handles.TELA_Caixa4,'Value');
flag(5)  = get(handles.TELA_Caixa5,'Value');
flag(6)  = get(handles.TELA_Caixa6,'Value');
flag(7)  = get(handles.TELA_Caixa7,'Value');
flag(8)  = get(handles.TELA_Caixa8,'Value');
flag(9)  = get(handles.TELA_Caixa9,'Value');
flag(10) = get(handles.TELA_Caixa10,'Value');
flag(11) = get(handles.TELA_Caixa11,'Value');
flag(12) = get(handles.TELA_Caixa12,'Value');
flag(13) = get(handles.TELA_Caixa13,'Value');
flag(14) = get(handles.TELA_Caixa14,'Value');
flag(15) = get(handles.TELA_Caixa15,'Value');
flag(16) = get(handles.TELA_Caixa16,'Value');


% -------------------------------------------------------------------------
% (*) Existe alguma empresa selecionada?
contador = 0;
for i=1:16
    if(flag(i) == 1)
        contador = contador + 1;
    end
end

% (*) Se existir, fa�a o gr�fico imprimir o referido Indicador no gr�fico
if (contador > 0)
    cla reset;
    % Legenda  = {};
    contador = 0;
    for i=1:16
        if (flag(i) == 1)
            contador    = contador + 1;
            a(contador) = handles.Empresa{i}.o;
        end   
    end
    
    % (*) Plota o resultado no gr�fico
    Legenda = {};
    for i=1:contador
        a(i).plotaIndicador(Indicador,handles.Cor{i},'Trimestre');
        hold on;
        Legenda{i} = a(i).Nome;
    end
    legend(Legenda,'Location','NorthEastOutside');
    grid on;
else
    cla reset;
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Texto = {'O ROE mede a rentabilidade da empresa para os acionistas. ',
         '',
         'ROE = return on equity (na sigle em ingl�s) � calculado da',
         'seguinte forma:',
         '',
         '                                     Lucro L�quido*',
         '                   ROE = ---------------------------------',
         '                                 Patrim�nio L�quido**',
         '',
         '(*)  Lucro acumulado nos �ltimos 12 meses.',
         '(**) Pode ser extra�do do �ltimo balan�o ou calculado como',
         '      uma m�dia dos �ltimos 12 meses. Se a empresa fosse',
         '      encerrada hoje, quanto sobraria ap�s quitar todas as', 
         '      d�vidas e obriga��es financeiras?',
         '',
         'O ROE mede o retorno sobre o capital investido na empresa ',
         '(para empresas sem d�vidas). O ROE mede a efici�ncia dos ',
         'lucros para os acionistas das empresas.',
         '',
         'O ROE mede a qualidade dos investimentos da companhia para',
         'gerar crescimento de lucros futuros. O ROE mede a efici�ncia',
         'da aloca��o de capital.'};
h = msgbox(Texto, 'ROE');


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Texto = {'Ap�s pagar todas as obriga��es financeiras (funcion�rios,',
         'impostos, deb�ntures, empr�stimos, material, energia',
         'aluguel, �gua etc), qual foi o resultado da empresa?',
         'Deu positivo ou negativo?',
         '',
         'Obviamente � interessante que este valor seja sempre positivo',
         'e preferencialmente crescente.',
         '',
         'Importante fazer um comparativo entre os trimestres, para',
         'que a medida n�o fique com nenhum vi�s de sazonalidade.'};
msgbox(Texto, 'Lucro L�quido');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Texto = {'O �ndice de Liquidez Corrente � o melhor indicador de solv�ncia',
         'de curto prazo, pois revela a prote��o dos credores em curto ',
         'prazo por ativos, onde h� uma expectativa que estes possam ser',
         'convertidos em dinheiro rapidamente. A f�rmula para se calcular',
         'o �ndice de liquidez corrente � a seguinte:',
         ''
         '                                                     Ativo Circulante*  ',
         'Indice de Liquidez Corrente = -------------------------------------',
         '                                                   Passivo Circulante**',
         '',
         '(*) O Ativo Circulante agrupa dinheiro e tudo o que ser� ',
         'transformado em  dinheiro rapidamente. S�o contas que est�o',
         'constantemente em giro, movimento, circula��o. Neste grupo ',
         's�o registrados os bens e direitos que a empresa consegue ',
         'realizar (transformar) em dinheiro at� o final do exerc�cio',
         'seguinte, ou seja, no curto prazo.',
         '(**) O Passivo Circulante engloba as obriga��es da entidade',
         ' como sal�rios, 13�, tributos, fornecedores, bancos e insti-',
         'tui��es financeiras, acionistas etc. com horizonte de',
         'curto prazo (menor que 1 ano).',
         '',
         'Como podemos notar atrav�s da f�rmula, seu c�lculo � feito a ',
         'partir dos direitos de curto prazo da empresa, como caixa, ',
         'estoques, contas a receber e as d�vidas de curto prazo, como',
         'empr�stimos e financiamentos.',
         'Se o resultado do �ndice de liquidez corrente for > 1, significa',
         'que a empresa possui meios de honrar com suas obriga��es de ',
         'curto prazo, demonstrando uma folga no dispon�vel. Se o ',
         'resultado for = 1, significa que os direitos e obriga��es de ',
         'curto prazo s�o iguais. J� se o resultado for < 1, a empresa ',
         'poder� apresentar problemas, pois suas disponibilidades s�o ',
         'insuficientes para honrar com suas obriga��es de curto prazo.',
         '',
         'Entretanto, apresentar um alto �ndice de liquidez corrente pode',
         'n�o ser t�o bom assim, pois poder� significar que a empresa ',
         'possui muito dinheiro atrelado a ativos n�o produtivos, como',
         'estoques que n�o est�o sendo vendidos e se tornando obsoletos.',
         'O correto sempre � analisar os �ndices do setor, achando uma',
         'm�dia para o �ndice de liquidez corrente. Se estiver acima da',
         'm�dia, poder� ser uma boa not�cia, mas se estiver muito abaixo',
         'da m�dia, pode ser que a empresa esteja passando por dificuldades',
         'financeiras.'};
msgbox(Texto, '�ndice de Liquidez Corrente');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Texto = {'Ap�s pagar todas as obriga��es financeiras (funcion�rios,',
         'impostos, deb�ntures, empr�stimos, material, energia',
         'aluguel, �gua etc), qual foi o resultado da empresa?',
         'Deu positivo ou negativo?',
         '',
         'Obviamente � interessante que este valor seja sempre positivo',
         'e preferencialmente crescente.'};
msgbox(Texto, 'Lucro L�quido');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Texto = {'A margem bruta mede a rentabilidade do seu neg�cio, ou seja, ',
         'qual a porcentagem de lucro que voc� ganha com cada venda. Por',
         'exemplo, se voc� vende seus produtos a R$40 mas gasta R$20 para',
         'coloc�-los nas lojas, voc� est� ganhando apenas R$20.',
         '',
         'Para compreender o que � o termo Margem Bruta � preciso ter em', 
         'mente os conceitos de custos vari�veis e receita total. Custos ',
         'vari�veis s�o todos aqueles que variam de acordo com a quantidade',
         'produzida. Ex: se uma padaria produz 1000 p�es, seu custo com',
         'farinha de trigo � X. Se ela produzir 100 p�es, seu custo com',
         'farinha de trigo � Y, por�m, inferior ao �ltimo caso. Se essa',
         'mesma padaria opta por n�o produzir nenhum p�o, seu custo com',
         'farinha de trigo ser� zero (supondo que essa hipot�tica padaria',
         'produza apenas p�es). Dessa forma, o valor gasto com farinha de',
         'trigo � um custo vari�vel, pois ele depende diretamente da',
         'quantidade de p�es que a padaria decide produzir. J� a receita',
         'total pode ser compreendida como o produto entre o pre�o do bem',
         'ou servi�o em quest�o e a quantidade de vendas desse mesmo bem ou',
         'servi�o. Em forma de equa��o matem�tica:',
         ''
         '            Receita Total = Pre�o x Quantidade.',
         '',
         'Sendo assim, e agora de forma muito mais simples, lucro bruto se',
         'trata da diferen�a entre receita total e custos vari�veis, ou ',
         'seja:',
         '',
         '           Lucro Bruto = Receita Total - Custos Vari�veis.',
         '',
         'A Margem Bruta � calculada da seguinte forma:',
         ''
         '                                           Lucro Bruto*  ',
         '           Margem Bruta = ------------------------------ x100%',
         '                                         Receita Total**',
         ''};     
msgbox(Texto, 'Margem Bruta');


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Texto = {'A margem l�quida � o lucro l�quido que a empresa faz para cada', 
         'real em receita. Essa margem ilustra a quantidade de dinheiro',
         'que a empresa lucra a cada real de receita obtido depois de',
         'pagar todas as suas despesas e impostos.',
         '',
         'Assim como no t�pico Margem Bruta, para a compreens�o de lucro',
         'l�quido � necess�rio primeiramente conhecer os conceitos de custo',
         'fixo e custo total. Custos fixos s�o todos aqueles que n�o ',
         'dependem da quantidade produzida. Ex: voltando ao caso da padaria,',
         'independentemente desta optar por produzir p�es ou n�o e de qual',
         'ser� a quantidade produzida, no final do m�s ela ter� de pagar ',
         'os sal�rios de seus funcion�rios, seu aluguel, etc. Dessa forma,',
         'os valores gastos com sal�rios e aluguel, por exemplo, s�o custos',
         'fixos, pois eles n�o dependem da quantidade de p�es produzidos.'
         '',
         'E o custo total, assim como o pr�prio nome diz, se trata da ',
         'simples soma de todos os custos, sejam eles fixos ou vari�veis,',
         'como farinha de trigo, aluguel e sal�rios. Em forma de equa��o',
         'matem�tica, ficaria: Custo Total = Custos Fixos + Custos ',
         'Vari�veis. Vale ressaltar que alguns impostos assumem a forma de',
         'custos fixos, como o IPTU, por exemplo, e outros assumem a forma',
         'de custos vari�veis, como o ICMS.',
         'Por fim, o lucro l�quido se trata da diferen�a entre a receita',
         'total e custo total, ou seja:',
         '',
         '         Lucro L�quido = Receita Total - Custo Total',
         '',
         'Al�m disso, sabemos que:',
         ''
         '            Receita Total = Pre�o x Quantidade.',
         '',
         'A Margem L�quida � calculada da seguinte forma:',
         ''
         '                                            Lucro L�quido  ',
         '           Margem L�quida = ---------------------------- x100%',
         '                                            Receita Total',
         ''};       
msgbox(Texto, 'Margem L�quida');