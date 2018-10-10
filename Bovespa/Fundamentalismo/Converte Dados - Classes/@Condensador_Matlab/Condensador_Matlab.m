classdef Condensador_Matlab
    
    properties
        % Propriedades de onde se encontra a classe chamada.
        raiz
        Arquivo_Matlab
        CaminhoArquivo
         
        % Propriedades da empresa.
        TRI
        DATA_OrdemDecrescente

        % Trimestres.
        T1
        T2
        T3
        T4
%         T5
        
        % Descri��o da conta.
        Campos_Tabela1
        Campos_Tabela2
        Campos_Tabela3
        Campos_Tabela4
%         Campos_Tabela5
    end
    
    methods
        % =================================================================
        %
        %                           CONSTRUTOR
        %
        % =================================================================
        function [o] = Condensador_Matlab(o)
            % *************************************************************
            % 1. Diret�rio o diret�rio no qual esta classe est� sendo
            %    chamada.
            % 
            %     (*) Aparecer� uma tela na qual pedir� para selecionar os
            %         balan�os outrora salvos em arquivos '*.mat';
            %
            %     (*) Posso selecionar tanto UM quanto v�rios arquivos; e
            %
            %     (*) Adiciona o caminho na layer do Matlab.
            % *************************************************************
            o.raiz    = pwd;
            Titulo = 'Selecione os arquivos *.mat references aos balan�os TRIMESTRAIS da empresa';
            [o.Arquivo_Matlab, o.CaminhoArquivo, ~] = uigetfile(fullfile(o.raiz, '*.mat'), ...
                                                                    'MultiSelect', 'on', Titulo);
            rmpath([o.CaminhoArquivo]);
            addpath([o.CaminhoArquivo]);
            
            % *************************************************************
            % 2. Abre os arquivos '*.mat' selecionados.
            %
            %   (*) Para facilitar o entendimento do programa, todas as 
            %       vari�veis ser�o salvas em um vetor chamado 'TRI', em  
            %       refer�ncia � trimestre;
            %
            %   (*) Fa�o um 'if-else' para verificar se estar-se lendo UM
            %       ou mais arquivos.
            % *************************************************************
            o.TRI = cellstr(o.Arquivo_Matlab);
            n     = max(size(o.TRI));
            if (n == 1)
                o.TRI{1} = load(o.TRI{1});
            else
                for i=1:n
                    o.TRI{i} = load(o.TRI{i});
                end
            end
            
            % *************************************************************
            % 3. Organiza��o das datas
            %
            %    (*) Ap�s realizar a leitura dos trimestres selecionados,
            %        a ideia � ordenar as datas de forma que a mais recente
            %        procure ficar mais a esquerda poss�vel do balan�o que
            %        se deseja gerar e aquela de balan�o mais antigo fico o
            %        mais a direita poss�vel; e
            %
            %    (*) Dessa forma, deseja-se orden�-las na forma
            %        decrescente (conforme explicado acima).
            % *************************************************************
            [o] = fn_YYYYMMDD(o);
            
           
            % *************************************************************
            % 4.  Altera��o dos nomes das 'SpreadSheet' dos arquivos Excel
            %     lidos.
            %
            %    (*) Cada arquivo em Excel lido apresenta os campos
            %        relativos �s 
            % *************************************************************
            o.Campos_Tabela1 = fields(o.TRI{1}.o.T1);
            o.Campos_Tabela2 = fields(o.TRI{1}.o.T2);
            o.Campos_Tabela3 = fields(o.TRI{1}.o.T3);
            o.Campos_Tabela4 = fields(o.TRI{1}.o.T4);
%             o.Campos_Tabela5 = fields(o.TRI{1}.o.T5);
            
           
            theta  = waitbar(0, sprintf('Condensando os balan�os trimestrais da empresa...', n));
            
            %  Aloca os textos e n�meros das tabelas excel nos campos das
            %  referidas tabelas.
            % -------------------------------------------------------------
            % Tabela 1
            o.T1.(o.Campos_Tabela1{1}) = o.TRI{1}.o.T1.texto;

            % Tabela 2
            o.T2.(o.Campos_Tabela2{1}) = o.TRI{1}.o.T2.texto;
            o.T2.(o.Campos_Tabela2{2}) = o.TRI{1}.o.T2.numero;


            % Tabela 3
            o.T3.(o.Campos_Tabela3{1}) = o.TRI{1}.o.T3.texto;
            o.T3.(o.Campos_Tabela3{2}) = o.TRI{1}.o.T3.numero;

            % Tabela 4
            o.T4.(o.Campos_Tabela4{1}) = o.TRI{1}.o.T4.texto;
            o.T4.(o.Campos_Tabela4{2}) = o.TRI{1}.o.T4.numero;

%             % Tabela 5
%             o.T5.(o.Campos_Tabela5{1}) = o.TRI{1}.o.T5.texto;
%             o.T5.(o.Campos_Tabela5{2}) = o.TRI{1}.o.T5.numero;

            
            for i=1:n
                str1 = o.DATA_OrdemDecrescente{i};
                for j=1:n
                   if(strcmp(str1, o.TRI{j}.o.T1.data))

                       o = fn_Tabela1(o, i, j);                      
                       o = fn_Tabela2(o, i, j);
                       o = fn_Tabela3(o, i, j);                      
                       o = fn_Tabela4(o, i, j);
%                        o = fn_Tabela5(o, i, j);
                       waitbar(i/n);
                   end
                end
            end
            delete(theta);
            
            o = fn_FlipaTabela1(o);
            o = fn_FlipaTabela2(o);
            o = fn_FlipaTabela3(o);
            o = fn_FlipaTabela4(o);
%             o = fn_FlipaTabela5(o); 
            
            % Ajusta os dados do �ltimo trimestre do ano.
            % Parei aqui.
            o = fn_AjusteAcumulado_Tabela4(o);
%             o = fn_AjusteAcumulado_Tabela5(o);
            fn_SalvaDadosCondensados_FormatoMatlab(o);
        end

        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         
        %                         Demais M�todos
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [o] = fn_YYYYMMDD(o);
        
        [o] = fn_Tabela1(o, varargin);
        [o] = fn_Tabela2(o, varargin);
        [o] = fn_Tabela3(o, varargin);
        [o] = fn_Tabela4(o, varargin);
%         [o] = fn_Tabela5(o, varargin);
        
        [o] = fn_FlipaTabela1(o);
        [o] = fn_FlipaTabela2(o);
        [o] = fn_FlipaTabela3(o);
        [o] = fn_FlipaTabela4(o);
%         [o] = fn_FlipaTabela5(o);
        
        [o] = fn_AjusteAcumulado_Tabela4(o);
%         [o] = fn_AjusteAcumulado_Tabela5(o);
        
        []  = fn_SalvaDadosCondensados_FormatoMatlab(o);
    end
end

