function [] = plotaIndicador(o, varargin)

% Quantidade de vari�veis passadas para o sistema.
n = max(size(varargin));

% Espessura da linha do gr�fico.
GrossuraLinha = 2;
TamanhoFonte  = 12;
TamanhoTitulo = 12;

% Indicador e Cor a serem utilizadas.
Indicador = varargin{1};
Indicador = char(Indicador);
if( n >= 1)
    Cor       = varargin{2};
end

% Plota o Indicador.
switch Indicador

    % ROE    
    case 'ROE'
        x = o.Indicador.ROE.x;
        y = o.Indicador.ROE.y;     
        plot(x, y, Cor, 'LineWidth', GrossuraLinha);
        title('ROE - Retorno sobre o Patrim�nio L�quido', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('%', 'FontSize', TamanhoFonte);

    % Lucro L�quido 
    case 'Lucro L�quido (Trimestre)'          
        x = o.Indicador.LucroLiquido.Trimestre.x;
        y = o.Indicador.LucroLiquido.Trimestre.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha);
        title('Lucro L�quido (Trimestre)', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('Valor em milhares de R$', 'FontSize', TamanhoFonte);

    case 'Lucro L�quido (Ano)'          
        x = o.Indicador.LucroLiquido.Ano.x;
        y = o.Indicador.LucroLiquido.Ano.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha);
        title('Lucro L�quido (Ano)', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('Valor em milhares de R$', 'FontSize', TamanhoFonte);                

    % �ndice de Liquidez Corrente
    case '�ndice de Liquidez Corrente'
        x = o.Indicador.IndiceLiquidezCorrente.x;
        y = o.Indicador.IndiceLiquidezCorrente.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('�ndice de Liquidez Corrente', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('');

    % Margem Bruta
    case 'Margem Bruta'
        x = o.Indicador.MargemBruta.x;
        y = o.Indicador.MargemBruta.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('Margem Bruta', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('%', 'FontSize', TamanhoFonte);  

    % Margem L�quida
    case 'Margem L�quida'
        x = o.Indicador.MargemLiquida.x;
        y = o.Indicador.MargemLiquida.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('Margem L�quida', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('%', 'FontSize', TamanhoFonte);
end
end