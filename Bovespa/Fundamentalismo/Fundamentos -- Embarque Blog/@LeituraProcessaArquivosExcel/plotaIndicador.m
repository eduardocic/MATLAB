function [] = plotaIndicador(o, varargin)

% Quantidade de variáveis passadas para o sistema.
n = max(size(varargin));

% Espessura da linha do gráfico.
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
        title('ROE - Retorno sobre o Patrimônio Líquido', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('%', 'FontSize', TamanhoFonte);

    % Lucro Líquido 
    case 'Lucro Líquido (Trimestre)'          
        x = o.Indicador.LucroLiquido.Trimestre.x;
        y = o.Indicador.LucroLiquido.Trimestre.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha);
        title('Lucro Líquido (Trimestre)', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('Valor em milhares de R$', 'FontSize', TamanhoFonte);

    case 'Lucro Líquido (Ano)'          
        x = o.Indicador.LucroLiquido.Ano.x;
        y = o.Indicador.LucroLiquido.Ano.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha);
        title('Lucro Líquido (Ano)', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('Valor em milhares de R$', 'FontSize', TamanhoFonte);                

    % Índice de Liquidez Corrente
    case 'Índice de Liquidez Corrente'
        x = o.Indicador.IndiceLiquidezCorrente.x;
        y = o.Indicador.IndiceLiquidezCorrente.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('Índice de Liquidez Corrente', 'FontSize', TamanhoTitulo);
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

    % Margem Líquida
    case 'Margem Líquida'
        x = o.Indicador.MargemLiquida.x;
        y = o.Indicador.MargemLiquida.y;
        plot(x, y, Cor, 'LineWidth', GrossuraLinha); grid;
        title('Margem Líquida', 'FontSize', TamanhoTitulo);
        xlabel('Ano', 'FontSize', TamanhoFonte);
        ylabel('%', 'FontSize', TamanhoFonte);
end
end