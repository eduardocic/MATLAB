/*
 * soma_terminate.c
 *
 * Code generation for function 'soma_terminate'
 *
 * C source code generated on: Wed Jan 31 16:07:35 2018
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "soma.h"
#include "soma_terminate.h"

/* Function Definitions */
void soma_atexit(emlrtStack *sp)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  sp->tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(sp);
  emlrtLeaveRtStackR2012b(sp);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void soma_terminate(emlrtStack *sp)
{
  emlrtLeaveRtStackR2012b(sp);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (soma_terminate.c) */
