#ifndef __Identificacao_Recursiva_NaoLinear_sfun_h__
#define __Identificacao_Recursiva_NaoLinear_sfun_h__

/* Include files */
#define S_FUNCTION_NAME                sf_sfun
#include "sfc_sf.h"
#include "sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"
#include "sfcdebug.h"
#define rtInf                          (mxGetInf())
#define rtMinusInf                     (-(mxGetInf()))
#define rtNaN                          (mxGetNaN())
#define rtIsNaN(X)                     ((int)mxIsNaN(X))
#define rtIsInf(X)                     ((int)mxIsInf(X))

struct SfDebugInstanceStruct;
extern struct SfDebugInstanceStruct* sfGlobalDebugInstanceStruct;

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */
extern uint32_T _Identificacao_Recursiva_NaoLinearMachineNumber_;
extern real_T _sfTime_;

/* Variable Definitions */

/* Function Declarations */
extern void Identificacao_Recursiva_NaoLinear_initializer(void);
extern void Identificacao_Recursiva_NaoLinear_terminator(void);

/* Function Definitions */

/* We load infoStruct for rtw_optimation_info on demand in mdlSetWorkWidths and
   free it immediately in mdlStart. Given that this is machine-wide as
   opposed to chart specific, we use NULL check to make sure it gets loaded
   and unloaded once per machine even though the  methods mdlSetWorkWidths/mdlStart
   are chart/instance specific. The following methods abstract this out. */
extern mxArray* load_Identificacao_Recursiva_NaoLinear_optimization_info(void);
extern void unload_Identificacao_Recursiva_NaoLinear_optimization_info(void);

#endif
