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
            % 1. Diret�rio o diret�rio no qual esta classe est� sendo
            %    chamada.
            % 
            %     (*) Aparecer� uma tela na qual pedir� para selecionar os
            %         arquivos do tipo '*.xls', ou seja, arquivos em
            %         formato Excel;
            %
            %     (*) Posso selecionar tanto UM quanto V�RIOS arquivos; e
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
            %    (*) Verifica se foi selecionado UM arquivo ou V�RIOS. Esta
            %        parte � importante destacar que se apenas UM arquivo �
            %        selecionado, a par�metro 'NomeArquivo_Excel' � do tipo
            %        'string', e caso seja mais do que um ele ser� do tipo
            %        'cell'. Dessa forma, eu chamo um condicional para
            %        saber se � ou n�o uma 'cell';
            %
            %    (*) Al�m disso, � apresentada uma Interface Homem-M�quina
            %        (IHM) onde se solicita que seja digitado o nome da
            %        empresa a qual est� sendo gerado o balan�o;
            %
            %    (*) Uma estrutura 'if-else' realiza o loop de leitura de
            %        todas as ABAS de cada um dos arquivos '*.xls'
            %        selecionado;
            %
            %    (*) Os dados das planilhas s�o IMPORTADOS para o ambiente
            %        Matlab;
            %
            %    (*) Chama a fun��o 'fnConversor' para ler os dados da(s)
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
                % In�cio de c�lula de carga.
                % --------------------------
                theta  = waitbar(0, sprintf('Gerando o balan�o trimestral...', o.flagNumeroArquivos_Excel));
                
                o.Empresa{1} = importdata(o.NomeArquivo_Excel);  % Importa.
                
                o = o.fnExcel2Matlab(1);
                o = o.fnAtivos(1);
                o = o.fnPassivos(1);
                o = o.fnDemResultados(1);
                o = o.fnNomeEmpresa;
                o = o.fn_Data;
                
                h = waitbar(1);                                  % '%' de carga.                
            else
                
                % In�cio de c�lula de carga.
                % --------------------------
                theta  = waitbar(0, sprintf('Gerando os balan�os trimestrais...', o.flagNumeroArquivos_Excel));
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
            close(h);   % Fecha c�lula de carga existente.
        end
        
        [o] = fnExcel2Matlab(o,varargin);
        [o] = fnAtivos(o, varargin);
        [o] = fnPassivos(o, varargin);
        [o] = fnDemResultados(o, varargin);
        [o] = fnNomeEmpresa(o);
        
        [o] = fn_Data(o,varargin);
    end
    
end

