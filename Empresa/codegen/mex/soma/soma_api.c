/*
 * soma_api.c
 *
 * Code generation for function 'soma_api'
 *
 * C source code generated on: Wed Jan 31 16:07:35 2018
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "soma.h"
#include "soma_api.h"

/* Function Declarations */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *a, const
  char_T *identifier);
static const mxArray *emlrt_marshallOut(real_T u);

/* Function Definitions */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", FALSE, 0U, 0);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *a, const
  char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = b_emlrt_marshallIn(sp, emlrtAlias(a), &thisId);
  emlrtDestroyArray(&a);
  return y;
}

static const mxArray *emlrt_marshallOut(real_T u)
{
  const mxArray *y;
  const mxArray *m0;
  y = NULL;
  m0 = mxCreateDoubleScalar(u);
  emlrtAssign(&y, m0);
  return y;
}

void soma_api(emlrtStack *sp, const mxArray * const prhs[2], const mxArray *
              plhs[1])
{
  real_T a;
  real_T b;

  /* Marshall function inputs */
  a = emlrt_marshallIn(sp, emlrtAliasP(prhs[0]), "a");
  b = emlrt_marshallIn(sp, emlrtAliasP(prhs[1]), "b");

  /* Invoke the target function */
  a = soma(sp, a, b);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(a);
}

/* End of code generation (soma_api.c) */
