function [h] = plotaIndicador(o, varargin)

GrossuraLinha = 2;
n = max(size(varargin));
Indicador = varargin{1};
Cor       = varargin{2};
if (n > 2)
    Periodo   = varargin{3};
end

switch Indicador
    
    % ---------------------------------------------------------------------
    %                                 ROE
    %
    % ---------------------------------------------------------------------
    case 'ROE'
        x = o.Indicador.ROE.x;
        y = o.Indicador.ROE.y;     
        Bola = strcat(Cor, 'o');
        plot(x, y, Cor, 'LineWidth', GrossuraLinha);
        title('ROE - Retorno sobre o Patrim�nio L�quido', 'FontSize', 14);
        xlabel('Ano', 'FontSize', 14);
        ylabel('%', 'FontSize', 14);
           
        
%     % ---------------------------------------------------------------------
%     %                                 ROA
%     %
%     % ---------------------------------------------------------------------
%     case 'ROA'
%         switch Periodo
%             case 'Trimestre'
%                 plot(o.Data.TRIMESTRE, o.Indicador.ROA.TRIMESTRE, Cor, 'LineWidth', GrossuraLinha);
%                 xlabel('Ano');
%             case 'Ano'
%                 plot(o.Data.ANO, o.Indicador.ROA.ANO, Cor, 'LineWidth', GrossuraLinha);
%                 xlabel('Ano');
%                 
%             otherwise
%         end  
        
    % ---------------------------------------------------------------------
    %                           Lucro L�quido 
    %
    % ---------------------------------------------------------------------
    case 'Lucro L�quido (Trimestre)'          
                x = o.Indicador.LucroLiquido.Trimestre.x;
                y = o.Indicador.LucroLiquido.Trimestre.y;
                plot(x, y, Cor, 'LineWidth', GrossuraLinha);
                title('Lucro L�quido', 'FontSize', 14);
                xlabel('Ano', 'FontSize', 14);
                ylabel('Valor em milhares de R$', 'FontSize', 14);
    
    case 'Lucro L�quido (Ano)'          
                x = o.Indicador.LucroLiquido.Ano.x;
                y = o.Indicador.LucroLiquido.Ano.y;
                plot(x, y, Cor, 'LineWidth', GrossuraLinha);
                title('Lucro L�quido', 'FontSize', 14);
                xlabel('Ano', 'FontSize', 14);
                ylabel('Valor em milhares de R$', 'FontSize', 14);                
        
    % ---------------------------------------------------------------------
    %                  �ndice de Liquidez Corrente
    %
    % ---------------------------------------------------------------------
    case 'Indice de Liquidez Corrente'
        x = o.Indicador.IndiceLiquidezCorrente.x;
        y = o.Indicador.IndiceLiquidezCorrente.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('�ndice de Liquidez Corrente', 'FontSize', 14);
        xlabel('Ano', 'FontSize', 14);
        ylabel('');
        
        
    % ---------------------------------------------------------------------
    %                            Margem Bruta
    %
    % ---------------------------------------------------------------------
    case 'Margem Bruta'
        x = o.Indicador.MargemBruta.x;
        y = o.Indicador.MargemBruta.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('Margem Bruta', 'FontSize', 14);
        xlabel('Ano', 'FontSize', 14);
        ylabel('%', 'FontSize', 14);  
    
        
    % ---------------------------------------------------------------------
    %                         Margem L�quida
    %
    % ---------------------------------------------------------------------
    case 'Margem Liquida'
        x = o.Indicador.MargemLiquida.x;
        y = o.Indicador.MargemLiquida.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('Margem L�quida', 'FontSize', 14);
        xlabel('Ano', 'FontSize', 14);
        ylabel('%', 'FontSize', 14);
        
        
    % ---------------------------------------------------------------------
    %                           D�vida Bruta
    %
    % ---------------------------------------------------------------------
    case 'Divida Bruta'
        x = o.Indicador.DividaBruta.x;
        y = o.Indicador.DividaBruta.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('D�vida Bruta', 'FontSize', 14);
        xlabel('Ano', 'FontSize', 14);
        ylabel('Valor em milhares de R$', 'FontSize', 14);      
        
        
        
    % ---------------------------------------------------------------------
    %                           D�vida L�quida
    %
    % ---------------------------------------------------------------------
    case 'Divida Liquida'
        x = o.Indicador.DividaLiquida.x;
        y = o.Indicador.DividaLiquida.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('D�vida L�quida', 'FontSize', 14);
        xlabel('Ano', 'FontSize', 14);
        ylabel('Valor em milhares de R$', 'FontSize', 14); 
end

end