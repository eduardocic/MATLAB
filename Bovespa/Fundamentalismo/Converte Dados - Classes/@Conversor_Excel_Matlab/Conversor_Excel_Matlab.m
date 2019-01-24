classdef Conversor_Excel_Matlab   
    
    properties
        % Propriedades de onde se encontra a classe chamada.
        raiz
        
        % Propriedades de onde se encontra (em qual pasta) o arquivo '.xls'
        NomeArquivo_Excel
        CaminhoArquivo
        
        % Propriedades da empresa.
        NomeDaEmpresa
        Empresa
        flagArquivos
        
        file
  
        T1
        T2
        T3
        T4
%         T5
    end
    
    methods
        % =================================================================
        %
        %                           CONSTRUTOR
        %
        % =================================================================
        function [o] = Conversor_Excel_Matlab(o)
            
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
            o.raiz    = pwd;
            clc;
            TituloJanela = 'Selecione os arquivos .xls CVM.';
            [o.NomeArquivo_Excel, o.CaminhoArquivo, ~] = uigetfile(fullfile(o.raiz, '*.xls'),...
                                                                   'MultiSelect', 'on', ....
                                                                   TituloJanela)
            rmpath([o.CaminhoArquivo]);
            addpath([o.CaminhoArquivo]);                                                               
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
                o.flagArquivos = size(o.NomeArquivo_Excel, 2);
            else
                o.flagArquivos = 1;
            end
            
            nome = inputdlg({'Digite o nome da Empresa'}, 'Customer', [1 50]);
            o.NomeDaEmpresa = nome{1};
            
            if (o.flagArquivos == 1)
                
                % In�cio de c�lula de carga.
                theta  = waitbar(0, sprintf('Gerando o balan�o trimestral...', o.flagArquivos));
                
                o.Empresa{1} = importdata(o.NomeArquivo_Excel);  % Importa.
                o = o.fnConversor(1);                            % Converte.
                o.fn_SalvaPlanilhaExcel_FormatoMatlab(1);        % Salva.
                h = waitbar(1);                                  % '%' de carga.
                
            else
                
                % In�cio de c�lula de carga.
                theta  = waitbar(0, sprintf('Gerando os balan�os trimestrais...', o.flagArquivos));
                for i = 1:(o.flagArquivos)            
                  
                    o.Empresa{i} = importdata(o.NomeArquivo_Excel{i});  % Importa.
                    o = o.fnConversor(i);                               % Converte.
                    o.fn_SalvaPlanilhaExcel_FormatoMatlab(i);           % Salva.
                    h = waitbar(i/o.flagArquivos);                      % '%' de carga.
                end
                
            end
            close(h);   % Fecha c�lula de carga existente.
        end

        
        % *****************************************************************
        %         
        %                         DEMAIS M�TODOS
        %
        % *****************************************************************
        [o] = fn_Consolidado_Tabela2(o);
        [o] = fn_Consolidado_Tabela3(o);
        [o] = fn_Consolidado_Tabela4(o);
        [o] = fn_Consolidado_Tabela5(o);
        
        [o] = fn_Individual_Tabela2(o);
        [o] = fn_Individual_Tabela3(o);
        [o] = fn_Individual_Tabela4(o);
        [o] = fn_Individual_Tabela5(o);
        
        [o] = fnConversor(o, varargin);
        
        []  = fn_SalvaPlanilhaExcel_FormatoMatlab(o, varargin);
    end
end

