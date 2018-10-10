/*
 * File: G.c
 *
 * Code generated for Simulink model 'G'.
 *
 * Model version                  : 1.20
 * Simulink Coder version         : 8.5 (R2013b) 08-Aug-2013
 * C/C++ source code generated on : Wed Dec 20 15:24:18 2017
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: 32-bit Generic
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "G.h"
#include "G_private.h"

/* External inputs (root inport signals with auto storage) */
ExtU_G_T G_U;

/* External outputs (root outports fed by signals with auto storage) */
ExtY_G_T G_Y;

/* Real-time model */
RT_MODEL_G_T G_M_;
RT_MODEL_G_T *const G_M = &G_M_;

/* Model step function */
void G_step(void)
{
  /* Outport: '<Root>/y' incorporates:
   *  Gain: '<S1>/Gain'
   *  Inport: '<Root>/u1'
   *  Inport: '<Root>/u2'
   *  Sum: '<S1>/Sum'
   */
  G_Y.y = G_P.Gain_Gain * G_U.u2 + G_U.u1;
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
  G_Y.y = 0;
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
