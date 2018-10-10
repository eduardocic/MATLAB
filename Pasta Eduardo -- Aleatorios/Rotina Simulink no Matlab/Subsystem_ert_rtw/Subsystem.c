/*
 * File: Subsystem.c
 *
 * Code generated for Simulink model 'Subsystem'.
 *
 * Model version                  : 1.8
 * Simulink Coder version         : 8.5 (R2013b) 08-Aug-2013
 * C/C++ source code generated on : Tue Jan 23 10:26:50 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: 32-bit Generic
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Subsystem.h"
#include "Subsystem_private.h"

/* External inputs (root inport signals with auto storage) */
ExtU_Subsystem_T Subsystem_U;

/* External outputs (root outports fed by signals with auto storage) */
ExtY_Subsystem_T Subsystem_Y;

/* Real-time model */
RT_MODEL_Subsystem_T Subsystem_M_;
RT_MODEL_Subsystem_T *const Subsystem_M = &Subsystem_M_;

/* Model step function */
void Subsystem_step(void)
{
  real_T rtb_h;

  /* MATLAB Function: '<S1>/MATLAB Function' incorporates:
   *  Inport: '<Root>/U1'
   *  Inport: '<Root>/U2'
   *  Inport: '<Root>/U3'
   *  Inport: '<Root>/U4'
   *  SignalConversion: '<S3>/TmpSignal ConversionAt SFunction Inport1'
   */
  /* MATLAB Function 'Subsystem/MATLAB Function': '<S3>:1' */
  /*  Pega as entradas. */
  /* '<S3>:1:4' */
  /* '<S3>:1:5' */
  /* '<S3>:1:6' */
  /* '<S3>:1:7' */
  /*  Calcula a altura. */
  /* '<S3>:1:10' */
  rtb_h = (Subsystem_U.U2 * Subsystem_U.U4 + Subsystem_U.U1) - 0.5 *
    Subsystem_U.U3 * (Subsystem_U.U4 * Subsystem_U.U4);

  /* Outport: '<Root>/Y' */
  Subsystem_Y.Y = rtb_h;

  /* Stop: '<S1>/Stop Simulation' incorporates:
   *  Constant: '<S2>/Constant'
   *  RelationalOperator: '<S2>/Compare'
   */
  if (rtb_h <= Subsystem_P.Constant_Value) {
    rtmSetStopRequested(Subsystem_M, 1);
  }

  /* End of Stop: '<S1>/Stop Simulation' */
}

/* Model initialize function */
void Subsystem_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)Subsystem_M, 0,
                sizeof(RT_MODEL_Subsystem_T));

  /* external inputs */
  (void) memset((void *)&Subsystem_U, 0,
                sizeof(ExtU_Subsystem_T));

  /* external outputs */
  Subsystem_Y.Y = 0.0;
}

/* Model terminate function */
void Subsystem_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
