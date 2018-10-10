#include "__cf_Simulink_Xss_Com_Restricao.h"
#ifndef RTW_HEADER_Simulink_Xss_Com_Restricao_acc_h_
#define RTW_HEADER_Simulink_Xss_Com_Restricao_acc_h_
#ifndef Simulink_Xss_Com_Restricao_acc_COMMON_INCLUDES_
#define Simulink_Xss_Com_Restricao_acc_COMMON_INCLUDES_
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#define S_FUNCTION_NAME simulink_only_sfcn 
#define S_FUNCTION_LEVEL 2
#define RTW_GENERATED_S_FUNCTION
#include "sl_fileio_rtw.h"
#include "rtwtypes.h"
#include "multiword_types.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "rt_defines.h"
#include "rt_nonfinite.h"
#endif
#include "Simulink_Xss_Com_Restricao_acc_types.h"
typedef struct { real_T B_0_0_0 [ 2 ] ; real_T B_0_1_0 [ 5 ] ; real_T B_0_3_0
[ 7 ] ; } B_Simulink_Xss_Com_Restricao_T ; typedef struct { real_T
DiscreteStateSpace_DSTATE [ 2 ] ; struct { void * LoggedData ; } F_PWORK ;
struct { void * FilePtr ; } ToFile_PWORK ; struct { void * LoggedData ; }
u_PWORK ; struct { void * LoggedData ; } x_PWORK ; struct { void * LoggedData
; } xss_PWORK ; struct { int_T Count ; int_T Decimation ; } ToFile_IWORK ;
char pad_ToFile_IWORK [ 4 ] ; } DW_Simulink_Xss_Com_Restricao_T ; struct
P_Simulink_Xss_Com_Restricao_T_ { real_T P_0 [ 3 ] ; real_T P_1 ; real_T P_2
[ 2 ] ; real_T P_4 [ 2 ] ; real_T P_5 [ 2 ] ; real_T P_6 [ 8 ] ; real_T P_7 [
2 ] ; real_T P_8 [ 2 ] ; real_T P_9 [ 2 ] ; real_T P_10 [ 2 ] ; real_T P_11 [
2 ] ; real_T P_12 ; real_T P_13 [ 2 ] ; real_T P_14 ; real_T P_15 [ 2 ] ;
real_T P_16 ; } ; extern P_Simulink_Xss_Com_Restricao_T
Simulink_Xss_Com_Restricao_rtDefaultP ;
#endif
