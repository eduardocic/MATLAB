function varargout = Interface(varargin)
% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface

% Last Modified by GUIDE v2.5 13-Jan-2017 13:10:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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


% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

% Choose default command line output for Interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Quantidade_Callback(hObject, eventdata, handles)
% hObject    handle to Quantidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Quantidade as text
%        str2double(get(hObject,'String')) returns contents of Quantidade as a double


% --- Executes during object creation, after setting all properties.
function Quantidade_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Quantidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PrecoAcao_Callback(hObject, eventdata, handles)
% hObject    handle to PrecoAcao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PrecoAcao as text
%        str2double(get(hObject,'String')) returns contents of PrecoAcao as a double


% --- Executes during object creation, after setting all properties.
function PrecoAcao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PrecoAcao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio_Callback(hObject, eventdata, handles)
% hObject    handle to Premio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio as text
%        str2double(get(hObject,'String')) returns contents of Premio as a double


% --- Executes during object creation, after setting all properties.
function Premio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio as text
%        str2double(get(hObject,'String')) returns contents of Exercicio as a double


% --- Executes during object creation, after setting all properties.
function Exercicio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -------------------------------------------------------------------------
% A primeira coisa que tem que ser feita é verificar quantas as opções
% estão sendo verificadas por vez. Para fazer isso, a ideia é verificar uma
% a uma até onde os dados foram inseridos.


SelBotao   = get(handles.Botao, 'Value');
Exercicio1 = get(handles.Exercicio1, 'String');
Exercicio2 = get(handles.Exercicio2, 'String');
Exercicio3 = get(handles.Exercicio3, 'String');
Exercicio4 = get(handles.Exercicio4, 'String');
Exercicio5 = get(handles.Exercicio5, 'String');
Exercicio6 = get(handles.Exercicio6, 'String');
Exercicio7 = get(handles.Exercicio7, 'String');
Exercicio8 = get(handles.Exercicio8, 'String');
Exercicio(1) = str2double(Exercicio1);
Exercicio(2) = str2double(Exercicio2);
Exercicio(3) = str2double(Exercicio3);
Exercicio(4) = str2double(Exercicio4);
Exercicio(5) = str2double(Exercicio5);
Exercicio(6) = str2double(Exercicio6);
Exercicio(7) = str2double(Exercicio7);
Exercicio(8) = str2double(Exercicio8);

% -------------------------------------------------------------------------
% Verifica se tem opção.
cont = 0;
alfa = isnan(Exercicio);
for i=1:8
   if(alfa(i) == 0)
       cont = cont + 1;
   end
end 

if (SelBotao == 0 && cont == 0)
    string = 'Digite ao menos uma opção!!!';
    set(handles.Texto, 'String', string);
    
    END = [zeros(1,6)];
