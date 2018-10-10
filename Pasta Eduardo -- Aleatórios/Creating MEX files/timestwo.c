// Irei incluir a biblioteca MEX.
// ------------------------------
#include "mex.h"


// Aqui está a minha função.
// -------------------------
void timestwo(double y[], double x[], double z[]){
  y[0] = 2.0*(x[0] + x[1]) + z[0];
}


// Aqui é a chamada para a função sempre a ser chamada.
// ----------------------------------------------------
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
// ------------------------------------------------------------------------
//   É comum que determinadas funções no ambiente Matlab sejam programadas 
// de tal forma que apareçam conforme o script abaixo.
//     
//             [a, b, c, ...] = funcao(x1, x2, x3, ...)
//     
// de forma que as saídas (OUTPUT's) estejam do lado esquerdo (LEFT) da sua 
// declaração e que as entradas (INPUT's) estejam do lado direito (RIGHT)
// da sua declaração. Este mesmo princípio é utilizado na chamada das    
// funções MEX do Matlab.  
//
//   No caso da função MEX do Matlab, além de ele dizer as variáveis de 
// entrada e saídas, é necessário que se especifique o tamanho das mesma
// (seja para delimitação das variáveis bem como dos ponteiros).
//     
//  (*) nlhs: acrônimo para 'Number of Left-Handed Side' ARGUMENTS. Diz 
//            respeito ao número ESPERADO de saídas do tipo 'mxArray' (ou 
//            seja, quantidade de itens do lado esquerdo -- [a, b, c ,...])
//     
//  (*) plhs: acrônimo para 'Pointer of Left-Handed Side'. Isso equivale
//            ao array de ponteiros do tipo 'mxArray' de tamanho 'nlhs'.
//            Ou seja, 'plhs' é um ponteiro de tamanho 'nlhs'.
//     
//  (*) rlhs: acrônimo para 'Number of Right-Handed Side' ARGUMENTS. Diz
//            respeito ao número de entradas do tipo 'mxArray' (ou seja, a
//            quantidade de itens do lado direito -- [x1, x2, x3, ...]).
//     
//  (*) prhs: acrônimo para 'Pointer of Right-Handed Side'. Diz respeito os 
//            arrays de ponteiros do tipo 'mxArray' de tamanho 'rlhs'. Ou 
//            seja, 'prhs' é um ponteiro de tamanho 'nrls'.
// ------------------------------------------------------------------------ 
  double *y, *x, *z;
  size_t mrows, ncols;
 
  // Faz a verificação da quantidade de parâmetros de entrada.
  // ---------------------------------------------------------  
  if(nrhs != 2) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:invalidNumInputs",
           "Duas variáveis de entrada são necessárias.");
  } else if(nlhs > 2) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:maxlhs",
           "Duas variáveis de entrada são necessárias. Muitos argumentos");
  }
 
  // ----------------------------------------------------------------------
  //   Esta parte do programa é essencial. Aqui que se faz necessário 
  // realizar todas as verificações das variáveis de entrada do sistema,
  // ponteiro a ponteiro, para saber se a variável que efetivamente está 
  // sendo chamada é do tipo 'char', 'matrix', 'real', 'complex' etc.
  //   
  //   Se houver dúvida em como fazer isso, sugiro procurar por "Validate
  // Data for MEX files Matlab". Na referida página tem toda a parte de 
  // suporte a verificação de variável.
  // ----------------------------------------------------------------------
  // Verificação do PRIMEIRO item da minha entrada. No caso o vetor 'X'.
  mrows = mxGetM(prhs[0]);       
  ncols = mxGetN(prhs[0]);       
  if( !mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      !(mrows == 1 && ncols == 2) ) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:inputNotRealScalarDouble",
            "Input must be a noncomplex scalar double.");
  }
  
  // Verificação do SEGUNDO item da minha entrada. No caso o vetor 'Z'.
  mrows = mxGetM(prhs[1]);      // pega o número de linhas de 'prhs[1]'
  ncols = mxGetN(prhs[1]);      // pega o número de colunas de 'prhs[1]'
  if( !mxIsDouble(prhs[1]) || mxIsComplex(prhs[1]) ||
      !(mrows == 1 && ncols == 1) ) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:inputNotRealScalarDouble",
            "Input must be a noncomplex scalar double.");
  }
  
  //   Prepara os arquivos de saída com espaços de memória relativos aos 
  // tamanhos das respectivas variáveis. No caso, a variável de saída
  // terá tamanho 1x1 (é meramente um escalar). Dessa forma, escrevo
  // da forma abaixo.
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
  
  // Aloca os ponteiros para cada uma das entradas e saídas.
  // -------------------------------------------------------  
  //   
  // a) Entradas
  x = mxGetPr(prhs[0]);
  z = mxGetPr(prhs[1]);
  // b). Saídas  
  y = mxGetPr(plhs[0]);
  
  
  // Chama a função de interesse
  // ---------------------------
  timestwo(y, x, z);
}