classdef Conversor_Matlab_Excel
    
    properties
        raiz 
        
        Dados
        NomeArquivoExcel_Final
        
        Aba_1
        Aba_2
        Aba_3
    end
    
    methods
        
        function [o] = Conversor_Matlab_Excel(o)
            o.raiz = pwd;
            
            Titulo = 'Selecione os arquivos *.mat references aos balanços da empresa';
            [NomeArquivo_Matlab, CaminhoArquivo, ~] = uigetfile(fullfile(o.raiz, '*.mat'), Titulo)
            rmpath([CaminhoArquivo]);
            addpath([CaminhoArquivo]); 

            o.Dados = load(NomeArquivo_Matlab)
            [principal, remain] = strtok(NomeArquivo_Matlab,'.');
            o.NomeArquivoExcel_Final = strcat(principal,'.xls');
            
            o = fn_Spreadsheet_1(o);
%             o = fn_Spreadsheet_2(o);
%             o = fn_Spreadsheet_3(o);
%             
%             o = fn_CriandoArquivo_Excel(o);
        end
        
        [o] = fn_Spreadsheet_1(o);
%         [o] = fn_Spreadsheet_2(o);
%         [o] = fn_Spreadsheet_3(o);
%        
%         [o] = fn_CriandoArquivo_Excel(o);
    end
    
end

