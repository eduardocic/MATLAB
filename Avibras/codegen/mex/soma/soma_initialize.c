/*
 * soma_initialize.c
 *
 * Code generation for function 'soma_initialize'
 *
 * C source code generated on: Wed Jan 31 16:07:35 2018
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "soma.h"
#include "soma_initialize.h"

/* Variable Definitions */
static const volatile char_T *emlrtBreakCheckR2012bFlagVar;

/* Function Definitions */
void soma_initialize(emlrtStack *sp, emlrtContext *aContext)
{
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, aContext, NULL, 1);
  sp->tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(sp, FALSE, 0U, 0);
  emlrtEnterRtStackR2012b(sp);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (soma_initialize.c) */
