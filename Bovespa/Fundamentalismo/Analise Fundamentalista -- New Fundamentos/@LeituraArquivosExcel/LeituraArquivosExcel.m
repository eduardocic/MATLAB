classdef LeituraArquivosExcel
    
    properties
        NomeArquivo_Excel
        CaminhoArquivo_Excel
        
        flagNumeroArquivos_Excel
        Empresa
        Tabela1
        Tabela2
        Textos
        Datas

        NomeEmpresa
        Ativos
        Passivos
        DemResultados

    end
       
    methods 
        % =================================================================
        %                           CONSTRUTOR
        %
        % =================================================================
        function [o] = LeituraArquivosExcel(o)
            
            % *************************************************************
            % 1. Diretório o diretório no qual esta classe está sendo
            %    chamada.
            % 
            %     (*) Aparecerá uma tela na qual pedirá para selecionar os
            %         arquivos do tipo '*.xls', ou seja, arquivos em
            %         formato Excel;
            %
            %     (*) Posso selecionar tanto UM quanto VÁRIOS arquivos; e
            %
            %     (*) Adiciona o caminho na layer do Matlab.
            % *************************************************************
            raiz    = pwd;
            clc;
            TituloJanela = 'Selecione os arquivos .xls Fundamentos.';
            [o.NomeArquivo_Excel, o.CaminhoArquivo_Excel, ~] = uigetfile(fullfile(raiz, '*.xls'),...
                                                                         'MultiSelect', 'on', ....
                                                                         TituloJanela);
            rmpath([o.CaminhoArquivo_Excel]);
            addpath([o.CaminhoArquivo_Excel]); 
            % *************************************************************
            % 2.  Abre os arquivos '*.xls' selecionados.
            %
            %    (*) Verifica se foi selecionado UM arquivo ou VÁRIOS. Esta
            %        parte é importante destacar que se apenas UM arquivo é
            %        selecionado, a parâmetro 'NomeArquivo_Excel' é do tipo
            %        'string', e caso seja mais do que um ele será do tipo
            %        'cell'. Dessa forma, eu chamo um condicional para
            %        saber se é ou não uma 'cell';
            %
            %    (*) Além disso, é apresentada uma Interface Homem-Máquina
            %        (IHM) onde se solicita que seja digitado o nome da
            %        empresa a qual está sendo gerado o balanço;
            %
            %    (*) Uma estrutura 'if-else' realiza o loop de leitura de
            %        todas as ABAS de cada um dos arquivos '*.xls'
            %        selecionado;
            %
            %    (*) Os dados das planilhas são IMPORTADOS para o ambiente
            %        Matlab;
            %
            %    (*) Chama a função 'fnConversor' para ler os dados da(s)
            %        tabela(s);
            %
            %    (*) Salva os respectivos dados.
            % *************************************************************
            BIT = iscell(o.NomeArquivo_Excel);
            if (BIT == 1)
                o.flagNumeroArquivos_Excel = size(o.NomeArquivo_Excel, 2);
            else
                o.flagNumeroArquivos_Excel = 1;
            end
                
            
            if (o.flagNumeroArquivos_Excel == 1)
                % Início de célula de carga.
                % --------------------------
                theta  = waitbar(0, sprintf('Gerando o balanço trimestral...', o.flagNumeroArquivos_Excel));
                
                o.Empresa{1} = importdata(o.NomeArquivo_Excel);  % Importa.
                
                o = o.fnExcel2Matlab(1);
                o = o.fnAtivos(1);
                o = o.fnPassivos(1);
                o = o.fnDemResultados(1);
                o = o.fnNomeEmpresa;
                o = o.fn_Data;
                
                h = waitbar(1);                                  % '%' de carga.                
            else
                
                % Início de célula de carga.
                % --------------------------
                theta  = waitbar(0, sprintf('Gerando os balanços trimestrais...', o.flagNumeroArquivos_Excel));
                for i = 1:(o.flagNumeroArquivos_Excel)            
                    o.Empresa{i} = importdata(o.NomeArquivo_Excel{i});  % Importa.
                    o = o.fnAtivos(i);
                    o = o.fnPassivos(i);
                    o = o.fnDemResultados(i);
                    o = o.fnNomeEmpresa;
                    o = o.fn_Data;
                    
                    h = waitbar(i/o.flagNumeroArquivos_Excel);          % '%' de carga.
                end
                
            end
            close(h);   % Fecha célula de carga existente.
        end
        
        [o] = fnExcel2Matlab(o,varargin);
        [o] = fnAtivos(o, varargin);
        [o] = fnPassivos(o, varargin);
        [o] = fnDemResultados(o, varargin);
        [o] = fnNomeEmpresa(o);
        
        [o] = fn_Data(o,varargin);
    end
    
end