else
% -------------------------------------------------------------------------
if (SelBotao == 1)
    load('PrecosOpcoes.mat');
    n = max(size(Premio));
    
    for i=1:n
        u(i) = Agora;
    end
    
    % Quantidade de Ativos.
    Quantidade = get(handles.Quantidade, 'String');
    Quantidade = str2double(Quantidade);
    % Preço Ação.
    PrecoAcao  = get(handles.PrecoAcao, 'String');
    PrecoAcao  = str2double(PrecoAcao);
    
    % -------------------------------------------------------------------------
    %                           Cálculos Iniciais
    for i=1:n
        totalCompraAcao(i)      = u(i).CustoCompraAcao(Quantidade, PrecoAcao);
        totalVendaOpcao(i)      = u(i).CustoVendaOpcao(Quantidade, Premio(i));
        totalVendaExercicio(i)  = u(i).Exercido(Quantidade, Exercicio(i));
        PremioRes(i)            = Premio(i);
        ExercicioRes(i)         = Exercicio(i);
    end
    
    % ---------------------------------------------------------------------
    %                       Cálculos intermediários
    for i=1:n
        ResExeBruto(i)   = totalVendaExercicio(i) + totalVendaOpcao(i) - totalCompraAcao(i);
        ImpostoExe(i)    = ResExeBruto(i)*0.15;
        ResExeLiq(i)     = ResExeBruto(i) - ImpostoExe(i);
        ResExeLiqPerc(i) = 100*ResExeLiq(i)/totalCompraAcao(i);

        Protecao(i)      = PrecoAcao - Premio(i);
    end
    
    END = [num2cell(ExercicioRes') num2cell(PremioRes')  num2cell(Protecao') ...
           num2cell(ResExeLiqPerc') num2cell(ResExeLiq') num2cell(ImpostoExe')];
    
else
    Exercicio1 = get(handles.Exercicio1, 'String');
    Exercicio2 = get(handles.Exercicio2, 'String');
    Exercicio3 = get(handles.Exercicio3, 'String');
    Exercicio4 = get(handles.Exercicio4, 'String');
    Exercicio5 = get(handles.Exercicio5, 'String');
    Exercicio6 = get(handles.Exercicio6, 'String');
    Exercicio7 = get(handles.Exercicio7, 'String');
    Exercicio8 = get(handles.Exercicio8, 'String');
    Exercicio(1) = str2double(Exercicio1);
    Exercicio(2) = str2double(Exercicio2);
    Exercicio(3) = str2double(Exercicio3);
    Exercicio(4) = str2double(Exercicio4);
    Exercicio(5) = str2double(Exercicio5);
    Exercicio(6) = str2double(Exercicio6);
    Exercicio(7) = str2double(Exercicio7);
    Exercicio(8) = str2double(Exercicio8);

    % ---------------------------------------------------------------------
    % Pega a quantidade de opções analisadas.
    cont = 0;
    alfa = isnan(Exercicio);
    for i=1:8
       if(alfa(i) == 0)
           cont = cont + 1;
       end
    end

    if (cont == 0)
    %     exit;
    else
        for i=1:cont
            o(i) = Agora;
        end
    end
    clc;

    % Quantidade de Ativos.
    Quantidade = get(handles.Quantidade, 'String');
    Quantidade = str2double(Quantidade);
    % Preço Ação.
    PrecoAcao  = get(handles.PrecoAcao, 'String');
    PrecoAcao  = str2double(PrecoAcao);
    % Prêmios.
    Premio1     = get(handles.Premio1, 'String');
    Premio2     = get(handles.Premio2, 'String');
    Premio3     = get(handles.Premio3, 'String');
    Premio4     = get(handles.Premio4, 'String');
    Premio5     = get(handles.Premio5, 'String');
    Premio6     = get(handles.Premio6, 'String');
    Premio7     = get(handles.Premio7, 'String');
    Premio8     = get(handles.Premio8, 'String');
    Premio(1)   = str2double(Premio1);
    Premio(2)   = str2double(Premio2);
    Premio(3)   = str2double(Premio3);
    Premio(4)   = str2double(Premio4);
    Premio(5)   = str2double(Premio5);
    Premio(6)   = str2double(Premio6);
    Premio(7)   = str2double(Premio7);
    Premio(8)   = str2double(Premio8);
    
    % -------------------------------------------------------------------------
    %                           Cálculos Iniciais
    for i=1:cont
        totalCompraAcao(i)      = o(i).CustoCompraAcao(Quantidade, PrecoAcao);
        totalVendaOpcao(i)      = o(i).CustoVendaOpcao(Quantidade, Premio(i));
        totalVendaExercicio(i)  = o(i).Exercido(Quantidade, Exercicio(i));
        PremioRes(i)            = Premio(i);
        ExercicioRes(i)         = Exercicio(i);
    end

    % ---------------------------------------------------------------------
    %                       Cálculos intermediários
    for i=1:cont
        ResExeBruto(i)   = totalVendaExercicio(i) + totalVendaOpcao(i) - totalCompraAcao(i);
        ImpostoExe(i)    = ResExeBruto(i)*0.15;
        ResExeLiq(i)     = ResExeBruto(i) - ImpostoExe(i);
        ResExeLiqPerc(i) = 100*ResExeLiq(i)/totalCompraAcao(i);

        Protecao(i)      = PrecoAcao - Premio(i);
    end

    END = [num2cell(ExercicioRes') num2cell(PremioRes')  num2cell(Protecao') ...
           num2cell(ResExeLiqPerc') num2cell(ResExeLiq') num2cell(ImpostoExe')];
end
set(handles.Texto, 'String', '');
end


set(handles.Tabela, 'Data', END);

% % -------------------------------------------------------------------------
% % Coloca os valores calculados na GUI
% set(handles.BrutoExercido, 'String', num2str(ResExeBruto));
% set(handles.BrutoExercido, 'Enable', 'on'); 
% set(handles.ImpostoExercido, 'String', num2str(ImpostoExe));
% set(handles.ImpostoExercido, 'Enable', 'on'); 
% set(handles.LiqExeReais, 'String', num2str(ResExeLiq ));
% set(handles.LiqExeReais, 'Enable', 'on'); 
% set(handles.LiqExePerc, 'String', num2str(ResExeLiqPerc));
% set(handles.LiqExePerc, 'Enable', 'on'); 
% 
% set(handles.BrutoNaoExercido, 'String', num2str(ResNaoExeBruto));
% set(handles.BrutoNaoExercido, 'Enable', 'on');
% set(handles.ImpostoNaoExercido, 'String', num2str(ImpostoNaoExe));
% set(handles.ImpostoNaoExercido, 'Enable', 'on');
% set(handles.LiqNaoExeReais, 'String', num2str(ResNaoExeLiq ));
% set(handles.LiqNaoExeReais, 'Enable', 'on');
% set(handles.LiqNaoExePerc, 'String', num2str(ResNaoExeLiqPerc));
% set(handles.LiqNaoExePerc, 'Enable', 'on');
% 
% 
% %%% Deixando Colorido :)
% if (ResExeBruto >= 0)
%     set(handles.LiqExeReais,'BackgroundColor', 'green');
%     set(handles.LiqExePerc,'BackgroundColor', 'green');
% else
%     set(handles.LiqExeReais,'BackgroundColor', 'red');
%     set(handles.LiqExePerc,'BackgroundColor', 'red');
% end
% 
% if (ResNaoExeBruto >= 0)
%     set(handles.LiqNaoExeReais,'BackgroundColor', 'green');
%     set(handles.LiqNaoExePerc,'BackgroundColor', 'green');
% else
%     set(handles.LiqNaoExeReais,'BackgroundColor', 'red');
%     set(handles.LiqNaoExePerc,'BackgroundColor', 'red');
% end


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function BrutoExercido_Callback(hObject, eventdata, handles)
% hObject    handle to BrutoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BrutoExercido as text
%        str2double(get(hObject,'String')) returns contents of BrutoExercido as a double


% --- Executes during object creation, after setting all properties.
function BrutoExercido_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BrutoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ImpostoExercido_Callback(hObject, eventdata, handles)
% hObject    handle to ImpostoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImpostoExercido as text
%        str2double(get(hObject,'String')) returns contents of ImpostoExercido as a double


% --- Executes during object creation, after setting all properties.
function ImpostoExercido_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImpostoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LiqExeReais_Callback(hObject, eventdata, handles)
% hObject    handle to LiqExeReais (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LiqExeReais as text
%        str2double(get(hObject,'String')) returns contents of LiqExeReais as a double


% --- Executes during object creation, after setting all properties.
function LiqExeReais_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LiqExeReais (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LiqExePerc_Callback(hObject, eventdata, handles)
% hObject    handle to LiqExePerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LiqExePerc as text
%        str2double(get(hObject,'String')) returns contents of LiqExePerc as a double


% --- Executes during object creation, after setting all properties.
function LiqExePerc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LiqExePerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BrutoNaoExercido_Callback(hObject, eventdata, handles)
% hObject    handle to BrutoNaoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BrutoNaoExercido as text
%        str2double(get(hObject,'String')) returns contents of BrutoNaoExercido as a double


% --- Executes during object creation, after setting all properties.
function BrutoNaoExercido_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BrutoNaoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ImpostoNaoExercido_Callback(hObject, eventdata, handles)
% hObject    handle to ImpostoNaoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImpostoNaoExercido as text
%        str2double(get(hObject,'String')) returns contents of ImpostoNaoExercido as a double


% --- Executes during object creation, after setting all properties.
function ImpostoNaoExercido_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImpostoNaoExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LiqNaoExeReais_Callback(hObject, eventdata, handles)
% hObject    handle to LiqNaoExeReais (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LiqNaoExeReais as text
%        str2double(get(hObject,'String')) returns contents of LiqNaoExeReais as a double


% --- Executes during object creation, after setting all properties.
function LiqNaoExeReais_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LiqNaoExeReais (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LiqNaoExePerc_Callback(hObject, eventdata, handles)
% hObject    handle to LiqNaoExePerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LiqNaoExePerc as text
%        str2double(get(hObject,'String')) returns contents of LiqNaoExePerc as a double


% --- Executes during object creation, after setting all properties.
function LiqNaoExePerc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LiqNaoExePerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TotalCompraAcao_Callback(hObject, eventdata, handles)
% hObject    handle to TotalCompraAcao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TotalCompraAcao as text
%        str2double(get(hObject,'String')) returns contents of TotalCompraAcao as a double


% --- Executes during object creation, after setting all properties.
function TotalCompraAcao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotalCompraAcao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TotVendaOpcao_Callback(hObject, eventdata, handles)
% hObject    handle to TotVendaOpcao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TotVendaOpcao as text
%        str2double(get(hObject,'String')) returns contents of TotVendaOpcao as a double


% --- Executes during object creation, after setting all properties.
function TotVendaOpcao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotVendaOpcao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TotExercido_Callback(hObject, eventdata, handles)
% hObject    handle to TotExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TotExercido as text
%        str2double(get(hObject,'String')) returns contents of TotExercido as a double


% --- Executes during object creation, after setting all properties.
function TotExercido_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotExercido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio1_Callback(hObject, eventdata, handles)
% hObject    handle to Premio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio1 as text
%        str2double(get(hObject,'String')) returns contents of Premio1 as a double


% --- Executes during object creation, after setting all properties.
function Premio1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio1_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio1 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio1 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio2_Callback(hObject, eventdata, handles)
% hObject    handle to Premio2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio2 as text
%        str2double(get(hObject,'String')) returns contents of Premio2 as a double


% --- Executes during object creation, after setting all properties.
function Premio2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio2_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio2 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio2 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio3_Callback(hObject, eventdata, handles)
% hObject    handle to Premio3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio3 as text
%        str2double(get(hObject,'String')) returns contents of Premio3 as a double


% --- Executes during object creation, after setting all properties.
function Premio3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio3_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio3 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio3 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio4_Callback(hObject, eventdata, handles)
% hObject    handle to Premio4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio4 as text
%        str2double(get(hObject,'String')) returns contents of Premio4 as a double


% --- Executes during object creation, after setting all properties.
function Premio4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio4_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio4 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio4 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio5_Callback(hObject, eventdata, handles)
% hObject    handle to Premio5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio5 as text
%        str2double(get(hObject,'String')) returns contents of Premio5 as a double


% --- Executes during object creation, after setting all properties.
function Premio5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio5_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio5 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio5 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio6_Callback(hObject, eventdata, handles)
% hObject    handle to Premio6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio6 as text
%        str2double(get(hObject,'String')) returns contents of Premio6 as a double


% --- Executes during object creation, after setting all properties.
function Premio6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio6_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio6 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio6 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio7_Callback(hObject, eventdata, handles)
% hObject    handle to Premio7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio7 as text
%        str2double(get(hObject,'String')) returns contents of Premio7 as a double


% --- Executes during object creation, after setting all properties.
function Premio7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio7_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio7 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio7 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Premio8_Callback(hObject, eventdata, handles)
% hObject    handle to Premio8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Premio8 as text
%        str2double(get(hObject,'String')) returns contents of Premio8 as a double


% --- Executes during object creation, after setting all properties.
function Premio8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Premio8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Exercicio8_Callback(hObject, eventdata, handles)
% hObject    handle to Exercicio8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Exercicio8 as text
%        str2double(get(hObject,'String')) returns contents of Exercicio8 as a double


% --- Executes during object creation, after setting all properties.
function Exercicio8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Exercicio8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in Botao.
function Botao_Callback(hObject, eventdata, handles)
% hObject    handle to Botao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SelBotao = get(handles.Botao, 'Value');

if (SelBotao == 1)
    set(handles.Exercicio1, 'Enable', 'off'); 
    set(handles.Exercicio2, 'Enable', 'off'); 
    set(handles.Exercicio3, 'Enable', 'off'); 
    set(handles.Exercicio4, 'Enable', 'off'); 
    set(handles.Exercicio5, 'Enable', 'off'); 
    set(handles.Exercicio6, 'Enable', 'off'); 
    set(handles.Exercicio7, 'Enable', 'off'); 
    set(handles.Exercicio8, 'Enable', 'off'); 
    set(handles.Premio1, 'Enable', 'off'); 
    set(handles.Premio2, 'Enable', 'off'); 
    set(handles.Premio3, 'Enable', 'off'); 
    set(handles.Premio4, 'Enable', 'off'); 
    set(handles.Premio5, 'Enable', 'off'); 
    set(handles.Premio6, 'Enable', 'off'); 
    set(handles.Premio7, 'Enable', 'off'); 
    set(handles.Premio8, 'Enable', 'off'); 
    load('PrecosOpcoes.mat');
    n = max(size(Premio))
else
    set(handles.Exercicio1, 'Enable', 'on'); 
    set(handles.Exercicio2, 'Enable', 'on'); 
    set(handles.Exercicio3, 'Enable', 'on'); 
    set(handles.Exercicio4, 'Enable', 'on'); 
    set(handles.Exercicio5, 'Enable', 'on'); 
    set(handles.Exercicio6, 'Enable', 'on'); 
    set(handles.Exercicio7, 'Enable', 'on'); 
    set(handles.Exercicio8, 'Enable', 'on'); 
    set(handles.Premio1, 'Enable', 'on'); 
    set(handles.Premio2, 'Enable', 'on'); 
    set(handles.Premio3, 'Enable', 'on'); 
    set(handles.Premio4, 'Enable', 'on'); 
    set(handles.Premio5, 'Enable', 'on'); 
    set(handles.Premio6, 'Enable', 'on'); 
    set(handles.Premio7, 'Enable', 'on'); 
    set(handles.Premio8, 'Enable', 'on'); 
end    


% --- Executes on button press in Botao2.
function Botao2_Callback(hObject, eventdata, handles)
% hObject    handle to Botao2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Quantidade de Ativos.

Quantidade = get(handles.Quantidade, 'String');
Quantidade = str2double(Quantidade);
% Preço Ação.
PrecoAcao  = get(handles.PrecoAcao, 'String');
PrecoAcao  = str2double(PrecoAcao);

alfa = Agora;
totalCompraAcao      = alfa.CustoCompraAcao(Quantidade, PrecoAcao);

set(handles.TotalCompraAcao, 'Enable','on');
set(handles.TotalCompraAcao, 'String', num2str(totalCompraAcao(1)));
