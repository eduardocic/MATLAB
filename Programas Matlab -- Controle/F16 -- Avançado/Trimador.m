function varargout = Trimador(varargin)
% TRIMADOR MATLAB code for Trimador.fig
%      TRIMADOR, by itself, creates a new TRIMADOR or raises the existing
%      singleton*.
%
%      H = TRIMADOR returns the handle to a new TRIMADOR or the handle to
%      the existing singleton*.
%
%      TRIMADOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRIMADOR.M with the given input arguments.
%
%      TRIMADOR('Property','Value',...) creates a new TRIMADOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Trimador_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Trimador_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Trimador

% Last Modified by GUIDE v2.5 04-Apr-2018 16:23:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Trimador_OpeningFcn, ...
                   'gui_OutputFcn',  @Trimador_OutputFcn, ...
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


% --- Executes just before Trimador is made visible.
function Trimador_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Trimador (see VARARGIN)

% Choose default command line output for Trimador
handles.output = hObject;

% =========================================================================
% Como começa com a variável 'Reto Nivelado', eu não irei pegar as
% variáveis que efetivamente não fazem parte desse universo de decisão.
set(handles.Gamma, 'Enable', 'off');
set(handles.PsiPonto, 'Enable', 'off');
% =========================================================================

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Trimador wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Trimador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in Condicao_Voo.
function Condicao_Voo_SelectionChangeFcn(hObject, eventdata, handles)
A = get(hObject, 'String');

switch(A)
    case 'Reto Nivelado'
        set(handles.Gamma, 'Enable', 'off');
        set(handles.PsiPonto, 'Enable', 'off');
    case 'Curva Coordenada'
        set(handles.Gamma, 'Enable', 'on');
        set(handles.PsiPonto, 'Enable', 'on');
end



function VelocidadeTotal_Callback(hObject, eventdata, handles)
% hObject    handle to VelocidadeTotal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VelocidadeTotal as text
%        str2double(get(hObject,'String')) returns contents of VelocidadeTotal as a double


% --- Executes during object creation, after setting all properties.
function VelocidadeTotal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VelocidadeTotal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Altitude_Callback(hObject, eventdata, handles)
% hObject    handle to Altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Altitude as text
%        str2double(get(hObject,'String')) returns contents of Altitude as a double


% --- Executes during object creation, after setting all properties.
function Altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CentroDeGravidade_Callback(hObject, eventdata, handles)
% hObject    handle to CentroDeGravidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CentroDeGravidade as text
%        str2double(get(hObject,'String')) returns contents of CentroDeGravidade as a double


% --- Executes during object creation, after setting all properties.
function CentroDeGravidade_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CentroDeGravidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function PsiPonto_Callback(hObject, eventdata, handles)
% hObject    handle to PsiPonto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PsiPonto as text
%        str2double(get(hObject,'String')) returns contents of PsiPonto as a double


% --- Executes during object creation, after setting all properties.
function PsiPonto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PsiPonto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Gamma_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gamma as text
%        str2double(get(hObject,'String')) returns contents of Gamma as a double


% --- Executes during object creation, after setting all properties.
function Gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Condicao_Voo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Condicao_Voo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in BotaoTrimmar.
function BotaoTrimmar_Callback(hObject, eventdata, handles)


% Carrega as funções essenciais para a chamada das condições do F16.
% ------------------------------------------------------------------
MainPath = pwd;
Folders = {'Turbina'; 'Atmosfera'; 'Modelo'; 'CoeficientesAerodinamicos'};
for i = 1:numel(Folders)
    Pasta = [MainPath '/' Folders{i}];
    rmpath(Pasta);
    addpath(Pasta);
end


% Pega a string para a trimagem.
% ------------------------------
A = get(handles.Condicao_Voo, 'String')

