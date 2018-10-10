function varargout = BovespaFundamentus(varargin)
% BOVESPAFUNDAMENTUS MATLAB code for BovespaFundamentus.fig
%      BOVESPAFUNDAMENTUS, by itself, creates a new BOVESPAFUNDAMENTUS or raises the existing
%      singleton*.
%
%      H = BOVESPAFUNDAMENTUS returns the handle to a new BOVESPAFUNDAMENTUS or the handle to
%      the existing singleton*.
%
%      BOVESPAFUNDAMENTUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOVESPAFUNDAMENTUS.M with the given input arguments.
%
%      BOVESPAFUNDAMENTUS('Property','Value',...) creates a new BOVESPAFUNDAMENTUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BovespaFundamentus_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BovespaFundamentus_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BovespaFundamentus

% Last Modified by GUIDE v2.5 27-Apr-2016 19:06:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BovespaFundamentus_OpeningFcn, ...
                   'gui_OutputFcn',  @BovespaFundamentus_OutputFcn, ...
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





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Executado antes de aparecer a janela
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function BovespaFundamentus_OpeningFcn(hObject, eventdata, handles, varargin)
% (*) Este programa � grande, ent�o tentarei deixar o mais explicado
%     poss�vel. 
% close all; clc;
% (*) Primeiramente fazer a inclus�o das pastas e subpastas.
% raiz    = pwd;
% subRaiz = {'Fun��es'; 'Excel'};
% 
% nMax = max(size(subRaiz));
% for i = 1:nMax
%     rmpath([raiz '\' subRaiz{i,:}]);
%     addpath([raiz '\' subRaiz{i,:}]); 
% end

% -------------------------------------------------------------------------
% (*) A primeira parte do programa selecionar� A PASTA a qual tem os
%     arquivos '*.mat'.
handles.RAIZ = uigetdir();

% -------------------------------------------------------------------------
% (*) A segunda parte selecionar� os arquivos '*.mat' dentro da pasta
%     selecionada. Essa sele��o pode ser m�ltipla, bastando apenas segurar
%     o bot�o CTRL enquanto seleciona os arquivos.
typeFile = '*.mat';
[handles.FILENAME, handles.PATHNAME,~] = ...
uigetfile(fullfile(handles.RAIZ, typeFile), 'MultiSelect', 'on');

% -------------------------------------------------------------------------
% (*) A terceira parte pegar� os nomes dos arquivos carregados e colocar�
%     eles na Lista de Vari�veis da 'listbox'.
N = max(size(handles.FILENAME));
for i = 1:N
    [handles.NOME_EMPRESAS(i), Apos] = strtok(handles.FILENAME(i), '.');
end

% -------------------------------------------------------------------------
% (*) A terceira parte concatenar� o nome das Empresas numa �nica matriz de
%     string e esta ser� passada para a 'listbox'.
handles.TODAS = [];
for i=1:N
    handles.TODAS = [handles.TODAS; ...
                     handles.NOME_EMPRESAS(i)];  
end

% -------------------------------------------------------------------------
% (*) Iremos agora enviar essa String para que ela apare�a na 'listbox'.
set(handles.total_Empresas, 'String',handles.TODAS);

% -------------------------------------------------------------------------
% (*) Inicializador do contador de clique para inclus�o ou exclus�o de
%     empresas filtradas. Ser� feito tamb�m a inicializa��o do vetor de
%     string que tamb�m aparecer� na listbox 'filtro_Empresas'
handles.CONTADOR = 0;  

% -------------------------------------------------------------------------
% (*) Vetor de cores.
handles.CORES = {'b','g','r','c','m','y','k'};


% -------------------------------------------------------------------------
% Choose default command line output for BovespaFundamentus
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% UIWAIT makes BovespaFundamentus wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BovespaFundamentus_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in total_Empresas.
function total_Empresas_Callback(hObject, eventdata, handles)

% (*) Esta parte aqui faz o maxempresas de interesses de todas as empresas
%     carregadas. Dessa forma, de todas elas, apenas 'n' delas ser�o
%     passadas para a listbox 'filtro_Empresas'.
% 
% (*)



% --- Executes during object creation, after setting all properties.
function total_Empresas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_Empresas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in filtro_Empresas.
function filtro_Empresas_Callback(hObject, eventdata, handles)
% hObject    handle to filtro_Empresas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filtro_Empresas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filtro_Empresas


% --- Executes during object creation, after setting all properties.
function filtro_Empresas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filtro_Empresas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BotaoIncluir.
function BotaoIncluir_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------
% (*) Pega todos os dados salvos pelo 'guidata', ou seja, leio eles 
%     OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
handles = guidata(hObject);

% -------------------------------------------------------------------------
% (*) Verifica a quantidade de empresas m�ximas e coloca elas na listbox do
%     'filtro_Empresa'.
QntEmpresas = max(size(handles.NOME_EMPRESAS));
cont = handles.CONTADOR;

if (cont < QntEmpresas)
    
    % (*) Se o contador for igual a zero � porque n�o foram adicionadas
    %     empresas ainda. Dessa forma, ser� adicionada a primeira empresa.
    Empresas         = get(handles.total_Empresas, 'String');
    QualDelas        = get(handles.total_Empresas, 'Value');
    EmpresaAdicionar = Empresas{QualDelas};
    if (cont == 0)
        contM1 = cont + 1;
        handles.CONTADOR = contM1;
        handles.FILTRADAS{contM1} = EmpresaAdicionar;
    else        
        
        % (*) Verifico se a empresa que eu quero adicionar j� est� listada
        %     como empresa filtrada.
        n = max(size(handles.FILTRADAS));
        contE = 0;
        for i = 1:n
            VerificarNome = handles.FILTRADAS{i};
            JaExisteEmpresaFiltrada = strcmp(VerificarNome, EmpresaAdicionar);
            % Para sacramentar de que existe ou n�o a referida empresa. Se
            % existir eu fa�o uma altera��o no 'contE' de forma que ele
            % registre 1 (ou seja, existe na lista de empresas filtradas
            % aquela que eu desejo adicionar).
            if (JaExisteEmpresaFiltrada == 1)
                contE = 1;
            end
        end
        % (*) Se j� existir na listbox de empresas filtradas a empresa que
        %     voc� quer adicionar, voc� n�o adiciona. Ou seja, se o
        %     'contE' for igual a 1 ent�o N�O adicionaremos a referida 
        %     empresa.
        if (contE == 0)
             contM1 = cont + 1;
             handles.CONTADOR = contM1;
             handles.FILTRADAS{contM1} = EmpresaAdicionar;
        end
    end
end

% -------------------------------------------------------------------------
% (*) Envia para a listbox 'filtro_Empresas' as empresas j� filtradas.
set(handles.filtro_Empresas, 'String', handles.FILTRADAS);

% -------------------------------------------------------------------------
% (*) Salva todas as altera��es de handles feitas nesta fun��o na
%     'guidata' - OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
guidata(hObject, handles);



% --- Executes on button press in BotaoExcluir.
function BotaoExcluir_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------
% (*) Pega todos os dados salvos pelo 'guidata', ou seja, leio eles 
%     OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
handles = guidata(hObject);

% -------------------------------------------------------------------------
% (*) Cada vez que houver o clique no 'Excluir', eu tenho de excluir a
%     string selecionada.
% (*) A primeira coisa a fazer � determinar se a quantidade de strings que
%     est�o na listbox 'filtro_Empresas' � maior do que zero. Se for vazio
%     o valor ser� 1. No caso, caso haja alguma empresa, o n_filtro ser�
%     igual a 0.
n_filtro = get(handles.filtro_Empresas, 'String');
n_filtro = isempty(n_filtro);

% -------------------------------------------------------------------------
% (*) Caso haja algumas empresas na listbox 'filtro_Empresas', verificar
%     a que estar� sendo exclu�da. Ou seja, se for 0 � porque existem
%     empresas na lista. Se n�o existir empresas na lista, n�o se faz nada.
if (n_filtro == 0)
    % (*) Pega a posi��o da empresa que desejamos excluir.
    pos  = get(handles.filtro_Empresas, 'Value');
    pos  = fix(pos);
    
    % (*) Vamos agora excluir o nome da empresa selecionada e atualizar a
    %     listbox 'filtro_Empresas'. A primeira coisa � verificar a
    %     quantidade de empresas que existem no filtro.
    totalFiltro     = max(size(handles.FILTRADAS));
    
    % (*) Se a quantidade de empresas que existir na listbox
    %     'Empresas_Filtradas' for igual a um, depois da exclus�o o que se
    %     ter� � nenhuma empresa. Ent�o, elimina-se essa empresa e atualiza
    %     o contador com a subtra��o de uma empresa.s
    if (totalFiltro == 1)
        string = {};
        cont = handles.CONTADOR - 1;
        handles.CONTADOR = cont;
    else
    % (*) Se houver mais empresas, verificar-se-� a empresa que queremos
    %     excluir (pela posi��o da mesma na listbox). O que faremos �
    %     mandar percorrer de 1 at� totalFiltro e quando chegar na posi��o
    %     que desejamos excluir n�o faremos nada com a 'nova string' de
    %     valores excluidos. Para isso, inicializaremos um contador com o
    %     'alfa' de forma a quando chegar na posi��o de exclus�o, n�o
    %     atualizaremos o valor de 'alfa'.
         alfa = 0;
%         for i = 1:(totalFiltro-1)
%             alfa = alfa + 1;
%             if (i == pos)
%                 alfa = alfa + 1;
%                 string{i} = handles.FILTRADAS{alfa};
%             else
%                 string{i} = handles.FILTRADAS{alfa};
%             end
%         end
        for i = 1:totalFiltro
            if (i == pos)
            else
                i
                alfa = alfa + 1
                string{alfa} = handles.FILTRADAS{i};
            end
        end

        cont = handles.CONTADOR - 1;
        handles.CONTADOR = cont;
    end
    
    Value = get(handles.filtro_Empresas, 'Value')
    set(handles.filtro_Empresas, 'Value', Value - 1)
    handles.FILTRADAS = string;
end


% -------------------------------------------------------------------------
% (*) Envia para a listbox 'filtro_Empresas' as empresas j� filtradas.
set(handles.filtro_Empresas, 'String', handles.FILTRADAS);

% -------------------------------------------------------------------------
% (*) Salva todas as altera��es de handles feitas nesta fun��o na
%     'guidata' - OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
guidata(hObject, handles);


% --- Executes on selection change in Indicadores.
function Indicadores_Callback(hObject, eventdata, handles)
% hObject    handle to Indicadores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Indicadores contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Indicadores


% --- Executes during object creation, after setting all properties.
function Indicadores_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Indicadores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BotaoIndicadores.
function BotaoIndicadores_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------
% (*) Pega todos os dados salvos pelo 'guidata', ou seja, leio eles 
%     OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
handles = guidata(hObject);

% -------------------------------------------------------------------------
raiz    = pwd;
subRaiz = {'Funcoes'; 'Excel'; 'Empresas'};

nMax = max(size(subRaiz));
for i = 1:nMax
    rmpath([raiz '\' subRaiz{i,:}]);
    addpath([raiz '\' subRaiz{i,:}]); 
end
% -------------------------------------------------------------------------
% (*) Pegar o nome da primeira empresa e adiciona o '.mat'
empresa     = handles.FILTRADAS{1};
NomeArquivo = strcat(empresa, '.mat');
FILE        = load(NomeArquivo);




% -------------------------------------------------------------------------
% (*) Agora o que iremos fazer � tentar amostrar os campos da estrutura no 
NomeEstrutura     = fieldnames(FILE);
CamposNaEstrutura = fieldnames(FILE.(NomeEstrutura{1}));

% -------------------------------------------------------------------------
% Datas             = FILE.(NomeEstrutura{1}).(CamposNaEstrutura{1})

% (*) Gambi com a data para plot.
% for i=1:max(size(Mes))
%     Trimestres(i) = (Mes(i)/12) + Ano(i) - 1/4;       % com offset para o gr�fico.
% end
% -------------------------------------------------------------------------


% (*) Atribui esses campos na estrutura a guidata INDICADORES.
handles.INDICADORES = CamposNaEstrutura;

% (*) Amostra na listbox 'Indicadores' os INDICADORES em quest�o.
set(handles.Indicadores, 'String', handles.INDICADORES);

% (*) Teste b�sico do plot do gr�fico. Ser� tomado o Valor Patrimonial
% junto com o tempo para verificar se realmente est� funcionando.
% plot(Trimestres, AtivoTotal);


% -------------------------------------------------------------------------
% (*) Salva todas as altera��es de handles feitas nesta fun��o na
%     'guidata' - OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
guidata(hObject, handles);


% --- Executes on button press in PlotaIndicador.
function PlotaIndicador_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------
% (*) Pega todos os dados salvos pelo 'guidata', ou seja, leio eles 
%     OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
handles = guidata(hObject);
cla;
% -------------------------------------------------------------------------
raiz    = pwd;
subRaiz = {'Fun��es'; 'Excel'; 'Empresas'};

nMax = max(size(subRaiz));
for i = 1:nMax
    rmpath([raiz '\' subRaiz{i,:}]);
    addpath([raiz '\' subRaiz{i,:}]); 
end
% -------------------------------------------------------------------------





% -------------------------------------------------------------------------
% (*) Pegar o nome das empresas na FILTRADAS e carrega os arquivos
%     '*.mat' e salva em arquivos.
stringEmpresas = handles.FILTRADAS;
N = max(size(stringEmpresas));

for i=1:N
   Empresa{i}   = handles.FILTRADAS{i};
   Concatena{i} = strcat(Empresa{i}, '.mat');
   FILE{i}      = load(Concatena{i});
end

COR = handles.CORES;

% (*) Pegarei a posi��o do indicador que est� sendo mostrado.
Qual = get(handles.Indicadores, 'String');
posI = get(handles.Indicadores, 'Value');
Qual = Qual{posI};
stringIndicadores = handles.INDICADORES;
Ni   = max(size(stringIndicadores));

for i = 1:Ni
    switch Qual
        case 'ROE_T'
            for i = 1:N
                NameStruct    = fieldnames(FILE{i});
                alfa = FILE{i}.(NameStruct{1}).ROE_T;
                hold on;
                plota(alfa, COR{i});
                legend(stringEmpresas, 'Location', 'EastOutside');
            end
        case 'ROE_A'
            for i = 1:N
                NameStruct    = fieldnames(FILE{i});
                alfa = FILE{i}.(NameStruct{1}).ROE_A;
                hold on;
                plota(alfa, COR{i});
                legend(stringEmpresas, 'Location', 'EastOutside');
            end
        case 'ROA_T'
            for i = 1:N
                NameStruct    = fieldnames(FILE{i});
                alfa = FILE{i}.(NameStruct{1}).ROA_T;
                hold on;
                plota(alfa, COR{i});
                legend(stringEmpresas, 'Location', 'EastOutside');
            end
        case 'ROA_A'
            for i = 1:N
                NameStruct    = fieldnames(FILE{i});
                alfa = FILE{i}.(NameStruct{1}).ROA_A;
                hold on;
                plota(alfa, COR{i});
                legend(stringEmpresas, 'Location', 'EastOutside');
            end
        case 'Indice_de_Solvencia_de_Caixa_T'
            for i = 1:N
                NameStruct    = fieldnames(FILE{i})
                alfa = FILE{i}.(NameStruct{1}).Indice_de_Solvencia_de_Caixa_T;
                hold on;
                plota(alfa, COR{i});
                legend(stringEmpresas, 'Location', 'EastOutside');
            end
    end
end
% -------------------------------------------------------------------------
% Eu acho que essa implementa��o tem de vir l� quando eu pedir para mostrar
% os indicadores.
for i=1:N
    arquivos = handles.FILENAME{1}
    filtrada = handles.FILTRADAS{i}
    NomeArquivo = strcat(filtrada, '.mat');
    resultado = strcmp(handles.FILENAME{1},handles.FILTRADAS{i})
end


% -------------------------------------------------------------------------
% (*) Salva todas as altera��es de handles feitas nesta fun��o na
%     'guidata' - OBRIGAT�RIO SE EXISTIR ATUALIZA��O DE VARI�VEIS GLOBAIS.
guidata(hObject, handles);
