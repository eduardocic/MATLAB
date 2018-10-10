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

% Last Modified by GUIDE v2.5 07-Mar-2018 13:18:52

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


%**************************************************************************
%                        Prepara a tela para análise.
%
%**************************************************************************
clc;
cla reset;

% -- Deixa todo mundo não selecionável até que as empresas seja carregadas.
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

%**************************************************************************
%  Realiza a leitura dos arquivos Excel baixados do site 'Fundamentus'.
%
%**************************************************************************
Main;

% -- Salvo os valores na variável 'o' (recém carregados por 'Main');
handles.o = o;

% -- Definição do sistemas de Cores a ser utilizado na análise.
handles.Cor = {'b-o', 'g-o', 'r-o', 'c-o', 'm-o', 'y-o', 'k-o', 'b-.o',...
               'g-.o', 'r-.o', 'c-.o', 'm-.o', 'y-.o', 'k-.o'}; 
   
% -- Flag para saber se tem a quantidade de empresas listadas. 
flag = linspace(0,0,16);
for i=1:max(size(o))
    flag(i) = 1;
end
handles.flag = flag;
    
% (*) Preenche as posições com os nomes das empresas.
%
% 1º Posição
if (flag(1) == 1)
    set(handles.TELA_Caixa1, 'String', o(1).NomeEmpresa);
    set(handles.TELA_Caixa1, 'Enable','on');   
else
    set(handles.TELA_Caixa1, 'Enable','off');    
end

% 2º Posição
if (flag(2) == 1)
    set(handles.TELA_Caixa2, 'String', o(2).NomeEmpresa);    
    set(handles.TELA_Caixa2, 'Enable','on');   
else
    set(handles.TELA_Caixa2, 'Enable','off');    
end
    
% 3º Posição
if (flag(3) == 1)
    set(handles.TELA_Caixa3, 'String', o(3).NomeEmpresa);    
    set(handles.TELA_Caixa3, 'Enable','on');   
else
    set(handles.TELA_Caixa3, 'Enable','off');    
end

% 4º Posição
if (flag(4) == 1)
    set(handles.TELA_Caixa4, 'String', o(4).NomeEmpresa);
    set(handles.TELA_Caixa4, 'Enable','on');   
else
    set(handles.TELA_Caixa4, 'Enable','off');    
end

% 5º Posição
if (flag(5) == 1)
    set(handles.TELA_Caixa5, 'String', o(5).NomeEmpresa);
    set(handles.TELA_Caixa5, 'Enable','on');   
else
    set(handles.TELA_Caixa5, 'Enable','off');    
end

% 6º Posição
if (flag(6) == 1)
    set(handles.TELA_Caixa6, 'String', o(6).NomeEmpresa);    
    set(handles.TELA_Caixa6, 'Enable','on');   
else
    set(handles.TELA_Caixa6, 'Enable','off');    
end

% 7º Posição
if (flag(7) == 1)
    set(handles.TELA_Caixa7, 'String', o(7).NomeEmpresa);    
    set(handles.TELA_Caixa7, 'Enable','on');   
else
    set(handles.TELA_Caixa7, 'Enable','off');    
end

% 8º Posição
if (flag(8) == 1)
    set(handles.TELA_Caixa8, 'String', o(8).NomeEmpresa);    
    set(handles.TELA_Caixa8, 'Enable','on');   
else
    set(handles.TELA_Caixa8, 'Enable','off');    
end

% 9º Posição
if (flag(9) == 1)
    set(handles.TELA_Caixa9, 'String', o(8).NomeEmpresa);    
    set(handles.TELA_Caixa9, 'Enable','on');   
else
    set(handles.TELA_Caixa9, 'Enable','off');    
end

% 10º Posição
if (flag(10) == 1)
    set(handles.TELA_Caixa10, 'String', o(10).NomeEmpresa);    
    set(handles.TELA_Caixa10, 'Enable','on');   
else
    set(handles.TELA_Caixa10, 'Enable','off');    
end

% 11º Posição
if (flag(11) == 1)
    set(handles.TELA_Caixa11, 'String', o(11).NomeEmpresa);    
    set(handles.TELA_Caixa11, 'Enable','on');   
else
    set(handles.TELA_Caixa11, 'Enable','off');    
end

% 12º Posição
if (flag(12) == 1)
    set(handles.TELA_Caixa12, 'String', o(12).NomeEmpresa);    
    set(handles.TELA_Caixa12, 'Enable','on');   
else
    set(handles.TELA_Caixa12, 'Enable','off');    
end

% 13º Posição
if (flag(13) == 1)
    set(handles.TELA_Caixa13, 'String', o(13).NomeEmpresa);  
    set(handles.TELA_Caixa13, 'Enable','on');   
else
    set(handles.TELA_Caixa13, 'Enable','off');    
end

% 14º Posição
if (flag(14) == 1)
    set(handles.TELA_Caixa14, 'String', o(14).NomeEmpresa);    
    set(handles.TELA_Caixa14, 'Enable','on');   
else
    set(handles.TELA_Caixa14, 'Enable','off');    
end

% 15º Posição
if (flag(15) == 1)
    set(handles.TELA_Caixa15, 'String', o(15).NomeEmpresa); 
    set(handles.TELA_Caixa15, 'Enable','on');   
else
    set(handles.TELA_Caixa15, 'Enable','off');    
end

% 16º Posição
if (flag(16) == 1)
    set(handles.TELA_Caixa16, 'String', o(16).NomeEmpresa); 
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




% --- Executes on selection change in Indicador.
function Indicador_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------
% (*) Pega todos os dados salvos pelo 'guidata', ou seja, leio eles 
%     OBRIGATÓRIO SE EXISTIR ATUALIZAÇÃO DE VARIÁVEIS GLOBAIS.
handles = guidata(hObject);

o = handles.o;  % Recupera os objetos carregados do sistema

% (*) Verifica qual o Indicador que será selecionado por vez.
Indicadores = get(hObject,'String');
Qual = get(hObject,'Value');
Indicador = Indicadores(Qual);

% -------------------------------------------------------------------------
% (*) Verifica qual a empresa que está selecionada.
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

% (*) Se existir, faça o gráfico imprimir o referido Indicador no gráfico
if (contador > 0)
    cla reset;
    % Legenda  = {};
    contador = 0;
    for i = 1:16
        if (flag(i) == 1)
            contador    = contador + 1;
            a(contador) = handles.o(i);
        end   
    end
    
    % (*) Plota o resultado no gráfico
    Legenda = {};
    for i = 1:contador
        a(i).plotaIndicador(Indicador, handles.Cor{i});
        hold on;
        Legenda{i} = a(i).NomeEmpresa;
    end
    legend(Legenda,'Location','NorthEastOutside');
    grid on;
else
    cla reset;
end



% --- Executes during object creation, after setting all properties.
function Indicador_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Indicador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
