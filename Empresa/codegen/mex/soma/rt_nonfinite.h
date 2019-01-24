/*
 * rt_nonfinite.h
 *
 * Code generation for function 'soma'
 *
 * C source code generated on: Wed Jan 31 16:07:35 2018
 *
 */

#ifndef __RT_NONFINITE_H__
#define __RT_NONFINITE_H__
#define rtInf      	mxGetInf()
#define rtMinusInf 	(-mxGetInf())
#define rtNaN      	mxGetNaN()
#define rtIsNaN(X) 	mxIsNaN(X)
#define rtIsInf(X) 	mxIsInf(X)
#define rtIsNaNF(X)	mxIsNaN(X)
#define rtIsInfF(X)	mxIsInf(X)
#endif
/* End of code generation (rt_nonfinite.h) */
