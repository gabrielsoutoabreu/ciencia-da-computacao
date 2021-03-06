clear all; % Limpa todas as variáveis
close all; % Fecha todas figuras
clc; % Limpa a tela

% Espaço de busca
xmin = -100;
xmax = 100;

% Número de execuções do algoritmo
numEXEC = 10;

% Problema a ser abordado
problema = 1;

% Operador de cruzamento utilizado
metCRUZ = 1;

% Operador de mutação utilizado
metMUT = 1;

% Operador de seleção utilizado
metSEL = 1;

% Número de variáveis do problema
numVAR = 1;

% Critério de parada
maxFX = 1000;

% Tamanho da população
tamPOP = 20;

for t = 1:numEXEC
    tempo = cputime();
    
    % Geração da população inicial aleatória
    POP = xmin + rand(tamPOP,numVAR) .* (xmax - xmin);
    FX = calculaFX(POP,problema);
    
    % Número de soluções geradas até o momento
    numFX = tamPOP;
    
    while numFX < maxFX
        % O parâmetro metCRUZ deve definir o operador a ser utilizado
        POPnovo = cruzamento(POP,xmin,xmax,metCRUZ);
        
        % A mutação ocorre na população gerada, mas isso pode ser alterado
        POPnovo = mutacao(POPnovo,xmin,xmax,metMUT);
        
        FXnovo = calculaFX(POPnovo,problema);
        numFX = numFX + size(POPnovo,1);
        
        POP = [POP; POPnovo];
        FX = [FX; FXnovo];
        
        % O parâmetro metSEL será utilizado posteriormente
        [POP, FX] = selecao(POP,FX,tamPOP,metSEL);
    end
    tempo = cputime() - tempo;
    
    fprintf('[%d] O melhor valor encontrado foi: %2.4f \t\t(%1.4f segundos)\n',iter, min(FX),tempo);
end