x = zeros(13,1);
switch(A)
    case 'Reto Nivelado'
        disp('Reto Nivelado')
        flag = 1;
        
        % Pega os valores como String.
        % ----------------------------
        Vt  = get(handles.VelocidadeTotal, 'String');
        H   = get(handles.Altitude, 'String');
        Xcg = get(handles.CentroDeGraviddade, 'String');
        
        % Converte em numeros.
        % --------------------
        x(1)  = str2num(Vt)        % Velocidade total.
        x(12) = str2num(H)         % Altitude.
        u(5)  = str2num(Xcg)       % Throttle.
        gamma = 0
        psi_d = 0
        
        % Chute inicial.
        % --------------
        x(2) = 0.1;            % alpha.
        x(3) = 10^-6;          % beta.
        u(1) = 1;              % throtle.
        u(2) = -1;             % elevator.
        u(3) = 10^-6;          % aileron.
        u(4) = 10^-6;          % rudder.
        
        s0   = [x(2) x(3) u(1) u(2) u(3) u(4)];  
      
        
    case 'Curva Coordenada'
        disp('Curva Coordenada.')
        flag = 2;
        
        % Pega os valores como String.
        % ----------------------------
        Vt    = get(handles.VelocidadeTotal, 'String');
        H     = get(handles.Altitude, 'String');
        Xcg   = get(handles.CentroDeGraviddade, 'String');
        gamma = get(handles.Gamma, 'String');
        psi_d = get(handles.PsiPonto, 'String');
        
        % Converte em numeros.
        % --------------------
        x(1)  = str2num(Vt)        % Velocidade total.
        x(12) = str2num(H)         % Altitude.
        u(5)  = str2num(Xcg)       % Throttle.
        gamma = str2num(gamma)
        psi_d = str2num(psi_d)
        
        % Chute inicial
        % -------------
        x(2) = 0;         % alpha.
        x(3) = 0;         % beta.
        u(1) = 0.5;       % throtle.
        u(2) = -1;        % elevator.
        u(3) = 0.01;      % aileron.
        u(4) = 0.01;      % rudder.
        
        s0   = [x(2) x(3) u(1) u(2) u(3) u(4)];  
        
end
% x

% % Variáveis restritas à condição escolhida.
% % -----------------------------------------
% phi_d    = 0;
% theta_d  = 0;
% 
% % Passado para a função custo do meu sistema.
% % -------------------------------------------
% varargin = [x(1), x(12), gamma, u(5), phi_d, theta_d, psi_d, flag];
% 
% % Determinação do custo inicial.
% % ------------------------------
% Cost      = @(s)fnCusto(s, varargin); 
% Estados   = 'F16_Saida';
% 
% % Resolve o sistema.
% % ------------------
% % options   = optimset('TolFun', 10^-8, 'MaxFunEvals' , 5000);
% options   = optimset('TolFun', 1.e-8, 'TolX', 1.e-8, 'MaxFunEvals' , 50000);
% [s, fval] = fminsearch(Cost, s0, options)
% 
% 
% % Substitui as variáveis.
% % -----------------------
% x(2) = s(1);           % alpha
% x(3) = s(2);           % beta
% u(1) = s(3);           % throtle
% u(2) = s(4);           % elevator
% u(3) = s(5);           % aileron
% u(4) = s(6);           % rudder
% 
% 
% % Calcula o restante das variáveis.
% % ---------------------------------
% switch flag
%     case 1
%         % Sem rolamento. Assim:
%         x(4) = 0;
%         
%         % Cálculo do valor de theta.
%         a = cos(x(2))*cos(x(3));
%         b = sin(x(4))*sin(x(3)) + cos(x(4))*sin(x(2))*cos(x(3));
%         num = a*b + sin(gamma)*sqrt(a^2 - sin(gamma)^2 + b^2);
%         den = a^2 - sin(gamma)^2;
%         x(5) = atan(num/den);
%         
%         % A variável psi é livre.
%         x(6) = 0;
%         
%         % P, Q e R são iguais a zero.
%         x(7) = 0;
%         x(8) = 0;
%         x(9) = 0;      
%         
%         
%     case 2
%         % Haverá um rolamento. Dessa forma, definiremos:
%         E = psi_d*x(1)/32.17;
%         a = 1 - E*tan(x(2))*sin(x(3));
%         b = sin(gamma)/cos(x(3));
%         c = 1 + (E*cos(x(3))^2);
%         
%         num = E*cos(x(3))*((a-b^2) + b*tan(x(2))*sqrt(c*(1-b^2) + (E*sin(x(3))^2)));
%         den = cos(x(2))*(a^2 - b^2*(1 + c*tan(x(2))^2));
%         
%         x(4) = atan(num/den);
%         
%         % Cálculo do valor de theta.
%         a2 = cos(x(2))*cos(x(3));
%         b2 = sin(x(4))*sin(x(3)) + cos(x(4))*sin(x(2))*cos(x(3));
%         
%         num = a2*b2 + sin(gamma)*sqrt(a2^2 - sin(gamma)^2 + b2^2);
%         den = a2^2 - sin(gamma)^2;
%         
%         x(5) = atan(num/den);
%         
%         % A variável psi é livre.
%         x(6) = 0;
%         
%         % P, Q e R são iguais a zero.
%         x(7) = phi_d - sin(x(5))*psi_d;
%         x(8) = cos(x(4))*theta_d + sin(x(4))*cos(x(5))*psi_d;
%         x(9) = -sin(x(4))*theta_d + cos(x(4))*cos(x(5))*psi_d;    
% end
% 
% % Última Variável.
% x(13) = TGear(u(1));
