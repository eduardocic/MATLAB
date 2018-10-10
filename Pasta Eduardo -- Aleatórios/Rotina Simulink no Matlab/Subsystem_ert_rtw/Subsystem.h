/*
 * File: Subsystem.h
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

#ifndef RTW_HEADER_Subsystem_h_
#define RTW_HEADER_Subsystem_h_
#ifndef Subsystem_COMMON_INCLUDES_
# define Subsystem_COMMON_INCLUDES_
#include <string.h>
#include "rtwtypes.h"
#endif                                 /* Subsystem_COMMON_INCLUDES_ */

#include "Subsystem_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

/* External inputs (root inport signals with auto storage) */
typedef struct {
  real_T U1;                           /* '<Root>/U1' */
  real_T U2;                           /* '<Root>/U2' */
  real_T U3;                           /* '<Root>/U3' */
  real_T U4;                           /* '<Root>/U4' */
} ExtU_Subsystem_T;

/* External outputs (root outports fed by signals with auto storage) */
typedef struct {
  real_T Y;                            /* '<Root>/Y' */
} ExtY_Subsystem_T;

/* Parameters (auto storage) */
struct P_Subsystem_T_ {
  real_T Constant_Value;               /* Expression: 0
                                        * Referenced by: '<S2>/Constant'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_Subsystem_T {
  const char_T * volatile errorStatus;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (auto storage) */
extern P_Subsystem_T Subsystem_P;

/* External inputs (root inport signals with auto storage) */
extern ExtU_Subsystem_T Subsystem_U;

/* External outputs (root outports fed by signals with auto storage) */
extern ExtY_Subsystem_T Subsystem_Y;

/* Model entry point functions */
extern void Subsystem_initialize(void);
extern void Subsystem_step(void);
extern void Subsystem_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Subsystem_T *const Subsystem_M;

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
 * hilite_system('untitled/Subsystem')    - opens subsystem untitled/Subsystem
 * hilite_system('untitled/Subsystem/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'untitled'
 * '<S1>'   : 'untitled/Subsystem'
 * '<S2>'   : 'untitled/Subsystem/Compare To Zero'
 * '<S3>'   : 'untitled/Subsystem/MATLAB Function'
 */
#endif                                 /* RTW_HEADER_Subsystem_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
