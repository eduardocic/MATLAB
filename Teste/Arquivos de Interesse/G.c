/*
 * File: G.c
 *
 * Code generated for Simulink model 'G'.
 *
 * Model version                  : 1.12
 * Simulink Coder version         : 8.5 (R2013b) 08-Aug-2013
 * C/C++ source code generated on : Wed Dec 20 13:09:56 2017
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: 32-bit Generic
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "G.h"
#include "G_private.h"

const int64m_T G_sfix64_En29_GND = { { 0UL, 0UL } };/* int64m_T ground */

/* External inputs (root inport signals with auto storage) */
ExtU_G_T G_U;

/* External outputs (root outports fed by signals with auto storage) */
ExtY_G_T G_Y;

/* Real-time model */
RT_MODEL_G_T G_M_;
RT_MODEL_G_T *const G_M = &G_M_;
void MultiWordAdd(const uint32_T u1[], const uint32_T u2[], uint32_T y[],
                  int32_T n)
{
  uint32_T yi;
  uint32_T u1i;
  uint32_T carry = 0U;
  int32_T i;
  for (i = 0; i < n; i++) {
    u1i = u1[i];
    yi = (u1i + u2[i]) + carry;
    y[i] = yi;
    carry = carry != 0U ? yi <= u1i ? 1U : 0U : yi < u1i ? 1U : 0U;
  }
}

void sMultiWordShl(const uint32_T u1[], int32_T n1, uint32_T n2, uint32_T y[],
                   int32_T n)
{
  int32_T nb;
  int32_T nc;
  int32_T i;
  uint32_T ys;
  uint32_T u1i;
  uint32_T yi;
  uint32_T nr;
  uint32_T nl;
  nb = (int32_T)(n2 >> 5);
  ys = (u1[n1 - 1] & 2147483648U) != 0U ? MAX_uint32_T : 0U;
  nc = nb > n ? n : nb;
  u1i = 0U;
  for (i = 0; i < nc; i++) {
    y[i] = 0U;
  }

  if (nb < n) {
    nl = n2 - ((uint32_T)nb << 5);
    nb += n1;
    if (nb > n) {
      nb = n;
    }

    nb -= i;
    if (nl > 0U) {
      nr = 32U - nl;
      for (nc = 0; nc < nb; nc++) {
        yi = u1i >> nr;
        u1i = u1[nc];
        y[i] = u1i << nl | yi;
        i++;
      }

      if (i < n) {
        y[i] = u1i >> nr | ys << nl;
        i++;
      }
    } else {
      for (nc = 0; nc < nb; nc++) {
        y[i] = u1[nc];
        i++;
      }
    }
  }

  while (i < n) {
    y[i] = ys;
    i++;
  }
}

void sLong2MultiWord(int32_T u, uint32_T y[], int32_T n)
{
  uint32_T yi;
  int32_T i;
  y[0] = (uint32_T)u;
  yi = u < 0 ? MAX_uint32_T : 0U;
  for (i = 1; i < n; i++) {
    y[i] = yi;
  }
}

void sMultiWordMul(const uint32_T u1[], int32_T n1, const uint32_T u2[], int32_T
                   n2, uint32_T y[], int32_T n)
{
  int32_T i;
  int32_T j;
  int32_T k;
  int32_T nj;
  uint32_T u1i;
  uint32_T yk;
  uint32_T a;
  uint32_T a_0;
  uint32_T b;
  uint32_T w;
  uint32_T w_0;
  uint32_T cb;
  boolean_T isNegative;
  boolean_T isNegative_0;
  uint32_T cb_0;
  uint32_T cb_1;
  isNegative = ((u1[n1 - 1] & 2147483648U) != 0U);
  isNegative_0 = ((u2[n2 - 1] & 2147483648U) != 0U);
  cb_0 = 1U;

  /* Initialize output to zero */
  for (k = 0; k < n; k++) {
    y[k] = 0U;
  }

  for (i = 0; i < n1; i++) {
    cb = 0U;
    u1i = u1[i];
    if (isNegative) {
      u1i = ~u1i + cb_0;
      cb_0 = u1i < cb_0 ? 1U : 0U;
    }

    a = u1i >> 16U;
    a_0 = u1i & 65535U;
    cb_1 = 1U;
    k = n - i;
    nj = n2 <= k ? n2 : k;
    k = i;
    for (j = 0; j < nj; j++) {
      yk = y[k];
      u1i = u2[j];
      if (isNegative_0) {
        u1i = ~u1i + cb_1;
        cb_1 = u1i < cb_1 ? 1U : 0U;
      }

      b = u1i >> 16U;
      u1i &= 65535U;
      w = a * u1i;
      w_0 = a_0 * b;
      yk += cb;
      cb = yk < cb ? 1U : 0U;
      u1i *= a_0;
      yk += u1i;
      cb += yk < u1i ? 1U : 0U;
      u1i = w << 16U;
      yk += u1i;
      cb += yk < u1i ? 1U : 0U;
      u1i = w_0 << 16U;
      yk += u1i;
      cb += yk < u1i ? 1U : 0U;
      y[k] = yk;
      cb += w >> 16U;
      cb += w_0 >> 16U;
      cb += a * b;
      k++;
    }

    if (k < n) {
      y[k] = cb;
    }
  }

  /* Apply sign */
  if (isNegative != isNegative_0) {
    cb = 1U;
    for (k = 0; k < n; k++) {
      yk = ~y[k] + cb;
      y[k] = yk;
      cb = yk < cb ? 1U : 0U;
    }
  }
}

/* Model step function */
void G_step(void)
{
  int64m_T tmp;
  int64m_T tmp_0;
  uint32_T tmp_1;
  uint32_T tmp_2;
  int64m_T tmp_3;

  /* Sum: '<S1>/Sum' incorporates:
   *  Inport: '<Root>/u1'
   */
  sLong2MultiWord(G_U.u1, &tmp_0.chunks[0U], 2);
  sMultiWordShl(&tmp_0.chunks[0U], 2, 29U, &tmp.chunks[0U], 2);

  /* Gain: '<S1>/Gain' incorporates:
   *  Inport: '<Root>/u2'
   */
  tmp_1 = (uint32_T)G_P.Gain_Gain;
  tmp_2 = (uint32_T)G_U.u2;
  sMultiWordMul(&tmp_1, 1, &tmp_2, 1, &tmp_0.chunks[0U], 2);

  /* Sum: '<S1>/Sum' */
  MultiWordAdd(&tmp.chunks[0U], &tmp_0.chunks[0U], &tmp_3.chunks[0U], 2);

  /* Outport: '<Root>/y' incorporates:
   *  Sum: '<S1>/Sum'
   */
  G_Y.y = tmp_3;
}

/* Model initialize function */
void G_initialize(void)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatus(G_M, (NULL));

  /* external inputs */
  (void) memset((void *)&G_U, 0,
                sizeof(ExtU_G_T));

  /* external outputs */
  G_Y.y = G_sfix64_En29_GND;
}

/* Model terminate function */
void G_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
