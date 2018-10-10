// Irei incluir a biblioteca MEX.
// ------------------------------
#include "mex.h"


// Aqui est� a minha fun��o.
// -------------------------
void timestwo(double y[], double x[], double z[]){
  y[0] = 2.0*(x[0] + x[1]) + z[0];
}


// Aqui � a chamada para a fun��o sempre a ser chamada.
// ----------------------------------------------------
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
// ------------------------------------------------------------------------
//   � comum que determinadas fun��es no ambiente Matlab sejam programadas 
// de tal forma que apare�am conforme o script abaixo.
//     
//             [a, b, c, ...] = funcao(x1, x2, x3, ...)
//     
// de forma que as sa�das (OUTPUT's) estejam do lado esquerdo (LEFT) da sua 
// declara��o e que as entradas (INPUT's) estejam do lado direito (RIGHT)
// da sua declara��o. Este mesmo princ�pio � utilizado na chamada das    
// fun��es MEX do Matlab.  
//
//   No caso da fun��o MEX do Matlab, al�m de ele dizer as vari�veis de 
// entrada e sa�das, � necess�rio que se especifique o tamanho das mesma
// (seja para delimita��o das vari�veis bem como dos ponteiros).
//     
//  (*) nlhs: acr�nimo para 'Number of Left-Handed Side' ARGUMENTS. Diz 
//            respeito ao n�mero ESPERADO de sa�das do tipo 'mxArray' (ou 
//            seja, quantidade de itens do lado esquerdo -- [a, b, c ,...])
//     
//  (*) plhs: acr�nimo para 'Pointer of Left-Handed Side'. Isso equivale
//            ao array de ponteiros do tipo 'mxArray' de tamanho 'nlhs'.
//            Ou seja, 'plhs' � um ponteiro de tamanho 'nlhs'.
//     
//  (*) rlhs: acr�nimo para 'Number of Right-Handed Side' ARGUMENTS. Diz
//            respeito ao n�mero de entradas do tipo 'mxArray' (ou seja, a
//            quantidade de itens do lado direito -- [x1, x2, x3, ...]).
//     
//  (*) prhs: acr�nimo para 'Pointer of Right-Handed Side'. Diz respeito os 
//            arrays de ponteiros do tipo 'mxArray' de tamanho 'rlhs'. Ou 
//            seja, 'prhs' � um ponteiro de tamanho 'nrls'.
// ------------------------------------------------------------------------ 
  double *y, *x, *z;
  size_t mrows, ncols;
 
  // Faz a verifica��o da quantidade de par�metros de entrada.
  // ---------------------------------------------------------  
  if(nrhs != 2) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:invalidNumInputs",
           "Duas vari�veis de entrada s�o necess�rias.");
  } else if(nlhs > 2) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:maxlhs",
           "Duas vari�veis de entrada s�o necess�rias. Muitos argumentos");
  }
 
  // ----------------------------------------------------------------------
  //   Esta parte do programa � essencial. Aqui que se faz necess�rio 
  // realizar todas as verifica��es das vari�veis de entrada do sistema,
  // ponteiro a ponteiro, para saber se a vari�vel que efetivamente est� 
  // sendo chamada � do tipo 'char', 'matrix', 'real', 'complex' etc.
  //   
  //   Se houver d�vida em como fazer isso, sugiro procurar por "Validate
  // Data for MEX files Matlab". Na referida p�gina tem toda a parte de 
  // suporte a verifica��o de vari�vel.
  // ----------------------------------------------------------------------
  // Verifica��o do PRIMEIRO item da minha entrada. No caso o vetor 'X'.
  mrows = mxGetM(prhs[0]);       
  ncols = mxGetN(prhs[0]);       
  if( !mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      !(mrows == 1 && ncols == 2) ) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:inputNotRealScalarDouble",
            "Input must be a noncomplex scalar double.");
  }
  
  // Verifica��o do SEGUNDO item da minha entrada. No caso o vetor 'Z'.
  mrows = mxGetM(prhs[1]);      // pega o n�mero de linhas de 'prhs[1]'
  ncols = mxGetN(prhs[1]);      // pega o n�mero de colunas de 'prhs[1]'
  if( !mxIsDouble(prhs[1]) || mxIsComplex(prhs[1]) ||
      !(mrows == 1 && ncols == 1) ) {
    mexErrMsgIdAndTxt( "MATLAB:timestwo:inputNotRealScalarDouble",
            "Input must be a noncomplex scalar double.");
  }
  
  //   Prepara os arquivos de sa�da com espa�os de mem�ria relativos aos 
  // tamanhos das respectivas vari�veis. No caso, a vari�vel de sa�da
  // ter� tamanho 1x1 (� meramente um escalar). Dessa forma, escrevo
  // da forma abaixo.
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
  
  // Aloca os ponteiros para cada uma das entradas e sa�das.
  // -------------------------------------------------------  
  //   
  // a) Entradas
  x = mxGetPr(prhs[0]);
  z = mxGetPr(prhs[1]);
  // b). Sa�das  
  y = mxGetPr(plhs[0]);
  
  
  // Chama a fun��o de interesse
  // ---------------------------
  timestwo(y, x, z);
}