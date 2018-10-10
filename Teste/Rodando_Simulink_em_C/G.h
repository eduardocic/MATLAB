/*
 * File: G.h
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

#ifndef RTW_HEADER_G_h_
#define RTW_HEADER_G_h_
#ifndef G_COMMON_INCLUDES_
# define G_COMMON_INCLUDES_
#include <stddef.h>
#include <string.h>
#include "rtwtypes.h"
#endif                                 /* G_COMMON_INCLUDES_ */

#include "G_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

/* External inputs (root inport signals with auto storage) */
typedef struct {
  int32_T u1;                          /* '<Root>/u1' */
  int32_T u2;                          /* '<Root>/u2' */
} ExtU_G_T;

/* External outputs (root outports fed by signals with auto storage) */
typedef struct {
  int32_T y;                           /* '<Root>/y' */
} ExtY_G_T;

/* Parameters (auto storage) */
struct P_G_T_ {
  int32_T Gain_Gain;                   /* Computed Parameter: Gain_Gain
                                        * Referenced by: '<S1>/Gain'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_G_T {
  const char_T * volatile errorStatus;
};

/* Block parameters (auto storage) */
extern P_G_T G_P;

/* External inputs (root inport signals with auto storage) */
extern ExtU_G_T G_U;

/* External outputs (root outports fed by signals with auto storage) */
extern ExtY_G_T G_Y;

/* Model entry point functions */
extern void G_initialize(void);
extern void G_step(void);
extern void G_terminate(void);

/* Real-time Model object */
extern RT_MODEL_G_T *const G_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Note that this particular code originates from a subsystem build,
 * and has its own system numbers different from the parent model.
 * Refer to the system hierarchy for this subsystem below, and use the
 * MATLAB hilite_system command to trace the generated code back
 * to the parent model.  For example,
 *
 * hilite_system('Simulacao/G')    - opens subsystem Simulacao/G
 * hilite_system('Simulacao/G/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Simulacao'
 * '<S1>'   : 'Simulacao/G'
 */
#endif                                 /* RTW_HEADER_G_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
