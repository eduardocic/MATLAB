#include "__cf_Simulink_Xss_Com_Restricao.h"
#include <math.h>
#include "Simulink_Xss_Com_Restricao_acc.h"
#include "Simulink_Xss_Com_Restricao_acc_private.h"
#include <stdio.h>
#include "simstruc.h"
#include "fixedpoint.h"
#define CodeFormat S-Function
#define AccDefine1 Accelerator_S-Function
static void mdlOutputs ( SimStruct * S , int_T tid ) {
B_Simulink_Xss_Com_Restricao_T * _rtB ; P_Simulink_Xss_Com_Restricao_T * _rtP
; DW_Simulink_Xss_Com_Restricao_T * _rtDW ; _rtDW = ( (
DW_Simulink_Xss_Com_Restricao_T * ) ssGetRootDWork ( S ) ) ; _rtP = ( (
P_Simulink_Xss_Com_Restricao_T * ) ssGetDefaultParam ( S ) ) ; _rtB = ( (
B_Simulink_Xss_Com_Restricao_T * ) _ssGetBlockIO ( S ) ) ; if ( ssIsSampleHit
( S , 1 , 0 ) ) { { _rtB -> B_0_0_0 [ 0 ] = ( _rtP -> P_2 [ 0 ] ) * _rtDW ->
DiscreteStateSpace_DSTATE [ 0 ] ; _rtB -> B_0_0_0 [ 1 ] = ( _rtP -> P_2 [ 1 ]
) * _rtDW -> DiscreteStateSpace_DSTATE [ 1 ] ; } ssCallAccelRunBlock ( S , 0
, 1 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 0 , 2 ,
SS_CALL_MDL_OUTPUTS ) ; _rtB -> B_0_3_0 [ 0 ] = _rtB -> B_0_1_0 [ 0 ] ; _rtB
-> B_0_3_0 [ 1 ] = _rtB -> B_0_0_0 [ 0 ] ; _rtB -> B_0_3_0 [ 2 ] = _rtB ->
B_0_0_0 [ 1 ] ; _rtB -> B_0_3_0 [ 3 ] = _rtB -> B_0_1_0 [ 1 ] ; _rtB ->
B_0_3_0 [ 4 ] = _rtB -> B_0_1_0 [ 2 ] ; _rtB -> B_0_3_0 [ 5 ] = _rtB ->
B_0_1_0 [ 3 ] ; _rtB -> B_0_3_0 [ 6 ] = _rtB -> B_0_1_0 [ 4 ] ; { const char
* errMsg = ( NULL ) ; void * fp = ( void * ) _rtDW -> ToFile_PWORK . FilePtr
; if ( fp != ( NULL ) ) { { real_T t ; void * u ; t = ssGetTaskTime ( S , 1 )
; u = ( void * ) & _rtB -> B_0_3_0 [ 0 ] ; errMsg =
rtwH5LoggingCollectionWrite ( 1 , fp , 0 , t , u ) ; if ( errMsg != ( NULL )
) { ssSetErrorStatus ( S , errMsg ) ; return ; } } } } ssCallAccelRunBlock (
S , 0 , 5 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 0 , 6 ,
SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 0 , 7 , SS_CALL_MDL_OUTPUTS
) ; } UNUSED_PARAMETER ( tid ) ; }
#define MDL_UPDATE
static void mdlUpdate ( SimStruct * S , int_T tid ) {
B_Simulink_Xss_Com_Restricao_T * _rtB ; P_Simulink_Xss_Com_Restricao_T * _rtP
; DW_Simulink_Xss_Com_Restricao_T * _rtDW ; _rtDW = ( (
DW_Simulink_Xss_Com_Restricao_T * ) ssGetRootDWork ( S ) ) ; _rtP = ( (
P_Simulink_Xss_Com_Restricao_T * ) ssGetDefaultParam ( S ) ) ; _rtB = ( (
B_Simulink_Xss_Com_Restricao_T * ) _ssGetBlockIO ( S ) ) ; if ( ssIsSampleHit
( S , 1 , 0 ) ) { { real_T xnew [ 2 ] ; xnew [ 0 ] = ( _rtP -> P_0 [ 0 ] ) *
_rtDW -> DiscreteStateSpace_DSTATE [ 1 ] ; xnew [ 1 ] = ( _rtP -> P_0 [ 1 ] )
* _rtDW -> DiscreteStateSpace_DSTATE [ 0 ] + ( _rtP -> P_0 [ 2 ] ) * _rtDW ->
DiscreteStateSpace_DSTATE [ 1 ] ; xnew [ 1 ] += _rtP -> P_1 * _rtB -> B_0_1_0
[ 0 ] ; ( void ) memcpy ( & _rtDW -> DiscreteStateSpace_DSTATE [ 0 ] , xnew ,
sizeof ( real_T ) * 2 ) ; } ssCallAccelRunBlock ( S , 0 , 1 ,
SS_CALL_MDL_UPDATE ) ; } UNUSED_PARAMETER ( tid ) ; } static void
mdlInitializeSizes ( SimStruct * S ) { ssSetChecksumVal ( S , 0 , 3281472835U
) ; ssSetChecksumVal ( S , 1 , 2438053872U ) ; ssSetChecksumVal ( S , 2 ,
3549032683U ) ; ssSetChecksumVal ( S , 3 , 1081520770U ) ; { mxArray *
slVerStructMat = NULL ; mxArray * slStrMat = mxCreateString ( "simulink" ) ;
char slVerChar [ 10 ] ; int status = mexCallMATLAB ( 1 , & slVerStructMat , 1
, & slStrMat , "ver" ) ; if ( status == 0 ) { mxArray * slVerMat = mxGetField
( slVerStructMat , 0 , "Version" ) ; if ( slVerMat == NULL ) { status = 1 ; }
else { status = mxGetString ( slVerMat , slVerChar , 10 ) ; } }
mxDestroyArray ( slStrMat ) ; mxDestroyArray ( slVerStructMat ) ; if ( (
status == 1 ) || ( strcmp ( slVerChar , "8.2" ) != 0 ) ) { return ; } }
ssSetOptions ( S , SS_OPTION_EXCEPTION_FREE_CODE ) ; if ( ssGetSizeofDWork (
S ) != sizeof ( DW_Simulink_Xss_Com_Restricao_T ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal DWork sizes do "
"not match for accelerator mex file." ) ; } if ( ssGetSizeofGlobalBlockIO ( S
) != sizeof ( B_Simulink_Xss_Com_Restricao_T ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal BlockIO sizes do "
"not match for accelerator mex file." ) ; } { int ssSizeofParams ;
ssGetSizeofParams ( S , & ssSizeofParams ) ; if ( ssSizeofParams != sizeof (
P_Simulink_Xss_Com_Restricao_T ) ) { static char msg [ 256 ] ; sprintf ( msg
, "Unexpected error: Internal Parameters sizes do "
"not match for accelerator mex file." ) ; } } _ssSetDefaultParam ( S , (
real_T * ) & Simulink_Xss_Com_Restricao_rtDefaultP ) ; rt_InitInfAndNaN (
sizeof ( real_T ) ) ; } static void mdlInitializeSampleTimes ( SimStruct * S
) { } static void mdlTerminate ( SimStruct * S ) { }
#include "simulink.c"
