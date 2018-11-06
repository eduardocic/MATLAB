#include <stdio.h>
#include "funcoes.h"

/*******************************************************
 * Funções do meu sistema as quais eu desejo executar
 * no meu sistema. Nesta parte do programa eu pratica-
 * mente não me preocupo com a parte do driver em sim.
 * De maneira que a abtração fica por parte apenas do 
 * driver.
 ******************************************************/

int fatorial(int n){

    if ( n == 0 ){
        
        printf("Fatorial é: %d\n", 1);
        return 1;
    }
    else {
        int fat = 1;
        for (int i = 1; i <= n ; i++){
            fat = fat*i;
        }
        printf("Fatorial é: %d\n", fat);
        return fat;
    }
}

int quadrado(int n){
    printf("Quadrado é: %d\n", n*n);
    return n*n;
}


float produto(float n1, double n2) {
    /* printf("Produto é: %d\n", n1*n2); */
    return n1*n2;
}


void printa(void) {
    printf("Olá, mundo\n\n");
}
