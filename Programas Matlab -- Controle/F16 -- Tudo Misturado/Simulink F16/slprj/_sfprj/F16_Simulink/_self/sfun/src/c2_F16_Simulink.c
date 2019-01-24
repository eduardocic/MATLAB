/* Include files */

#include <stddef.h>
#include "blas.h"
#include "F16_Simulink_sfun.h"
#include "c2_F16_Simulink.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "F16_Simulink_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(sfGlobalDebugInstanceStruct,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static const char * c2_debug_family_names[98] = { "Jxx", "Jyy", "Jzz", "Jxz",
  "Jxz2", "Peso", "Gd", "Massa", "Gama", "Xpq", "Xqr", "Zpq", "Ypr", "S", "B",
  "Cbar", "Xcgr", "Hx", "throatle", "elevator", "aileron", "rudder", "Xcg",
  "RtoD", "VT", "alfa", "beta", "phi", "theta", "psi", "P", "Q", "R", "Alt",
  "pow", "Mach", "Qbar", "Cpow", "T", "Cxt", "Cyt", "Czt", "Dail", "Drdr", "Clt",
  "Cmt", "Cnt", "TVT", "B2V", "Cq", "D", "Cbeta", "U", "V", "W", "Stheta",
  "Ctheta", "Sphi", "Cphi", "Spsi", "Cpsi", "Qs", "Qsb", "Rmqs", "G_ctheta",
  "Q_sphi", "Ay", "Az", "Udot", "Vdot", "Wdot", "DUM", "Roll", "Pitch", "Yaw",
  "PQ", "QR", "QHX", "T1", "T2", "T3", "S1", "S2", "S3", "S4", "S5", "S6", "S7",
  "S8", "An", "Alat", "nargin", "nargout", "x", "u", "t", "xd", "y" };

static const char * c2_b_debug_family_names[11] = { "rho0", "Tfac", "T", "rho",
  "Cps", "nargin", "nargout", "VT", "Alt", "Mach", "Qbar" };

static const char * c2_c_debug_family_names[4] = { "nargin", "nargout", "Thtl",
  "Saida" };

static const char * c2_d_debug_family_names[4] = { "nargin", "nargout", "DP",
  "Saida" };

static const char * c2_e_debug_family_names[7] = { "T", "P2", "nargin",
  "nargout", "P3", "P1", "Saida" };

static const char * c2_f_debug_family_names[21] = { "A", "B", "C", "H", "I",
  "DH", "RM", "M", "DM", "CDH", "S", "T", "Tmil", "Tidl", "Tmax", "nargin",
  "nargout", "Pow", "Altitude", "RMach", "THRUST" };

static const char * c2_g_debug_family_names[17] = { "A", "S", "K", "DA", "L",
  "M", "DE", "N", "T", "U", "V", "W", "nargin", "nargout", "alpha", "elevator",
  "CoeficienteForcaX" };

static const char * c2_h_debug_family_names[6] = { "nargin", "nargout", "beta",
  "aileron", "rudder", "CoeficienteSideForce" };

static const char * c2_i_debug_family_names[11] = { "A", "S", "K", "DA", "L",
  "nargin", "nargout", "alpha", "beta", "elevator", "CoeficienteForcaZ" };

static const char * c2_j_debug_family_names[18] = { "A", "S", "K", "DA", "L",
  "M", "DB", "N", "T", "U", "V", "W", "DUM", "nargin", "nargout", "alpha",
  "beta", "CoeficienteRollingMoment" };

static const char * c2_k_debug_family_names[17] = { "A", "S", "K", "DA", "L",
  "M", "DB", "N", "T", "U", "V", "W", "nargin", "nargout", "alpha", "beta",
  "CoeficienteRollingMomentAileron" };

static const char * c2_l_debug_family_names[17] = { "A", "S", "K", "DA", "L",
  "M", "DB", "N", "T", "U", "V", "W", "nargin", "nargout", "alpha", "beta",
  "CoeficienteRollingMomentRudder" };

static const char * c2_m_debug_family_names[17] = { "A", "S", "K", "DA", "L",
  "M", "DE", "N", "T", "U", "V", "W", "nargin", "nargout", "alpha", "elevator",
  "CoeficientePitching" };

static const char * c2_n_debug_family_names[18] = { "A", "S", "K", "DA", "L",
  "M", "DB", "N", "T", "U", "V", "W", "DUM", "nargin", "nargout", "alpha",
  "beta", "CoeficienteMomentYawing" };

static const char * c2_o_debug_family_names[17] = { "A", "S", "K", "DA", "L",
  "M", "DB", "N", "T", "U", "V", "W", "nargin", "nargout", "alpha", "beta",
  "CoeficienteYawingMomentAileron" };

static const char * c2_p_debug_family_names[17] = { "A", "S", "K", "DA", "L",
  "M", "DB", "N", "T", "U", "V", "W", "nargin", "nargout", "alpha", "beta",
  "CoeficienteYawingMomentRudder" };

static const char * c2_q_debug_family_names[11] = { "A", "S", "K", "DA", "L",
  "D", "I", "nargin", "nargout", "alpha", "DampCoeficientes" };

/* Function Declarations */
static void initialize_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance);
static void initialize_params_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance);
static void enable_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance);
static void disable_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance);
static void c2_update_debugger_state_c2_F16_Simulink
  (SFc2_F16_SimulinkInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_F16_Simulink
  (SFc2_F16_SimulinkInstanceStruct *chartInstance);
static void set_sim_state_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_st);
static void finalize_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance);
static void sf_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct *chartInstance);
static void c2_chartstep_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance);
static void initSimStructsc2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance);
static void c2_ADC(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T c2_VT,
                   real_T c2_Alt, real_T *c2_Mach, real_T *c2_Qbar);
static real_T c2_TGear(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
  c2_Thtl);
static real_T c2_PowerRate(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  real_T c2_P3, real_T c2_P1);
static real_T c2_Rtau(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_DP);
static real_T c2_Thrust(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
  c2_Pow, real_T c2_Altitude, real_T c2_RMach);
static real_T c2_Cx(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_elevator);
static real_T c2_Cy(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_beta, real_T c2_aileron, real_T c2_rudder);
static real_T c2_Cz(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_beta, real_T c2_elevator);
static real_T c2_Cl(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_beta);
static real_T c2_Dlda(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta);
static real_T c2_Dldr(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta);
static real_T c2_Cm(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_elevator);
static real_T c2_Cn(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_beta);
static real_T c2_Dnda(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta);
static real_T c2_Dndr(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta);
static void c2_Damping(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
  c2_alpha, real_T c2_DampCoeficientes[9]);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber);
static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData);
static void c2_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_y, const char_T *c2_identifier, real_T c2_b_y[2]);
static void c2_b_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[2]);
static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_c_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_xd, const char_T *c2_identifier, real_T c2_y[13]);
static void c2_d_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[13]);
static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static real_T c2_e_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_f_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[9]);
static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_f_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_g_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[36]);
static void c2_e_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_g_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_h_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[60]);
static void c2_f_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_h_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_i_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[12]);
static void c2_g_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_i_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_j_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[84]);
static void c2_h_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_j_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static void c2_k_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[108]);
static void c2_i_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static void c2_info_helper(const mxArray **c2_info);
static const mxArray *c2_emlrt_marshallOut(char * c2_u);
static const mxArray *c2_b_emlrt_marshallOut(uint32_T c2_u);
static void c2_b_info_helper(const mxArray **c2_info);
static void c2_eml_scalar_eg(SFc2_F16_SimulinkInstanceStruct *chartInstance);
static void c2_eml_error(SFc2_F16_SimulinkInstanceStruct *chartInstance);
static void c2_b_eml_error(SFc2_F16_SimulinkInstanceStruct *chartInstance);
static const mxArray *c2_k_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static int32_T c2_l_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_j_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static uint8_T c2_m_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_F16_Simulink, const char_T
  *c2_identifier);
static uint8_T c2_n_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info(SFc2_F16_SimulinkInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance)
{
  chartInstance->c2_sfEvent = CALL_EVENT;
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c2_is_active_c2_F16_Simulink = 0U;
}

static void initialize_params_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance)
{
}

static void enable_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void c2_update_debugger_state_c2_F16_Simulink
  (SFc2_F16_SimulinkInstanceStruct *chartInstance)
{
}

static const mxArray *get_sim_state_c2_F16_Simulink
  (SFc2_F16_SimulinkInstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  int32_T c2_i0;
  real_T c2_u[13];
  const mxArray *c2_b_y = NULL;
  int32_T c2_i1;
  real_T c2_b_u[2];
  const mxArray *c2_c_y = NULL;
  uint8_T c2_hoistedGlobal;
  uint8_T c2_c_u;
  const mxArray *c2_d_y = NULL;
  real_T (*c2_e_y)[2];
  real_T (*c2_xd)[13];
  c2_e_y = (real_T (*)[2])ssGetOutputPortSignal(chartInstance->S, 2);
  c2_xd = (real_T (*)[13])ssGetOutputPortSignal(chartInstance->S, 1);
  c2_st = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellarray(3), FALSE);
  for (c2_i0 = 0; c2_i0 < 13; c2_i0++) {
    c2_u[c2_i0] = (*c2_xd)[c2_i0];
  }

  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 13), FALSE);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  for (c2_i1 = 0; c2_i1 < 2; c2_i1++) {
    c2_b_u[c2_i1] = (*c2_e_y)[c2_i1];
  }

  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", c2_b_u, 0, 0U, 1U, 0U, 1, 2), FALSE);
  sf_mex_setcell(c2_y, 1, c2_c_y);
  c2_hoistedGlobal = chartInstance->c2_is_active_c2_F16_Simulink;
  c2_c_u = c2_hoistedGlobal;
  c2_d_y = NULL;
  sf_mex_assign(&c2_d_y, sf_mex_create("y", &c2_c_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c2_y, 2, c2_d_y);
  sf_mex_assign(&c2_st, c2_y, FALSE);
  return c2_st;
}

static void set_sim_state_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_st)
{
  const mxArray *c2_u;
  real_T c2_dv0[13];
  int32_T c2_i2;
  real_T c2_dv1[2];
  int32_T c2_i3;
  real_T (*c2_xd)[13];
  real_T (*c2_y)[2];
  c2_y = (real_T (*)[2])ssGetOutputPortSignal(chartInstance->S, 2);
  c2_xd = (real_T (*)[13])ssGetOutputPortSignal(chartInstance->S, 1);
  chartInstance->c2_doneDoubleBufferReInit = TRUE;
  c2_u = sf_mex_dup(c2_st);
  c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)), "xd",
                        c2_dv0);
  for (c2_i2 = 0; c2_i2 < 13; c2_i2++) {
    (*c2_xd)[c2_i2] = c2_dv0[c2_i2];
  }

  c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 1)), "y",
                      c2_dv1);
  for (c2_i3 = 0; c2_i3 < 2; c2_i3++) {
    (*c2_y)[c2_i3] = c2_dv1[c2_i3];
  }

  chartInstance->c2_is_active_c2_F16_Simulink = c2_m_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 2)),
     "is_active_c2_F16_Simulink");
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_F16_Simulink(chartInstance);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance)
{
}

static void sf_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct *chartInstance)
{
  int32_T c2_i4;
  int32_T c2_i5;
  int32_T c2_i6;
  int32_T c2_i7;
  real_T *c2_t;
  real_T (*c2_y)[2];
  real_T (*c2_u)[5];
  real_T (*c2_xd)[13];
  real_T (*c2_x)[13];
  c2_t = (real_T *)ssGetInputPortSignal(chartInstance->S, 2);
  c2_y = (real_T (*)[2])ssGetOutputPortSignal(chartInstance->S, 2);
  c2_u = (real_T (*)[5])ssGetInputPortSignal(chartInstance->S, 1);
  c2_xd = (real_T (*)[13])ssGetOutputPortSignal(chartInstance->S, 1);
  c2_x = (real_T (*)[13])ssGetInputPortSignal(chartInstance->S, 0);
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  for (c2_i4 = 0; c2_i4 < 13; c2_i4++) {
    _SFD_DATA_RANGE_CHECK((*c2_x)[c2_i4], 0U);
  }

  for (c2_i5 = 0; c2_i5 < 13; c2_i5++) {
    _SFD_DATA_RANGE_CHECK((*c2_xd)[c2_i5], 1U);
  }

  for (c2_i6 = 0; c2_i6 < 5; c2_i6++) {
    _SFD_DATA_RANGE_CHECK((*c2_u)[c2_i6], 2U);
  }

  for (c2_i7 = 0; c2_i7 < 2; c2_i7++) {
    _SFD_DATA_RANGE_CHECK((*c2_y)[c2_i7], 3U);
  }

  _SFD_DATA_RANGE_CHECK(*c2_t, 4U);
  chartInstance->c2_sfEvent = CALL_EVENT;
  c2_chartstep_c2_F16_Simulink(chartInstance);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_F16_SimulinkMachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void c2_chartstep_c2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance)
{
  real_T c2_hoistedGlobal;
  int32_T c2_i8;
  real_T c2_x[13];
  int32_T c2_i9;
  real_T c2_u[5];
  real_T c2_t;
  uint32_T c2_debug_family_var_map[98];
  real_T c2_Jxx;
  real_T c2_Jyy;
  real_T c2_Jzz;
  real_T c2_Jxz;
  real_T c2_Jxz2;
  real_T c2_Peso;
  real_T c2_Gd;
  real_T c2_Massa;
  real_T c2_Gama;
  real_T c2_Xpq;
  real_T c2_Xqr;
  real_T c2_Zpq;
  real_T c2_Ypr;
  real_T c2_S;
  real_T c2_B;
  real_T c2_Cbar;
  real_T c2_Xcgr;
  real_T c2_Hx;
  real_T c2_throatle;
  real_T c2_elevator;
  real_T c2_aileron;
  real_T c2_rudder;
  real_T c2_Xcg;
  real_T c2_RtoD;
  real_T c2_VT;
  real_T c2_alfa;
  real_T c2_beta;
  real_T c2_phi;
  real_T c2_theta;
  real_T c2_psi;
  real_T c2_P;
  real_T c2_Q;
  real_T c2_R;
  real_T c2_Alt;
  real_T c2_pow;
  real_T c2_Mach;
  real_T c2_Qbar;
  real_T c2_Cpow;
  real_T c2_T;
  real_T c2_Cxt;
  real_T c2_Cyt;
  real_T c2_Czt;
  real_T c2_Dail;
  real_T c2_Drdr;
  real_T c2_Clt;
  real_T c2_Cmt;
  real_T c2_Cnt;
  real_T c2_TVT;
  real_T c2_B2V;
  real_T c2_Cq;
  real_T c2_D[9];
  real_T c2_Cbeta;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_Stheta;
  real_T c2_Ctheta;
  real_T c2_Sphi;
  real_T c2_Cphi;
  real_T c2_Spsi;
  real_T c2_Cpsi;
  real_T c2_Qs;
  real_T c2_Qsb;
  real_T c2_Rmqs;
  real_T c2_G_ctheta;
  real_T c2_Q_sphi;
  real_T c2_Ay;
  real_T c2_Az;
  real_T c2_Udot;
  real_T c2_Vdot;
  real_T c2_Wdot;
  real_T c2_DUM;
  real_T c2_Roll;
  real_T c2_Pitch;
  real_T c2_Yaw;
  real_T c2_PQ;
  real_T c2_QR;
  real_T c2_QHX;
  real_T c2_T1;
  real_T c2_T2;
  real_T c2_T3;
  real_T c2_S1;
  real_T c2_S2;
  real_T c2_S3;
  real_T c2_S4;
  real_T c2_S5;
  real_T c2_S6;
  real_T c2_S7;
  real_T c2_S8;
  real_T c2_An;
  real_T c2_Alat;
  real_T c2_nargin = 3.0;
  real_T c2_nargout = 2.0;
  real_T c2_xd[13];
  real_T c2_y[2];
  int32_T c2_i10;
  int32_T c2_i11;
  real_T c2_a;
  real_T c2_b_a;
  real_T c2_b_Qbar;
  real_T c2_b_Mach;
  real_T c2_A;
  real_T c2_b_x;
  real_T c2_c_x;
  real_T c2_b_A;
  real_T c2_d_x;
  real_T c2_e_x;
  real_T c2_c_a;
  real_T c2_b;
  real_T c2_b_y;
  real_T c2_d_a;
  real_T c2_b_b;
  real_T c2_c_y;
  real_T c2_e_a;
  real_T c2_c_b;
  real_T c2_d_y;
  real_T c2_f_a;
  real_T c2_d_b;
  real_T c2_e_y;
  real_T c2_b_B;
  real_T c2_f_y;
  real_T c2_g_y;
  real_T c2_e_b;
  real_T c2_f_b;
  real_T c2_h_y;
  real_T c2_g_a;
  real_T c2_g_b;
  real_T c2_dv2[9];
  int32_T c2_i12;
  real_T c2_h_a;
  real_T c2_h_b;
  real_T c2_i_y;
  real_T c2_i_a;
  real_T c2_i_b;
  real_T c2_j_y;
  real_T c2_j_a;
  real_T c2_j_b;
  real_T c2_k_y;
  real_T c2_k_a;
  real_T c2_k_b;
  real_T c2_l_y;
  real_T c2_l_a;
  real_T c2_l_b;
  real_T c2_m_y;
  real_T c2_m_a;
  real_T c2_m_b;
  real_T c2_n_y;
  real_T c2_n_a;
  real_T c2_n_b;
  real_T c2_o_y;
  real_T c2_o_a;
  real_T c2_o_b;
  real_T c2_p_y;
  real_T c2_p_a;
  real_T c2_p_b;
  real_T c2_q_y;
  real_T c2_q_a;
  real_T c2_q_b;
  real_T c2_r_y;
  real_T c2_r_a;
  real_T c2_r_b;
  real_T c2_s_y;
  real_T c2_s_a;
  real_T c2_s_b;
  real_T c2_t_y;
  real_T c2_t_a;
  real_T c2_t_b;
  real_T c2_u_y;
  real_T c2_u_a;
  real_T c2_u_b;
  real_T c2_v_y;
  real_T c2_v_a;
  real_T c2_w_y;
  real_T c2_c_A;
  real_T c2_f_x;
  real_T c2_g_x;
  real_T c2_x_y;
  real_T c2_h_x;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_k_x;
  real_T c2_w_a;
  real_T c2_v_b;
  real_T c2_y_y;
  real_T c2_x_a;
  real_T c2_w_b;
  real_T c2_l_x;
  real_T c2_m_x;
  real_T c2_y_a;
  real_T c2_x_b;
  real_T c2_n_x;
  real_T c2_o_x;
  real_T c2_ab_a;
  real_T c2_y_b;
  real_T c2_ab_y;
  real_T c2_bb_a;
  real_T c2_ab_b;
  real_T c2_p_x;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_s_x;
  real_T c2_t_x;
  real_T c2_u_x;
  real_T c2_v_x;
  real_T c2_w_x;
  real_T c2_x_x;
  real_T c2_y_x;
  real_T c2_ab_x;
  real_T c2_bb_x;
  real_T c2_cb_a;
  real_T c2_db_a;
  real_T c2_d_A;
  real_T c2_cb_x;
  real_T c2_db_x;
  real_T c2_bb_b;
  real_T c2_eb_a;
  real_T c2_cb_b;
  real_T c2_fb_a;
  real_T c2_db_b;
  real_T c2_gb_a;
  real_T c2_eb_b;
  real_T c2_hb_a;
  real_T c2_fb_b;
  real_T c2_bb_y;
  real_T c2_ib_a;
  real_T c2_gb_b;
  real_T c2_cb_y;
  real_T c2_hb_b;
  real_T c2_db_y;
  real_T c2_jb_a;
  real_T c2_ib_b;
  real_T c2_eb_y;
  real_T c2_e_A;
  real_T c2_eb_x;
  real_T c2_fb_x;
  real_T c2_fb_y;
  real_T c2_kb_a;
  real_T c2_jb_b;
  real_T c2_gb_y;
  real_T c2_lb_a;
  real_T c2_kb_b;
  real_T c2_hb_y;
  real_T c2_mb_a;
  real_T c2_lb_b;
  real_T c2_ib_y;
  real_T c2_nb_a;
  real_T c2_mb_b;
  real_T c2_jb_y;
  real_T c2_ob_a;
  real_T c2_nb_b;
  real_T c2_kb_y;
  real_T c2_pb_a;
  real_T c2_ob_b;
  real_T c2_lb_y;
  real_T c2_qb_a;
  real_T c2_pb_b;
  real_T c2_mb_y;
  real_T c2_rb_a;
  real_T c2_qb_b;
  real_T c2_nb_y;
  real_T c2_sb_a;
  real_T c2_rb_b;
  real_T c2_ob_y;
  real_T c2_tb_a;
  real_T c2_sb_b;
  real_T c2_pb_y;
  real_T c2_ub_a;
  real_T c2_tb_b;
  real_T c2_qb_y;
  real_T c2_f_A;
  real_T c2_c_B;
  real_T c2_gb_x;
  real_T c2_rb_y;
  real_T c2_hb_x;
  real_T c2_sb_y;
  real_T c2_tb_y;
  real_T c2_vb_a;
  real_T c2_ub_b;
  real_T c2_ub_y;
  real_T c2_wb_a;
  real_T c2_vb_b;
  real_T c2_vb_y;
  real_T c2_g_A;
  real_T c2_d_B;
  real_T c2_ib_x;
  real_T c2_wb_y;
  real_T c2_jb_x;
  real_T c2_xb_y;
  real_T c2_yb_y;
  real_T c2_xb_a;
  real_T c2_wb_b;
  real_T c2_ac_y;
  real_T c2_yb_a;
  real_T c2_xb_b;
  real_T c2_bc_y;
  real_T c2_ac_a;
  real_T c2_yb_b;
  real_T c2_cc_y;
  real_T c2_h_A;
  real_T c2_e_B;
  real_T c2_kb_x;
  real_T c2_dc_y;
  real_T c2_lb_x;
  real_T c2_ec_y;
  real_T c2_fc_y;
  real_T c2_i_A;
  real_T c2_f_B;
  real_T c2_mb_x;
  real_T c2_gc_y;
  real_T c2_nb_x;
  real_T c2_hc_y;
  real_T c2_ic_y;
  real_T c2_bc_a;
  real_T c2_ac_b;
  real_T c2_jc_y;
  real_T c2_cc_a;
  real_T c2_bc_b;
  real_T c2_kc_y;
  real_T c2_dc_a;
  real_T c2_cc_b;
  real_T c2_lc_y;
  real_T c2_ec_a;
  real_T c2_dc_b;
  real_T c2_mc_y;
  real_T c2_fc_a;
  real_T c2_ec_b;
  real_T c2_nc_y;
  real_T c2_j_A;
  real_T c2_g_B;
  real_T c2_ob_x;
  real_T c2_oc_y;
  real_T c2_pb_x;
  real_T c2_pc_y;
  real_T c2_qc_y;
  real_T c2_gc_a;
  real_T c2_fc_b;
  real_T c2_hc_a;
  real_T c2_rc_y;
  real_T c2_ic_a;
  real_T c2_gc_b;
  real_T c2_jc_a;
  real_T c2_hc_b;
  real_T c2_kc_a;
  real_T c2_ic_b;
  real_T c2_lc_a;
  real_T c2_jc_b;
  real_T c2_mc_a;
  real_T c2_kc_b;
  real_T c2_sc_y;
  real_T c2_lc_b;
  real_T c2_tc_y;
  real_T c2_mc_b;
  real_T c2_uc_y;
  real_T c2_nc_b;
  real_T c2_vc_y;
  real_T c2_k_A;
  real_T c2_qb_x;
  real_T c2_rb_x;
  real_T c2_wc_y;
  real_T c2_oc_b;
  real_T c2_xc_y;
  real_T c2_nc_a;
  real_T c2_pc_b;
  real_T c2_yc_y;
  real_T c2_oc_a;
  real_T c2_qc_b;
  real_T c2_ad_y;
  real_T c2_pc_a;
  real_T c2_rc_b;
  real_T c2_bd_y;
  real_T c2_sc_b;
  real_T c2_cd_y;
  real_T c2_qc_a;
  real_T c2_dd_y;
  real_T c2_l_A;
  real_T c2_sb_x;
  real_T c2_tb_x;
  real_T c2_ed_y;
  real_T c2_tc_b;
  real_T c2_fd_y;
  real_T c2_uc_b;
  real_T c2_gd_y;
  real_T c2_vc_b;
  real_T c2_hd_y;
  real_T c2_wc_b;
  real_T c2_id_y;
  real_T c2_m_A;
  real_T c2_ub_x;
  real_T c2_vb_x;
  real_T c2_jd_y;
  real_T c2_rc_a;
  real_T c2_xc_b;
  real_T c2_sc_a;
  real_T c2_yc_b;
  real_T c2_tc_a;
  real_T c2_ad_b;
  real_T c2_uc_a;
  real_T c2_bd_b;
  real_T c2_vc_a;
  real_T c2_cd_b;
  real_T c2_wc_a;
  real_T c2_dd_b;
  real_T c2_kd_y;
  real_T c2_xc_a;
  real_T c2_ed_b;
  real_T c2_ld_y;
  real_T c2_yc_a;
  real_T c2_fd_b;
  real_T c2_md_y;
  real_T c2_ad_a;
  real_T c2_gd_b;
  real_T c2_nd_y;
  real_T c2_bd_a;
  real_T c2_hd_b;
  real_T c2_cd_a;
  real_T c2_id_b;
  real_T c2_od_y;
  real_T c2_dd_a;
  real_T c2_jd_b;
  real_T c2_pd_y;
  real_T c2_ed_a;
  real_T c2_kd_b;
  real_T c2_fd_a;
  real_T c2_ld_b;
  real_T c2_qd_y;
  real_T c2_gd_a;
  real_T c2_md_b;
  real_T c2_rd_y;
  real_T c2_hd_a;
  real_T c2_nd_b;
  real_T c2_sd_y;
  real_T c2_id_a;
  real_T c2_od_b;
  real_T c2_td_y;
  real_T c2_jd_a;
  real_T c2_pd_b;
  real_T c2_ud_y;
  real_T c2_kd_a;
  real_T c2_qd_b;
  real_T c2_vd_y;
  real_T c2_ld_a;
  real_T c2_rd_b;
  real_T c2_wd_y;
  real_T c2_md_a;
  real_T c2_sd_b;
  real_T c2_xd_y;
  real_T c2_nd_a;
  real_T c2_td_b;
  real_T c2_yd_y;
  real_T c2_n_A;
  real_T c2_wb_x;
  real_T c2_xb_x;
  real_T c2_o_A;
  real_T c2_yb_x;
  real_T c2_ac_x;
  int32_T c2_i13;
  int32_T c2_i14;
  real_T *c2_b_t;
  real_T (*c2_b_xd)[13];
  real_T (*c2_ae_y)[2];
  real_T (*c2_b_u)[5];
  real_T (*c2_bc_x)[13];
  c2_b_t = (real_T *)ssGetInputPortSignal(chartInstance->S, 2);
  c2_ae_y = (real_T (*)[2])ssGetOutputPortSignal(chartInstance->S, 2);
  c2_b_u = (real_T (*)[5])ssGetInputPortSignal(chartInstance->S, 1);
  c2_b_xd = (real_T (*)[13])ssGetOutputPortSignal(chartInstance->S, 1);
  c2_bc_x = (real_T (*)[13])ssGetInputPortSignal(chartInstance->S, 0);
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
  c2_hoistedGlobal = *c2_b_t;
  for (c2_i8 = 0; c2_i8 < 13; c2_i8++) {
    c2_x[c2_i8] = (*c2_bc_x)[c2_i8];
  }

  for (c2_i9 = 0; c2_i9 < 5; c2_i9++) {
    c2_u[c2_i9] = (*c2_b_u)[c2_i9];
  }

  c2_t = c2_hoistedGlobal;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 98U, 98U, c2_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Jxx, 0U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Jyy, 1U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Jzz, 2U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Jxz, 3U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Jxz2, 4U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Peso, 5U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Gd, 6U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Massa, 7U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Gama, 8U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Xpq, 9U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Xqr, 10U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Zpq, 11U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Ypr, 12U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_S, 13U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_B, 14U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Cbar, 15U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Xcgr, 16U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_Hx, 17U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_throatle, 18U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_elevator, 19U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_aileron, 20U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_rudder, 21U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Xcg, 22U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_RtoD, 23U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_VT, 24U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alfa, 25U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 26U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_phi, 27U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_theta, 28U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_psi, 29U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_P, 30U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Q, 31U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_R, 32U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Alt, 33U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_pow, 34U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Mach, 35U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Qbar, 36U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cpow, 37U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 38U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cxt, 39U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cyt, 40U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Czt, 41U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Dail, 42U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Drdr, 43U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Clt, 44U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cmt, 45U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cnt, 46U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_TVT, 47U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_B2V, 48U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cq, 49U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_D, 50U, c2_e_sf_marshallOut,
    c2_d_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cbeta, 51U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 52U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 53U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 54U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Stheta, 55U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Ctheta, 56U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Sphi, 57U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cphi, 58U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Spsi, 59U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cpsi, 60U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Qs, 61U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Qsb, 62U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Rmqs, 63U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_G_ctheta, 64U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Q_sphi, 65U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Ay, 66U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Az, 67U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Udot, 68U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Vdot, 69U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Wdot, 70U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DUM, 71U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Roll, 72U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Pitch, 73U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Yaw, 74U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_PQ, 75U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_QR, 76U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_QHX, 77U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T1, 78U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T2, 79U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T3, 80U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S1, 81U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S2, 82U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S3, 83U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S4, 84U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S5, 85U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S6, 86U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S7, 87U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S8, 88U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_An, 89U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Alat, 90U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 91U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 92U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_x, 93U, c2_b_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(c2_u, 94U, c2_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_t, 95U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_xd, 96U, c2_b_sf_marshallOut,
    c2_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_y, 97U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 3);
  for (c2_i10 = 0; c2_i10 < 13; c2_i10++) {
    c2_xd[c2_i10] = 0.0;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 4);
  for (c2_i11 = 0; c2_i11 < 2; c2_i11++) {
    c2_y[c2_i11] = 0.0;
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 7);
  c2_Jxx = 9496.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 8);
  c2_Jyy = 55814.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 9);
  c2_Jzz = 63100.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 10);
  c2_Jxz = 982.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 11);
  c2_Jxz2 = 964324.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 12);
  c2_Peso = 20500.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 13);
  c2_Gd = 32.17;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 14);
  c2_Massa = 637.23966428349388;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 20);
  c2_Gama = 5.98233276E+8;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 21);
  c2_Xpq = 1.6479924E+7;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 22);
  c2_Xqr = 4.60710924E+8;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 23);
  c2_Zpq = -4.38871404E+8;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 24);
  c2_Ypr = 53604.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 31);
  c2_S = 300.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 32);
  c2_B = 30.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 33);
  c2_Cbar = 11.32;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 34);
  c2_Xcgr = 0.35;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 35);
  c2_Hx = 160.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 39);
  c2_throatle = c2_u[0];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 40);
  c2_elevator = c2_u[1];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 41);
  c2_aileron = c2_u[2];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 42);
  c2_rudder = c2_u[3];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 43);
  c2_Xcg = c2_u[4];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 47);
  c2_RtoD = 57.29578;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 52);
  c2_VT = c2_x[0];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 53);
  c2_a = c2_x[1];
  c2_alfa = c2_a * 57.29578;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 54);
  c2_b_a = c2_x[2];
  c2_beta = c2_b_a * 57.29578;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 55);
  c2_phi = c2_x[3];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 56);
  c2_theta = c2_x[4];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 57);
  c2_psi = c2_x[5];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 58);
  c2_P = c2_x[6];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 59);
  c2_Q = c2_x[7];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 60);
  c2_R = c2_x[8];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 61);
  c2_Alt = c2_x[11];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 62);
  c2_pow = c2_x[12];
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 68);
  c2_ADC(chartInstance, c2_VT, c2_Alt, &c2_b_Mach, &c2_b_Qbar);
  c2_Mach = c2_b_Mach;
  c2_Qbar = c2_b_Qbar;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 70);
  c2_Cpow = c2_TGear(chartInstance, c2_throatle);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 71);
  c2_xd[12] = c2_PowerRate(chartInstance, c2_pow, c2_Cpow);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 72);
  c2_T = c2_Thrust(chartInstance, c2_pow, c2_Alt, c2_Mach);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 87);
  c2_Cxt = c2_Cx(chartInstance, c2_alfa, c2_elevator);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 88);
  c2_Cyt = c2_Cy(chartInstance, c2_beta, c2_aileron, c2_rudder);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 89);
  c2_Czt = c2_Cz(chartInstance, c2_alfa, c2_beta, c2_elevator);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 91);
  c2_A = c2_aileron;
  c2_b_x = c2_A;
  c2_c_x = c2_b_x;
  c2_Dail = c2_c_x / 20.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 92);
  c2_b_A = c2_rudder;
  c2_d_x = c2_b_A;
  c2_e_x = c2_d_x;
  c2_Drdr = c2_e_x / 30.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 94);
  c2_c_a = c2_Dlda(chartInstance, c2_alfa, c2_beta);
  c2_b = c2_Dail;
  c2_b_y = c2_c_a * c2_b;
  c2_d_a = c2_Dldr(chartInstance, c2_alfa, c2_beta);
  c2_b_b = c2_Drdr;
  c2_c_y = c2_d_a * c2_b_b;
  c2_Clt = (c2_Cl(chartInstance, c2_alfa, c2_beta) + c2_b_y) + c2_c_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 95);
  c2_Cmt = c2_Cm(chartInstance, c2_alfa, c2_elevator);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 96);
  c2_e_a = c2_Dnda(chartInstance, c2_alfa, c2_beta);
  c2_c_b = c2_Dail;
  c2_d_y = c2_e_a * c2_c_b;
  c2_f_a = c2_Dndr(chartInstance, c2_alfa, c2_beta);
  c2_d_b = c2_Drdr;
  c2_e_y = c2_f_a * c2_d_b;
  c2_Cnt = (c2_Cn(chartInstance, c2_alfa, c2_beta) + c2_d_y) + c2_e_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 101);
  c2_b_B = c2_VT;
  c2_f_y = c2_b_B;
  c2_g_y = c2_f_y;
  c2_TVT = 0.5 / c2_g_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 102);
  c2_e_b = c2_TVT;
  c2_B2V = 30.0 * c2_e_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 103);
  c2_f_b = c2_Q;
  c2_h_y = 11.32 * c2_f_b;
  c2_g_a = c2_h_y;
  c2_g_b = c2_TVT;
  c2_Cq = c2_g_a * c2_g_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 104);
  c2_Damping(chartInstance, c2_alfa, c2_dv2);
  for (c2_i12 = 0; c2_i12 < 9; c2_i12++) {
    c2_D[c2_i12] = c2_dv2[c2_i12];
  }

  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 111);
  c2_h_a = c2_Cq;
  c2_h_b = c2_D[0];
  c2_i_y = c2_h_a * c2_h_b;
  c2_Cxt += c2_i_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 112);
  c2_i_a = c2_D[1];
  c2_i_b = c2_R;
  c2_j_y = c2_i_a * c2_i_b;
  c2_j_a = c2_D[2];
  c2_j_b = c2_P;
  c2_k_y = c2_j_a * c2_j_b;
  c2_k_a = c2_B2V;
  c2_k_b = c2_j_y + c2_k_y;
  c2_l_y = c2_k_a * c2_k_b;
  c2_Cyt += c2_l_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 113);
  c2_l_a = c2_Cq;
  c2_l_b = c2_D[3];
  c2_m_y = c2_l_a * c2_l_b;
  c2_Czt += c2_m_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 114);
  c2_m_a = c2_D[4];
  c2_m_b = c2_R;
  c2_n_y = c2_m_a * c2_m_b;
  c2_n_a = c2_D[5];
  c2_n_b = c2_P;
  c2_o_y = c2_n_a * c2_n_b;
  c2_o_a = c2_B2V;
  c2_o_b = c2_n_y + c2_o_y;
  c2_p_y = c2_o_a * c2_o_b;
  c2_Clt += c2_p_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 115);
  c2_p_a = c2_Cq;
  c2_p_b = c2_D[6];
  c2_q_y = c2_p_a * c2_p_b;
  c2_q_a = c2_Czt;
  c2_q_b = c2_Xcgr - c2_Xcg;
  c2_r_y = c2_q_a * c2_q_b;
  c2_Cmt = (c2_Cmt + c2_q_y) + c2_r_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 116);
  c2_r_a = c2_D[7];
  c2_r_b = c2_R;
  c2_s_y = c2_r_a * c2_r_b;
  c2_s_a = c2_D[8];
  c2_s_b = c2_P;
  c2_t_y = c2_s_a * c2_s_b;
  c2_t_a = c2_B2V;
  c2_t_b = c2_s_y + c2_t_y;
  c2_u_y = c2_t_a * c2_t_b;
  c2_u_a = c2_Cyt;
  c2_u_b = c2_Xcgr - c2_Xcg;
  c2_v_y = c2_u_a * c2_u_b;
  c2_v_a = c2_v_y;
  c2_w_y = c2_v_a * 11.32;
  c2_c_A = c2_w_y;
  c2_f_x = c2_c_A;
  c2_g_x = c2_f_x;
  c2_x_y = c2_g_x / 30.0;
  c2_Cnt = (c2_Cnt + c2_u_y) - c2_x_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 121);
  c2_h_x = c2_x[2];
  c2_Cbeta = c2_h_x;
  c2_i_x = c2_Cbeta;
  c2_Cbeta = c2_i_x;
  c2_Cbeta = muDoubleScalarCos(c2_Cbeta);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 122);
  c2_j_x = c2_x[1];
  c2_k_x = c2_j_x;
  c2_k_x = muDoubleScalarCos(c2_k_x);
  c2_w_a = c2_VT;
  c2_v_b = c2_k_x;
  c2_y_y = c2_w_a * c2_v_b;
  c2_x_a = c2_y_y;
  c2_w_b = c2_Cbeta;
  c2_U = c2_x_a * c2_w_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 123);
  c2_l_x = c2_x[2];
  c2_m_x = c2_l_x;
  c2_m_x = muDoubleScalarSin(c2_m_x);
  c2_y_a = c2_VT;
  c2_x_b = c2_m_x;
  c2_V = c2_y_a * c2_x_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 124);
  c2_n_x = c2_x[1];
  c2_o_x = c2_n_x;
  c2_o_x = muDoubleScalarSin(c2_o_x);
  c2_ab_a = c2_VT;
  c2_y_b = c2_o_x;
  c2_ab_y = c2_ab_a * c2_y_b;
  c2_bb_a = c2_ab_y;
  c2_ab_b = c2_Cbeta;
  c2_W = c2_bb_a * c2_ab_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 126);
  c2_p_x = c2_theta;
  c2_Stheta = c2_p_x;
  c2_q_x = c2_Stheta;
  c2_Stheta = c2_q_x;
  c2_Stheta = muDoubleScalarSin(c2_Stheta);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, MAX_int8_T);
  c2_r_x = c2_theta;
  c2_Ctheta = c2_r_x;
  c2_s_x = c2_Ctheta;
  c2_Ctheta = c2_s_x;
  c2_Ctheta = muDoubleScalarCos(c2_Ctheta);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 128U);
  c2_t_x = c2_phi;
  c2_Sphi = c2_t_x;
  c2_u_x = c2_Sphi;
  c2_Sphi = c2_u_x;
  c2_Sphi = muDoubleScalarSin(c2_Sphi);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 129U);
  c2_v_x = c2_phi;
  c2_Cphi = c2_v_x;
  c2_w_x = c2_Cphi;
  c2_Cphi = c2_w_x;
  c2_Cphi = muDoubleScalarCos(c2_Cphi);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 130U);
  c2_x_x = c2_psi;
  c2_Spsi = c2_x_x;
  c2_y_x = c2_Spsi;
  c2_Spsi = c2_y_x;
  c2_Spsi = muDoubleScalarSin(c2_Spsi);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 131U);
  c2_ab_x = c2_psi;
  c2_Cpsi = c2_ab_x;
  c2_bb_x = c2_Cpsi;
  c2_Cpsi = c2_bb_x;
  c2_Cpsi = muDoubleScalarCos(c2_Cpsi);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 132U);
  c2_cb_a = c2_Qbar;
  c2_Qs = c2_cb_a * 300.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 133U);
  c2_db_a = c2_Qs;
  c2_Qsb = c2_db_a * 30.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 134U);
  c2_d_A = c2_Qs;
  c2_cb_x = c2_d_A;
  c2_db_x = c2_cb_x;
  c2_Rmqs = c2_db_x / 637.23966428349388;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 135U);
  c2_bb_b = c2_Ctheta;
  c2_G_ctheta = 32.17 * c2_bb_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 136U);
  c2_eb_a = c2_Q;
  c2_cb_b = c2_Sphi;
  c2_Q_sphi = c2_eb_a * c2_cb_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 137U);
  c2_fb_a = c2_Rmqs;
  c2_db_b = c2_Cyt;
  c2_Ay = c2_fb_a * c2_db_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 138U);
  c2_gb_a = c2_Rmqs;
  c2_eb_b = c2_Czt;
  c2_Az = c2_gb_a * c2_eb_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 144U);
  c2_hb_a = c2_R;
  c2_fb_b = c2_V;
  c2_bb_y = c2_hb_a * c2_fb_b;
  c2_ib_a = c2_Q;
  c2_gb_b = c2_W;
  c2_cb_y = c2_ib_a * c2_gb_b;
  c2_hb_b = c2_Stheta;
  c2_db_y = 32.17 * c2_hb_b;
  c2_jb_a = c2_Qs;
  c2_ib_b = c2_Cxt;
  c2_eb_y = c2_jb_a * c2_ib_b;
  c2_e_A = c2_eb_y + c2_T;
  c2_eb_x = c2_e_A;
  c2_fb_x = c2_eb_x;
  c2_fb_y = c2_fb_x / 637.23966428349388;
  c2_Udot = ((c2_bb_y - c2_cb_y) - c2_db_y) + c2_fb_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 145U);
  c2_kb_a = c2_P;
  c2_jb_b = c2_W;
  c2_gb_y = c2_kb_a * c2_jb_b;
  c2_lb_a = c2_R;
  c2_kb_b = c2_U;
  c2_hb_y = c2_lb_a * c2_kb_b;
  c2_mb_a = c2_G_ctheta;
  c2_lb_b = c2_Sphi;
  c2_ib_y = c2_mb_a * c2_lb_b;
  c2_Vdot = ((c2_gb_y - c2_hb_y) + c2_ib_y) + c2_Ay;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 146U);
  c2_nb_a = c2_Q;
  c2_mb_b = c2_U;
  c2_jb_y = c2_nb_a * c2_mb_b;
  c2_ob_a = c2_P;
  c2_nb_b = c2_V;
  c2_kb_y = c2_ob_a * c2_nb_b;
  c2_pb_a = c2_G_ctheta;
  c2_ob_b = c2_Cphi;
  c2_lb_y = c2_pb_a * c2_ob_b;
  c2_Wdot = ((c2_jb_y - c2_kb_y) + c2_lb_y) + c2_Az;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 147U);
  c2_qb_a = c2_U;
  c2_pb_b = c2_U;
  c2_mb_y = c2_qb_a * c2_pb_b;
  c2_rb_a = c2_W;
  c2_qb_b = c2_W;
  c2_nb_y = c2_rb_a * c2_qb_b;
  c2_DUM = c2_mb_y + c2_nb_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 149U);
  c2_sb_a = c2_U;
  c2_rb_b = c2_Udot;
  c2_ob_y = c2_sb_a * c2_rb_b;
  c2_tb_a = c2_V;
  c2_sb_b = c2_Vdot;
  c2_pb_y = c2_tb_a * c2_sb_b;
  c2_ub_a = c2_W;
  c2_tb_b = c2_Wdot;
  c2_qb_y = c2_ub_a * c2_tb_b;
  c2_f_A = (c2_ob_y + c2_pb_y) + c2_qb_y;
  c2_c_B = c2_VT;
  c2_gb_x = c2_f_A;
  c2_rb_y = c2_c_B;
  c2_hb_x = c2_gb_x;
  c2_sb_y = c2_rb_y;
  c2_tb_y = c2_hb_x / c2_sb_y;
  c2_xd[0] = c2_tb_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 150U);
  c2_vb_a = c2_U;
  c2_ub_b = c2_Wdot;
  c2_ub_y = c2_vb_a * c2_ub_b;
  c2_wb_a = c2_W;
  c2_vb_b = c2_Udot;
  c2_vb_y = c2_wb_a * c2_vb_b;
  c2_g_A = c2_ub_y - c2_vb_y;
  c2_d_B = c2_DUM;
  c2_ib_x = c2_g_A;
  c2_wb_y = c2_d_B;
  c2_jb_x = c2_ib_x;
  c2_xb_y = c2_wb_y;
  c2_yb_y = c2_jb_x / c2_xb_y;
  c2_xd[1] = c2_yb_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 151U);
  c2_xb_a = c2_VT;
  c2_wb_b = c2_Vdot;
  c2_ac_y = c2_xb_a * c2_wb_b;
  c2_yb_a = c2_V;
  c2_xb_b = c2_xd[0];
  c2_bc_y = c2_yb_a * c2_xb_b;
  c2_ac_a = c2_ac_y - c2_bc_y;
  c2_yb_b = c2_Cbeta;
  c2_cc_y = c2_ac_a * c2_yb_b;
  c2_h_A = c2_cc_y;
  c2_e_B = c2_DUM;
  c2_kb_x = c2_h_A;
  c2_dc_y = c2_e_B;
  c2_lb_x = c2_kb_x;
  c2_ec_y = c2_dc_y;
  c2_fc_y = c2_lb_x / c2_ec_y;
  c2_xd[2] = c2_fc_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 157U);
  c2_i_A = c2_Stheta;
  c2_f_B = c2_Ctheta;
  c2_mb_x = c2_i_A;
  c2_gc_y = c2_f_B;
  c2_nb_x = c2_mb_x;
  c2_hc_y = c2_gc_y;
  c2_ic_y = c2_nb_x / c2_hc_y;
  c2_bc_a = c2_R;
  c2_ac_b = c2_Cphi;
  c2_jc_y = c2_bc_a * c2_ac_b;
  c2_cc_a = c2_ic_y;
  c2_bc_b = c2_Q_sphi + c2_jc_y;
  c2_kc_y = c2_cc_a * c2_bc_b;
  c2_xd[3] = c2_P + c2_kc_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 158U);
  c2_dc_a = c2_Q;
  c2_cc_b = c2_Cphi;
  c2_lc_y = c2_dc_a * c2_cc_b;
  c2_ec_a = c2_R;
  c2_dc_b = c2_Sphi;
  c2_mc_y = c2_ec_a * c2_dc_b;
  c2_xd[4] = c2_lc_y - c2_mc_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 159U);
  c2_fc_a = c2_R;
  c2_ec_b = c2_Cphi;
  c2_nc_y = c2_fc_a * c2_ec_b;
  c2_j_A = c2_Q_sphi + c2_nc_y;
  c2_g_B = c2_Ctheta;
  c2_ob_x = c2_j_A;
  c2_oc_y = c2_g_B;
  c2_pb_x = c2_ob_x;
  c2_pc_y = c2_oc_y;
  c2_qc_y = c2_pb_x / c2_pc_y;
  c2_xd[5] = c2_qc_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 165U);
  c2_gc_a = c2_Qsb;
  c2_fc_b = c2_Clt;
  c2_Roll = c2_gc_a * c2_fc_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 166U);
  c2_hc_a = c2_Qs;
  c2_rc_y = c2_hc_a * 11.32;
  c2_ic_a = c2_rc_y;
  c2_gc_b = c2_Cmt;
  c2_Pitch = c2_ic_a * c2_gc_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 167U);
  c2_jc_a = c2_Qsb;
  c2_hc_b = c2_Cnt;
  c2_Yaw = c2_jc_a * c2_hc_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 168U);
  c2_kc_a = c2_P;
  c2_ic_b = c2_Q;
  c2_PQ = c2_kc_a * c2_ic_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 169U);
  c2_lc_a = c2_Q;
  c2_jc_b = c2_R;
  c2_QR = c2_lc_a * c2_jc_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 170U);
  c2_mc_a = c2_Q;
  c2_QHX = c2_mc_a * 160.0;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 172U);
  c2_kc_b = c2_PQ;
  c2_sc_y = 1.6479924E+7 * c2_kc_b;
  c2_lc_b = c2_QR;
  c2_tc_y = 4.60710924E+8 * c2_lc_b;
  c2_mc_b = c2_Roll;
  c2_uc_y = 63100.0 * c2_mc_b;
  c2_nc_b = c2_Yaw + c2_QHX;
  c2_vc_y = 982.0 * c2_nc_b;
  c2_k_A = ((c2_sc_y - c2_tc_y) + c2_uc_y) + c2_vc_y;
  c2_qb_x = c2_k_A;
  c2_rb_x = c2_qb_x;
  c2_wc_y = c2_rb_x / 5.98233276E+8;
  c2_xd[6] = c2_wc_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 173U);
  c2_oc_b = c2_P;
  c2_xc_y = 53604.0 * c2_oc_b;
  c2_nc_a = c2_xc_y;
  c2_pc_b = c2_R;
  c2_yc_y = c2_nc_a * c2_pc_b;
  c2_oc_a = c2_P;
  c2_qc_b = c2_P;
  c2_ad_y = c2_oc_a * c2_qc_b;
  c2_pc_a = c2_R;
  c2_rc_b = c2_R;
  c2_bd_y = c2_pc_a * c2_rc_b;
  c2_sc_b = c2_ad_y - c2_bd_y;
  c2_cd_y = 982.0 * c2_sc_b;
  c2_qc_a = c2_R;
  c2_dd_y = c2_qc_a * 160.0;
  c2_l_A = ((c2_yc_y - c2_cd_y) + c2_Pitch) - c2_dd_y;
  c2_sb_x = c2_l_A;
  c2_tb_x = c2_sb_x;
  c2_ed_y = c2_tb_x / 55814.0;
  c2_xd[7] = c2_ed_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 174U);
  c2_tc_b = c2_PQ;
  c2_fd_y = -4.38871404E+8 * c2_tc_b;
  c2_uc_b = c2_QR;
  c2_gd_y = 1.6479924E+7 * c2_uc_b;
  c2_vc_b = c2_Roll;
  c2_hd_y = 982.0 * c2_vc_b;
  c2_wc_b = c2_Yaw + c2_QHX;
  c2_id_y = 9496.0 * c2_wc_b;
  c2_m_A = ((c2_fd_y - c2_gd_y) + c2_hd_y) + c2_id_y;
  c2_ub_x = c2_m_A;
  c2_vb_x = c2_ub_x;
  c2_jd_y = c2_vb_x / 5.98233276E+8;
  c2_xd[8] = c2_jd_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 179U);
  c2_rc_a = c2_Sphi;
  c2_xc_b = c2_Cpsi;
  c2_T1 = c2_rc_a * c2_xc_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 180U);
  c2_sc_a = c2_Cphi;
  c2_yc_b = c2_Stheta;
  c2_T2 = c2_sc_a * c2_yc_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 181U);
  c2_tc_a = c2_Sphi;
  c2_ad_b = c2_Spsi;
  c2_T3 = c2_tc_a * c2_ad_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 182U);
  c2_uc_a = c2_Ctheta;
  c2_bd_b = c2_Cpsi;
  c2_S1 = c2_uc_a * c2_bd_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 183U);
  c2_vc_a = c2_Ctheta;
  c2_cd_b = c2_Spsi;
  c2_S2 = c2_vc_a * c2_cd_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 184U);
  c2_wc_a = c2_T1;
  c2_dd_b = c2_Stheta;
  c2_kd_y = c2_wc_a * c2_dd_b;
  c2_xc_a = c2_Cphi;
  c2_ed_b = c2_Spsi;
  c2_ld_y = c2_xc_a * c2_ed_b;
  c2_S3 = c2_kd_y - c2_ld_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 185U);
  c2_yc_a = c2_T3;
  c2_fd_b = c2_Stheta;
  c2_md_y = c2_yc_a * c2_fd_b;
  c2_ad_a = c2_Cphi;
  c2_gd_b = c2_Cpsi;
  c2_nd_y = c2_ad_a * c2_gd_b;
  c2_S4 = c2_md_y + c2_nd_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 186U);
  c2_bd_a = c2_Sphi;
  c2_hd_b = c2_Ctheta;
  c2_S5 = c2_bd_a * c2_hd_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 187U);
  c2_cd_a = c2_T2;
  c2_id_b = c2_Cpsi;
  c2_od_y = c2_cd_a * c2_id_b;
  c2_S6 = c2_od_y + c2_T3;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 188U);
  c2_dd_a = c2_T2;
  c2_jd_b = c2_Spsi;
  c2_pd_y = c2_dd_a * c2_jd_b;
  c2_S7 = c2_pd_y - c2_T1;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 189U);
  c2_ed_a = c2_Cpsi;
  c2_kd_b = c2_Ctheta;
  c2_S8 = c2_ed_a * c2_kd_b;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 191U);
  c2_fd_a = c2_U;
  c2_ld_b = c2_S1;
  c2_qd_y = c2_fd_a * c2_ld_b;
  c2_gd_a = c2_V;
  c2_md_b = c2_S3;
  c2_rd_y = c2_gd_a * c2_md_b;
  c2_hd_a = c2_W;
  c2_nd_b = c2_S6;
  c2_sd_y = c2_hd_a * c2_nd_b;
  c2_xd[9] = (c2_qd_y + c2_rd_y) + c2_sd_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 192U);
  c2_id_a = c2_U;
  c2_od_b = c2_S2;
  c2_td_y = c2_id_a * c2_od_b;
  c2_jd_a = c2_V;
  c2_pd_b = c2_S4;
  c2_ud_y = c2_jd_a * c2_pd_b;
  c2_kd_a = c2_W;
  c2_qd_b = c2_S7;
  c2_vd_y = c2_kd_a * c2_qd_b;
  c2_xd[10] = (c2_td_y + c2_ud_y) + c2_vd_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 193U);
  c2_ld_a = c2_U;
  c2_rd_b = c2_Stheta;
  c2_wd_y = c2_ld_a * c2_rd_b;
  c2_md_a = c2_V;
  c2_sd_b = c2_S5;
  c2_xd_y = c2_md_a * c2_sd_b;
  c2_nd_a = c2_W;
  c2_td_b = c2_S8;
  c2_yd_y = c2_nd_a * c2_td_b;
  c2_xd[11] = (c2_wd_y - c2_xd_y) - c2_yd_y;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 197U);
  c2_n_A = -c2_Az;
  c2_wb_x = c2_n_A;
  c2_xb_x = c2_wb_x;
  c2_An = c2_xb_x / 32.17;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 198U);
  c2_o_A = c2_Ay;
  c2_yb_x = c2_o_A;
  c2_ac_x = c2_yb_x;
  c2_Alat = c2_ac_x / 32.17;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 204U);
  c2_y[0] = c2_An;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 205U);
  c2_y[1] = c2_Alat;
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, -205);
  _SFD_SYMBOL_SCOPE_POP();
  for (c2_i13 = 0; c2_i13 < 13; c2_i13++) {
    (*c2_b_xd)[c2_i13] = c2_xd[c2_i13];
  }

  for (c2_i14 = 0; c2_i14 < 2; c2_i14++) {
    (*c2_ae_y)[c2_i14] = c2_y[c2_i14];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c2_sfEvent);
}

static void initSimStructsc2_F16_Simulink(SFc2_F16_SimulinkInstanceStruct
  *chartInstance)
{
}

static void c2_ADC(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T c2_VT,
                   real_T c2_Alt, real_T *c2_Mach, real_T *c2_Qbar)
{
  uint32_T c2_debug_family_var_map[11];
  real_T c2_rho0;
  real_T c2_Tfac;
  real_T c2_T;
  real_T c2_rho;
  real_T c2_Cps;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 2.0;
  real_T c2_b;
  real_T c2_y;
  real_T c2_b_b;
  real_T c2_a;
  real_T c2_b_a;
  real_T c2_c_a;
  real_T c2_ak;
  real_T c2_d_a;
  real_T c2_ar;
  real_T c2_c;
  real_T c2_c_b;
  real_T c2_d_b;
  real_T c2_b_y;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_A;
  real_T c2_B;
  real_T c2_c_x;
  real_T c2_c_y;
  real_T c2_d_x;
  real_T c2_d_y;
  real_T c2_e_b;
  real_T c2_e_y;
  real_T c2_e_a;
  real_T c2_f_b;
  real_T c2_f_y;
  real_T c2_f_a;
  real_T c2_g_b;
  real_T c2_h_b;
  real_T c2_g_y;
  real_T c2_g_a;
  real_T c2_i_b;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 11U, 11U, c2_b_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_rho0, 0U, c2_c_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Tfac, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_rho, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Cps, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_VT, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Alt, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_Mach, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_Qbar, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(0, 0);
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 4);
  c2_rho0 = 0.002377;
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 6);
  c2_b = c2_Alt;
  c2_y = 7.03E-6 * c2_b;
  c2_Tfac = 1.0 - c2_y;
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 7);
  c2_b_b = c2_Tfac;
  c2_T = 519.0 * c2_b_b;
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 9);
  if (CV_SCRIPT_IF(0, 0, c2_Alt >= 35000.0)) {
    _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 10);
    c2_T = 390.0;
  }

  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 13);
  c2_a = c2_Tfac;
  c2_b_a = c2_a;
  c2_c_a = c2_b_a;
  c2_eml_scalar_eg(chartInstance);
  c2_ak = c2_c_a;
  if (c2_ak < 0.0) {
    c2_eml_error(chartInstance);
  }

  c2_d_a = c2_ak;
  c2_eml_scalar_eg(chartInstance);
  c2_ar = c2_d_a;
  c2_c = muDoubleScalarPower(c2_ar, 4.14);
  c2_c_b = c2_c;
  c2_rho = 0.002377 * c2_c_b;
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 15);
  c2_d_b = c2_T;
  c2_b_y = 2402.8199999999997 * c2_d_b;
  c2_x = c2_b_y;
  c2_b_x = c2_x;
  if (c2_b_x < 0.0) {
    c2_b_eml_error(chartInstance);
  }

  c2_b_x = muDoubleScalarSqrt(c2_b_x);
  c2_A = c2_VT;
  c2_B = c2_b_x;
  c2_c_x = c2_A;
  c2_c_y = c2_B;
  c2_d_x = c2_c_x;
  c2_d_y = c2_c_y;
  *c2_Mach = c2_d_x / c2_d_y;
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 16);
  c2_e_b = c2_rho;
  c2_e_y = 0.5 * c2_e_b;
  c2_e_a = c2_e_y;
  c2_f_b = c2_VT;
  c2_f_y = c2_e_a * c2_f_b;
  c2_f_a = c2_f_y;
  c2_g_b = c2_VT;
  *c2_Qbar = c2_f_a * c2_g_b;
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, 17);
  c2_h_b = c2_rho;
  c2_g_y = 1715.0 * c2_h_b;
  c2_g_a = c2_g_y;
  c2_i_b = c2_T;
  c2_Cps = c2_g_a * c2_i_b;
  _SFD_SCRIPT_CALL(0U, chartInstance->c2_sfEvent, -17);
  _SFD_SYMBOL_SCOPE_POP();
}

static real_T c2_TGear(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
  c2_Thtl)
{
  real_T c2_Saida;
  uint32_T c2_debug_family_var_map[4];
  real_T c2_nargin = 1.0;
  real_T c2_nargout = 1.0;
  real_T c2_b;
  real_T c2_b_b;
  real_T c2_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 4U, 4U, c2_c_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 0U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Thtl, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Saida, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(1, 0);
  _SFD_SCRIPT_CALL(1U, chartInstance->c2_sfEvent, 7);
  if (CV_SCRIPT_IF(1, 0, c2_Thtl <= 0.77)) {
    _SFD_SCRIPT_CALL(1U, chartInstance->c2_sfEvent, 8);
    c2_b = c2_Thtl;
    c2_Saida = 64.94 * c2_b;
  } else {
    _SFD_SCRIPT_CALL(1U, chartInstance->c2_sfEvent, 10);
    c2_b_b = c2_Thtl;
    c2_y = 217.38 * c2_b_b;
    c2_Saida = c2_y - 117.38;
  }

  _SFD_SCRIPT_CALL(1U, chartInstance->c2_sfEvent, -10);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_Saida;
}

static real_T c2_PowerRate(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  real_T c2_P3, real_T c2_P1)
{
  real_T c2_Saida;
  uint32_T c2_debug_family_var_map[7];
  real_T c2_T;
  real_T c2_P2;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  real_T c2_a;
  real_T c2_b;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 7U, 7U, c2_e_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 0U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_P2, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_P3, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_P1, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Saida, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(2, 0);
  _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 9);
  if (CV_SCRIPT_IF(2, 0, c2_P1 >= 50.0)) {
    _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 10);
    if (CV_SCRIPT_IF(2, 1, c2_P3 >= 50.0)) {
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 11);
      c2_T = 5.0;
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 12);
      c2_P2 = c2_P1;
    } else {
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 14);
      c2_P2 = 60.0;
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 15);
      c2_T = c2_Rtau(chartInstance, c2_P2 - c2_P3);
    }
  } else {
    _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 18);
    if (CV_SCRIPT_IF(2, 2, c2_P3 >= 50.0)) {
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 19);
      c2_T = 5.0;
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 20);
      c2_P2 = 40.0;
    } else {
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 22);
      c2_P2 = c2_P1;
      _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 23);
      c2_T = c2_Rtau(chartInstance, c2_P2 - c2_P3);
    }
  }

  _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, 27);
  c2_a = c2_T;
  c2_b = c2_P2 - c2_P3;
  c2_Saida = c2_a * c2_b;
  _SFD_SCRIPT_CALL(2U, chartInstance->c2_sfEvent, -27);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_Saida;
}

static real_T c2_Rtau(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_DP)
{
  real_T c2_Saida;
  uint32_T c2_debug_family_var_map[4];
  real_T c2_nargin = 1.0;
  real_T c2_nargout = 1.0;
  real_T c2_b;
  real_T c2_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 4U, 4U, c2_d_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 0U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DP, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Saida, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(3, 0);
  _SFD_SCRIPT_CALL(3U, chartInstance->c2_sfEvent, 5);
  if (CV_SCRIPT_IF(3, 0, c2_DP <= 25.0)) {
    _SFD_SCRIPT_CALL(3U, chartInstance->c2_sfEvent, 6);
    c2_Saida = 1.0;
  } else {
    _SFD_SCRIPT_CALL(3U, chartInstance->c2_sfEvent, 7);
    if (CV_SCRIPT_IF(3, 1, c2_DP >= 50.0)) {
      _SFD_SCRIPT_CALL(3U, chartInstance->c2_sfEvent, 8);
      c2_Saida = 0.1;
    } else {
      _SFD_SCRIPT_CALL(3U, chartInstance->c2_sfEvent, 10);
      c2_b = c2_DP;
      c2_y = 0.036 * c2_b;
      c2_Saida = 1.9 - c2_y;
    }
  }

  _SFD_SCRIPT_CALL(3U, chartInstance->c2_sfEvent, -10);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_Saida;
}

static real_T c2_Thrust(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
  c2_Pow, real_T c2_Altitude, real_T c2_RMach)
{
  real_T c2_THRUST;
  uint32_T c2_debug_family_var_map[21];
  real_T c2_A[36];
  real_T c2_B[36];
  real_T c2_C[36];
  real_T c2_H;
  real_T c2_I;
  real_T c2_DH;
  real_T c2_RM;
  real_T c2_M;
  real_T c2_DM;
  real_T c2_CDH;
  real_T c2_S;
  real_T c2_T;
  real_T c2_Tmil;
  real_T c2_Tidl;
  real_T c2_Tmax;
  real_T c2_nargin = 3.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i15;
  static real_T c2_dv3[36] = { 1060.0, 635.0, 60.0, -1020.0, -2700.0, -3600.0,
    670.0, 425.0, 25.0, -710.0, -1900.0, -1400.0, 880.0, 690.0, 345.0, -300.0,
    -1300.0, -595.0, 1140.0, 1010.0, 755.0, 350.0, -247.0, -342.0, 1500.0,
    1330.0, 1130.0, 910.0, 600.0, -200.0, 1860.0, 1700.0, 1525.0, 1360.0, 1100.0,
    700.0 };

  int32_T c2_i16;
  static real_T c2_dv4[36] = { 12680.0, 12680.0, 12610.0, 12640.0, 12390.0,
    11680.0, 9150.0, 9150.0, 9312.0, 9839.0, 10176.0, 9848.0, 6200.0, 6313.0,
    6610.0, 7090.0, 7750.0, 8050.0, 3950.0, 4040.0, 4290.0, 4660.0, 5320.0,
    6100.0, 2450.0, 2470.0, 2600.0, 2840.0, 3250.0, 3800.0, 1400.0, 1400.0,
    1560.0, 1660.0, 1930.0, 2310.0 };

  int32_T c2_i17;
  static real_T c2_dv5[36] = { 20000.0, 21420.0, 22700.0, 24240.0, 26070.0,
    28886.0, 15000.0, 15700.0, 16860.0, 18910.0, 21075.0, 23319.0, 10800.0,
    11225.0, 12250.0, 13760.0, 15975.0, 18300.0, 7000.0, 7323.0, 8154.0, 9285.0,
    11115.0, 13484.0, 4000.0, 4435.0, 5000.0, 5700.0, 6860.0, 8642.0, 2500.0,
    2600.0, 2835.0, 3215.0, 3950.0, 5057.0 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_b_b;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_u;
  real_T c2_a;
  real_T c2_c_b;
  real_T c2_y;
  real_T c2_b_a;
  real_T c2_d_b;
  real_T c2_b_y;
  real_T c2_c_a;
  real_T c2_e_b;
  real_T c2_c_y;
  real_T c2_d_a;
  real_T c2_f_b;
  real_T c2_d_y;
  real_T c2_e_a;
  real_T c2_g_b;
  real_T c2_e_y;
  real_T c2_f_a;
  real_T c2_h_b;
  real_T c2_f_y;
  real_T c2_g_a;
  real_T c2_i_b;
  real_T c2_g_y;
  real_T c2_h_a;
  real_T c2_j_b;
  real_T c2_h_y;
  real_T c2_i_a;
  real_T c2_k_b;
  real_T c2_i_y;
  real_T c2_j_a;
  real_T c2_l_b;
  real_T c2_j_y;
  real_T c2_k_a;
  real_T c2_m_b;
  real_T c2_k_y;
  real_T c2_l_a;
  real_T c2_l_y;
  real_T c2_m_a;
  real_T c2_n_b;
  real_T c2_m_y;
  real_T c2_n_a;
  real_T c2_o_b;
  real_T c2_n_y;
  real_T c2_o_a;
  real_T c2_p_b;
  real_T c2_o_y;
  real_T c2_p_a;
  real_T c2_q_b;
  real_T c2_p_y;
  real_T c2_q_a;
  real_T c2_r_b;
  real_T c2_q_y;
  real_T c2_r_a;
  real_T c2_s_b;
  real_T c2_r_y;
  real_T c2_s_a;
  real_T c2_s_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 21U, 21U, c2_f_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_f_sf_marshallOut,
    c2_e_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_B, 1U, c2_f_sf_marshallOut,
    c2_e_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_C, 2U, c2_f_sf_marshallOut,
    c2_e_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_H, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_I, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DH, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_RM, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DM, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CDH, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Tmil, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Tidl, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Tmax, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 16U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Pow, 17U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_Altitude, 18U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_RMach, 19U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_THRUST, 20U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(4, 0);
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 6);
  for (c2_i15 = 0; c2_i15 < 36; c2_i15++) {
    c2_A[c2_i15] = c2_dv3[c2_i15];
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 14);
  for (c2_i16 = 0; c2_i16 < 36; c2_i16++) {
    c2_B[c2_i16] = c2_dv4[c2_i16];
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 22);
  for (c2_i17 = 0; c2_i17 < 36; c2_i17++) {
    c2_C[c2_i17] = c2_dv5[c2_i17];
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 29);
  c2_b = c2_Altitude;
  c2_H = 0.0001 * c2_b;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 30);
  c2_x = c2_H;
  c2_I = c2_x;
  c2_b_x = c2_I;
  c2_I = c2_b_x;
  c2_u = c2_I;
  if (c2_u < 0.0) {
    c2_I = muDoubleScalarCeil(c2_u);
  } else {
    c2_I = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 31);
  if (CV_SCRIPT_IF(4, 0, c2_I >= 5.0)) {
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 32);
    c2_I = 4.0;
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 34);
  c2_DH = c2_H - c2_I;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 36);
  c2_b_b = c2_RMach;
  c2_RM = 5.0 * c2_b_b;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 37);
  c2_c_x = c2_RM;
  c2_M = c2_c_x;
  c2_d_x = c2_M;
  c2_M = c2_d_x;
  c2_b_u = c2_M;
  if (c2_b_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_b_u);
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 38);
  if (CV_SCRIPT_IF(4, 1, c2_M >= 5.0)) {
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 39);
    c2_M = 4.0;
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 41);
  c2_DM = c2_RM - c2_M;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 42);
  c2_CDH = 1.0 - c2_DH;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 46);
  c2_I++;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 47);
  c2_M++;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 67);
  c2_a = c2_B[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1,
    6, 2, 0) - 1)) - 1];
  c2_c_b = c2_CDH;
  c2_y = c2_a * c2_c_b;
  c2_b_a = c2_B[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)_SFD_INTEGER_CHECK("I+1", c2_I +
    1.0), 1, 6, 2, 0) - 1)) - 1];
  c2_d_b = c2_DH;
  c2_b_y = c2_b_a * c2_d_b;
  c2_S = c2_y + c2_b_y;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 68);
  c2_c_a = c2_B[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)
    _SFD_INTEGER_CHECK("M+1", c2_M + 1.0), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1,
    6, 2, 0) - 1)) - 1];
  c2_e_b = c2_CDH;
  c2_c_y = c2_c_a * c2_e_b;
  c2_d_a = c2_B[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)
    _SFD_INTEGER_CHECK("M+1", c2_M + 1.0), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("B", (int32_T)_SFD_INTEGER_CHECK("I+1", c2_I +
    1.0), 1, 6, 2, 0) - 1)) - 1];
  c2_f_b = c2_DH;
  c2_d_y = c2_d_a * c2_f_b;
  c2_T = c2_c_y + c2_d_y;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 69);
  c2_e_a = c2_T - c2_S;
  c2_g_b = c2_DM;
  c2_e_y = c2_e_a * c2_g_b;
  c2_Tmil = c2_S + c2_e_y;
  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 71);
  if (CV_SCRIPT_IF(4, 2, c2_Pow < 50.0)) {
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 72);
    c2_f_a = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
      _SFD_INTEGER_CHECK("M", c2_M), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1,
      6, 2, 0) - 1)) - 1];
    c2_h_b = c2_CDH;
    c2_f_y = c2_f_a * c2_h_b;
    c2_g_a = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
      _SFD_INTEGER_CHECK("M", c2_M), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("I+1", c2_I +
      1.0), 1, 6, 2, 0) - 1)) - 1];
    c2_i_b = c2_DH;
    c2_g_y = c2_g_a * c2_i_b;
    c2_S = c2_f_y + c2_g_y;
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 73);
    c2_h_a = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
      _SFD_INTEGER_CHECK("M+1", c2_M + 1.0), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1,
      6, 2, 0) - 1)) - 1];
    c2_j_b = c2_CDH;
    c2_h_y = c2_h_a * c2_j_b;
    c2_i_a = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
      _SFD_INTEGER_CHECK("M+1", c2_M + 1.0), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("I+1", c2_I +
      1.0), 1, 6, 2, 0) - 1)) - 1];
    c2_k_b = c2_DH;
    c2_i_y = c2_i_a * c2_k_b;
    c2_T = c2_h_y + c2_i_y;
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 74);
    c2_j_a = c2_T - c2_S;
    c2_l_b = c2_DM;
    c2_j_y = c2_j_a * c2_l_b;
    c2_Tidl = c2_S + c2_j_y;
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 75);
    c2_k_a = c2_Tmil - c2_Tidl;
    c2_m_b = c2_Pow;
    c2_k_y = c2_k_a * c2_m_b;
    c2_l_a = c2_k_y;
    c2_l_y = c2_l_a * 0.02;
    c2_THRUST = c2_Tidl + c2_l_y;
  } else {
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 77);
    c2_m_a = c2_C[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)
      _SFD_INTEGER_CHECK("M", c2_M), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1,
      6, 2, 0) - 1)) - 1];
    c2_n_b = c2_CDH;
    c2_m_y = c2_m_a * c2_n_b;
    c2_n_a = c2_C[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)
      _SFD_INTEGER_CHECK("M", c2_M), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)_SFD_INTEGER_CHECK("I+1", c2_I +
      1.0), 1, 6, 2, 0) - 1)) - 1];
    c2_o_b = c2_DH;
    c2_n_y = c2_n_a * c2_o_b;
    c2_S = c2_m_y + c2_n_y;
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 78);
    c2_o_a = c2_C[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)
      _SFD_INTEGER_CHECK("M+1", c2_M + 1.0), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1,
      6, 2, 0) - 1)) - 1];
    c2_p_b = c2_CDH;
    c2_o_y = c2_o_a * c2_p_b;
    c2_p_a = c2_C[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)
      _SFD_INTEGER_CHECK("M+1", c2_M + 1.0), 1, 6, 1, 0) + 6 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("C", (int32_T)_SFD_INTEGER_CHECK("I+1", c2_I +
      1.0), 1, 6, 2, 0) - 1)) - 1];
    c2_q_b = c2_DH;
    c2_p_y = c2_p_a * c2_q_b;
    c2_T = c2_o_y + c2_p_y;
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 79);
    c2_q_a = c2_T - c2_S;
    c2_r_b = c2_DM;
    c2_q_y = c2_q_a * c2_r_b;
    c2_Tmax = c2_S + c2_q_y;
    _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, 80);
    c2_r_a = c2_Tmax - c2_Tmil;
    c2_s_b = c2_Pow - 50.0;
    c2_r_y = c2_r_a * c2_s_b;
    c2_s_a = c2_r_y;
    c2_s_y = c2_s_a * 0.02;
    c2_THRUST = c2_Tmil + c2_s_y;
  }

  _SFD_SCRIPT_CALL(4U, chartInstance->c2_sfEvent, -80);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_THRUST;
}

static real_T c2_Cx(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_elevator)
{
  real_T c2_CoeficienteForcaX;
  uint32_T c2_debug_family_var_map[17];
  real_T c2_A[60];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DE;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i18;
  static real_T c2_dv6[60] = { -0.099, -0.048, -0.022, -0.04, -0.083, -0.081,
    -0.038, -0.02, -0.038, -0.073, -0.081, -0.04, -0.021, -0.039, -0.076, -0.063,
    -0.021, -0.004, -0.025, -0.072, -0.025, 0.016, 0.032, 0.006, -0.046, 0.044,
    0.083, 0.094, 0.062, 0.012, 0.097, 0.127, 0.128, 0.087, 0.024, 0.113, 0.137,
    0.13, 0.085, 0.025, 0.145, 0.162, 0.154, 0.1, 0.043, 0.167, 0.177, 0.161,
    0.11, 0.053, 0.174, 0.179, 0.155, 0.104, 0.047, 0.166, 0.167, 0.138, 0.091,
    0.04 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_a;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_u;
  real_T c2_b_A;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_c_u;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_b_a;
  real_T c2_b_y;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_d_u;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_c_y;
  real_T c2_c_a;
  real_T c2_b_b;
  real_T c2_d_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_e_y;
  real_T c2_d_a;
  real_T c2_c_b;
  real_T c2_f_y;
  real_T c2_s_x;
  real_T c2_t_x;
  real_T c2_g_y;
  real_T c2_e_a;
  real_T c2_d_b;
  real_T c2_h_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 17U, 17U, c2_g_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_g_sf_marshallOut,
    c2_f_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DE, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_elevator, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteForcaX, 16U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(5, 0);
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 5);
  for (c2_i18 = 0; c2_i18 < 60; c2_i18++) {
    c2_A[c2_i18] = c2_dv6[c2_i18];
  }

  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 12);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 13);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 16);
  if (CV_SCRIPT_IF(5, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 17);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 19);
  if (CV_SCRIPT_IF(5, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 20);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 23);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 27);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 30);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_a = c2_d_x;
  c2_y = c2_a * 1.1;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_b_u = c2_f_x;
  if (c2_b_u < 0.0) {
    c2_f_x = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_f_x = muDoubleScalarFloor(c2_b_u);
  }

  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 32);
  c2_b_A = c2_elevator;
  c2_g_x = c2_b_A;
  c2_h_x = c2_g_x;
  c2_S = c2_h_x / 12.0;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 33);
  c2_i_x = c2_S;
  c2_M = c2_i_x;
  c2_j_x = c2_M;
  c2_M = c2_j_x;
  c2_c_u = c2_M;
  if (c2_c_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_c_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_c_u);
  }

  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 36);
  if (CV_SCRIPT_IF(5, 2, c2_M <= -2.0)) {
    _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 37);
    c2_M = -1.0;
  }

  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 39);
  if (CV_SCRIPT_IF(5, 3, c2_M >= 2.0)) {
    _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 40);
    c2_M = 1.0;
  }

  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 43);
  c2_DE = c2_S - c2_M;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 47);
  c2_M += 3.0;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 50);
  c2_k_x = c2_DE;
  c2_l_x = c2_k_x;
  c2_l_x = muDoubleScalarSign(c2_l_x);
  c2_b_a = c2_l_x;
  c2_b_y = c2_b_a * 1.1;
  c2_m_x = c2_b_y;
  c2_n_x = c2_m_x;
  c2_d_u = c2_n_x;
  if (c2_d_u < 0.0) {
    c2_n_x = muDoubleScalarCeil(c2_d_u);
  } else {
    c2_n_x = muDoubleScalarFloor(c2_d_u);
  }

  c2_N = c2_M + c2_n_x;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 58);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 59);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 60);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_c_y = muDoubleScalarAbs(c2_p_x);
  c2_c_a = c2_c_y;
  c2_b_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_d_y = c2_c_a * c2_b_b;
  c2_V = c2_T + c2_d_y;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 61);
  c2_q_x = c2_DA;
  c2_r_x = c2_q_x;
  c2_e_y = muDoubleScalarAbs(c2_r_x);
  c2_d_a = c2_e_y;
  c2_c_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_f_y = c2_d_a * c2_c_b;
  c2_W = c2_U + c2_f_y;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, 64);
  c2_s_x = c2_DE;
  c2_t_x = c2_s_x;
  c2_g_y = muDoubleScalarAbs(c2_t_x);
  c2_e_a = c2_W - c2_V;
  c2_d_b = c2_g_y;
  c2_h_y = c2_e_a * c2_d_b;
  c2_CoeficienteForcaX = c2_V + c2_h_y;
  _SFD_SCRIPT_CALL(5U, chartInstance->c2_sfEvent, -64);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteForcaX;
}

static real_T c2_Cy(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_beta, real_T c2_aileron, real_T c2_rudder)
{
  real_T c2_CoeficienteSideForce;
  uint32_T c2_debug_family_var_map[6];
  real_T c2_nargin = 3.0;
  real_T c2_nargout = 1.0;
  real_T c2_b;
  real_T c2_y;
  real_T c2_A;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_b_y;
  real_T c2_b_b;
  real_T c2_c_y;
  real_T c2_b_A;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_d_y;
  real_T c2_c_b;
  real_T c2_e_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 6U, 6U, c2_h_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 0U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_aileron, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_rudder, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteSideForce, 5U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(6, 0);
  _SFD_SCRIPT_CALL(6U, chartInstance->c2_sfEvent, 3);
  c2_b = c2_beta;
  c2_y = -0.02 * c2_b;
  c2_A = c2_aileron;
  c2_x = c2_A;
  c2_b_x = c2_x;
  c2_b_y = c2_b_x / 20.0;
  c2_b_b = c2_b_y;
  c2_c_y = 0.021 * c2_b_b;
  c2_b_A = c2_rudder;
  c2_c_x = c2_b_A;
  c2_d_x = c2_c_x;
  c2_d_y = c2_d_x / 30.0;
  c2_c_b = c2_d_y;
  c2_e_y = 0.086 * c2_c_b;
  c2_CoeficienteSideForce = (c2_y + c2_c_y) + c2_e_y;
  _SFD_SCRIPT_CALL(6U, chartInstance->c2_sfEvent, -3);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteSideForce;
}

static real_T c2_Cz(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_beta, real_T c2_elevator)
{
  real_T c2_CoeficienteForcaZ;
  uint32_T c2_debug_family_var_map[11];
  real_T c2_A[12];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_nargin = 3.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i19;
  static real_T c2_dv7[12] = { 0.77, 0.241, -0.1, -0.416, -0.731, -1.053, -1.366,
    -1.646, -1.917, -2.12, -2.248, -2.229 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_b_y;
  real_T c2_a;
  real_T c2_c_b;
  real_T c2_c_y;
  real_T c2_b_A;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_d_y;
  real_T c2_b_a;
  real_T c2_c_a;
  real_T c2_d_a;
  real_T c2_ak;
  real_T c2_e_a;
  real_T c2_f_a;
  real_T c2_d_b;
  real_T c2_c;
  real_T c2_g_a;
  real_T c2_e_b;
  real_T c2_e_y;
  real_T c2_c_A;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_f_y;
  real_T c2_f_b;
  real_T c2_g_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 11U, 11U, c2_i_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_h_sf_marshallOut,
    c2_g_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_elevator, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteForcaZ, 10U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(7, 0);
  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 3);
  for (c2_i19 = 0; c2_i19 < 12; c2_i19++) {
    c2_A[c2_i19] = c2_dv7[c2_i19];
  }

  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 5);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 6);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 9);
  if (CV_SCRIPT_IF(7, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 10);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 12);
  if (CV_SCRIPT_IF(7, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 13);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 16);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 21);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 25);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_b_b = c2_d_x;
  c2_y = 1.1 * c2_b_b;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_f_x = muDoubleScalarRound(c2_f_x);
  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 31);
  c2_g_x = c2_DA;
  c2_h_x = c2_g_x;
  c2_b_y = muDoubleScalarAbs(c2_h_x);
  c2_a = c2_b_y;
  c2_c_b = c2_A[(int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("L", c2_L), 1, 12, 1, 0) - 1] - c2_A[(int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 1, 0) - 1];
  c2_c_y = c2_a * c2_c_b;
  c2_S = c2_A[(int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("K", c2_K), 1, 12, 1, 0) - 1] + c2_c_y;
  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, 33);
  c2_b_A = c2_beta;
  c2_i_x = c2_b_A;
  c2_j_x = c2_i_x;
  c2_d_y = c2_j_x / 57.3;
  c2_b_a = c2_d_y;
  c2_c_a = c2_b_a;
  c2_d_a = c2_c_a;
  c2_eml_scalar_eg(chartInstance);
  c2_ak = c2_d_a;
  c2_e_a = c2_ak;
  c2_eml_scalar_eg(chartInstance);
  c2_f_a = c2_e_a;
  c2_d_b = c2_e_a;
  c2_c = c2_f_a * c2_d_b;
  c2_g_a = c2_S;
  c2_e_b = 1.0 - c2_c;
  c2_e_y = c2_g_a * c2_e_b;
  c2_c_A = c2_elevator;
  c2_k_x = c2_c_A;
  c2_l_x = c2_k_x;
  c2_f_y = c2_l_x / 25.0;
  c2_f_b = c2_f_y;
  c2_g_y = 0.19 * c2_f_b;
  c2_CoeficienteForcaZ = c2_e_y - c2_g_y;
  _SFD_SCRIPT_CALL(7U, chartInstance->c2_sfEvent, -33);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteForcaZ;
}

static real_T c2_Cl(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_beta)
{
  real_T c2_CoeficienteRollingMoment;
  uint32_T c2_debug_family_var_map[18];
  real_T c2_A[84];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DB;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_DUM;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i20;
  static real_T c2_dv8[84] = { 0.0, -0.001, -0.003, -0.001, 0.0, 0.007, 0.009,
    0.0, -0.004, -0.009, -0.01, -0.01, -0.01, -0.011, 0.0, -0.008, -0.017, -0.02,
    -0.022, -0.023, -0.023, 0.0, -0.012, -0.024, -0.03, -0.034, -0.034, -0.037,
    0.0, -0.016, -0.03, -0.039, -0.047, -0.049, -0.05, 0.0, -0.019, -0.034,
    -0.044, -0.046, -0.046, -0.047, 0.0, -0.02, -0.04, -0.05, -0.059, -0.068,
    -0.074, 0.0, -0.02, -0.037, -0.049, -0.061, -0.071, -0.079, 0.0, -0.015,
    -0.016, -0.023, -0.033, -0.06, -0.091, 0.0, -0.008, -0.002, -0.006, -0.036,
    -0.058, -0.076, 0.0, -0.013, -0.01, -0.014, -0.035, -0.062, -0.077, 0.0,
    -0.015, -0.019, -0.027, -0.035, -0.059, -0.076 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_u;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_b_y;
  real_T c2_c_b;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_c_u;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_d_b;
  real_T c2_c_y;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_d_u;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_d_y;
  real_T c2_a;
  real_T c2_e_b;
  real_T c2_e_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_f_y;
  real_T c2_b_a;
  real_T c2_f_b;
  real_T c2_g_y;
  real_T c2_s_x;
  real_T c2_t_x;
  real_T c2_h_y;
  real_T c2_c_a;
  real_T c2_g_b;
  real_T c2_i_y;
  real_T c2_u_x;
  real_T c2_v_x;
  real_T c2_d_a;
  real_T c2_h_b;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 18U, 18U, c2_j_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_i_sf_marshallOut,
    c2_h_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DB, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DUM, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 16U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteRollingMoment, 17U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(8, 0);
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 5);
  for (c2_i20 = 0; c2_i20 < 84; c2_i20++) {
    c2_A[c2_i20] = c2_dv8[c2_i20];
  }

  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 25);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 26);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 29);
  if (CV_SCRIPT_IF(8, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 30);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 32);
  if (CV_SCRIPT_IF(8, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 33);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 36);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 37);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_b_b = c2_d_x;
  c2_y = 1.1 * c2_b_b;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_b_u = c2_f_x;
  if (c2_b_u < 0.0) {
    c2_f_x = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_f_x = muDoubleScalarFloor(c2_b_u);
  }

  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 39);
  c2_g_x = c2_beta;
  c2_h_x = c2_g_x;
  c2_b_y = muDoubleScalarAbs(c2_h_x);
  c2_c_b = c2_b_y;
  c2_S = 0.2 * c2_c_b;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 40);
  c2_i_x = c2_S;
  c2_M = c2_i_x;
  c2_j_x = c2_M;
  c2_M = c2_j_x;
  c2_c_u = c2_M;
  if (c2_c_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_c_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_c_u);
  }

  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 42);
  if (CV_SCRIPT_IF(8, 2, c2_M == 0.0)) {
    _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 43);
    c2_M = 1.0;
  }

  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 45);
  if (CV_SCRIPT_IF(8, 3, c2_M >= 6.0)) {
    _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 46);
    c2_M = 5.0;
  }

  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 48);
  c2_DB = c2_S - c2_M;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 49);
  c2_k_x = c2_DB;
  c2_l_x = c2_k_x;
  c2_l_x = muDoubleScalarSign(c2_l_x);
  c2_d_b = c2_l_x;
  c2_c_y = 1.1 * c2_d_b;
  c2_m_x = c2_c_y;
  c2_n_x = c2_m_x;
  c2_d_u = c2_n_x;
  if (c2_d_u < 0.0) {
    c2_n_x = muDoubleScalarCeil(c2_d_u);
  } else {
    c2_n_x = muDoubleScalarFloor(c2_d_u);
  }

  c2_N = c2_M + c2_n_x;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 53);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 54);
  c2_L += 3.0;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 55);
  c2_M++;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 56);
  c2_N++;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 64);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 65);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 66);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_d_y = muDoubleScalarAbs(c2_p_x);
  c2_a = c2_d_y;
  c2_e_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_e_y = c2_a * c2_e_b;
  c2_V = c2_T + c2_e_y;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 67);
  c2_q_x = c2_DA;
  c2_r_x = c2_q_x;
  c2_f_y = muDoubleScalarAbs(c2_r_x);
  c2_b_a = c2_f_y;
  c2_f_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_g_y = c2_b_a * c2_f_b;
  c2_W = c2_U + c2_g_y;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 70);
  c2_s_x = c2_DB;
  c2_t_x = c2_s_x;
  c2_h_y = muDoubleScalarAbs(c2_t_x);
  c2_c_a = c2_W - c2_V;
  c2_g_b = c2_h_y;
  c2_i_y = c2_c_a * c2_g_b;
  c2_DUM = c2_V + c2_i_y;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, 72);
  c2_u_x = c2_beta;
  c2_v_x = c2_u_x;
  c2_v_x = muDoubleScalarSign(c2_v_x);
  c2_d_a = c2_DUM;
  c2_h_b = c2_v_x;
  c2_CoeficienteRollingMoment = c2_d_a * c2_h_b;
  _SFD_SCRIPT_CALL(8U, chartInstance->c2_sfEvent, -72);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteRollingMoment;
}

static real_T c2_Dlda(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta)
{
  real_T c2_CoeficienteRollingMomentAileron;
  uint32_T c2_debug_family_var_map[17];
  real_T c2_A[84];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DB;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i21;
  static real_T c2_dv9[84] = { -0.041, -0.041, -0.042, -0.04, -0.043, -0.044,
    -0.043, -0.052, -0.053, -0.053, -0.052, -0.049, -0.048, -0.049, -0.053,
    -0.053, -0.052, -0.051, -0.048, -0.048, -0.047, -0.056, -0.053, -0.051,
    -0.052, -0.049, -0.047, -0.045, -0.05, -0.05, -0.049, -0.048, -0.043, -0.042,
    -0.042, -0.056, -0.051, -0.049, -0.048, -0.042, -0.041, -0.037, -0.082,
    -0.066, -0.043, -0.042, -0.042, -0.02, -0.003, -0.059, -0.043, -0.035,
    -0.037, -0.036, -0.028, -0.013, -0.042, -0.038, -0.026, -0.031, -0.025,
    -0.013, -0.01, -0.038, -0.027, -0.016, -0.026, -0.021, -0.014, -0.003,
    -0.027, -0.023, -0.018, -0.017, -0.016, -0.011, -0.007, -0.017, -0.016,
    -0.014, -0.012, -0.011, -0.01, -0.008 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_u;
  real_T c2_c_b;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_c_u;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_d_b;
  real_T c2_b_y;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_d_u;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_c_y;
  real_T c2_a;
  real_T c2_e_b;
  real_T c2_d_y;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_e_y;
  real_T c2_b_a;
  real_T c2_f_b;
  real_T c2_f_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_g_y;
  real_T c2_c_a;
  real_T c2_g_b;
  real_T c2_h_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 17U, 17U, c2_k_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_i_sf_marshallOut,
    c2_h_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DB, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteRollingMomentAileron, 16U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(9, 0);
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 5);
  for (c2_i21 = 0; c2_i21 < 84; c2_i21++) {
    c2_A[c2_i21] = c2_dv9[c2_i21];
  }

  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 13);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 14);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 16);
  if (CV_SCRIPT_IF(9, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 17);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 19);
  if (CV_SCRIPT_IF(9, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 20);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 22);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 23);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_b_b = c2_d_x;
  c2_y = 1.1 * c2_b_b;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_b_u = c2_f_x;
  if (c2_b_u < 0.0) {
    c2_f_x = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_f_x = muDoubleScalarFloor(c2_b_u);
  }

  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 25);
  c2_c_b = c2_beta;
  c2_S = 0.1 * c2_c_b;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 26);
  c2_g_x = c2_S;
  c2_M = c2_g_x;
  c2_h_x = c2_M;
  c2_M = c2_h_x;
  c2_c_u = c2_M;
  if (c2_c_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_c_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_c_u);
  }

  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 28);
  if (CV_SCRIPT_IF(9, 2, c2_M == -3.0)) {
    _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 29);
    c2_M = -2.0;
  }

  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 31);
  if (CV_SCRIPT_IF(9, 3, c2_M >= 3.0)) {
    _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 32);
    c2_M = 2.0;
  }

  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 35);
  c2_DB = c2_S - c2_M;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 36);
  c2_i_x = c2_DB;
  c2_j_x = c2_i_x;
  c2_j_x = muDoubleScalarSign(c2_j_x);
  c2_d_b = c2_j_x;
  c2_b_y = 1.1 * c2_d_b;
  c2_k_x = c2_b_y;
  c2_l_x = c2_k_x;
  c2_d_u = c2_l_x;
  if (c2_d_u < 0.0) {
    c2_l_x = muDoubleScalarCeil(c2_d_u);
  } else {
    c2_l_x = muDoubleScalarFloor(c2_d_u);
  }

  c2_N = c2_M + c2_l_x;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 41);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 42);
  c2_L += 3.0;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 43);
  c2_M += 4.0;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 44);
  c2_N += 4.0;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 52);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 53);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 54);
  c2_m_x = c2_DA;
  c2_n_x = c2_m_x;
  c2_c_y = muDoubleScalarAbs(c2_n_x);
  c2_a = c2_c_y;
  c2_e_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_d_y = c2_a * c2_e_b;
  c2_V = c2_T + c2_d_y;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 55);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_e_y = muDoubleScalarAbs(c2_p_x);
  c2_b_a = c2_e_y;
  c2_f_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_f_y = c2_b_a * c2_f_b;
  c2_W = c2_U + c2_f_y;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, 58);
  c2_q_x = c2_DB;
  c2_r_x = c2_q_x;
  c2_g_y = muDoubleScalarAbs(c2_r_x);
  c2_c_a = c2_W - c2_V;
  c2_g_b = c2_g_y;
  c2_h_y = c2_c_a * c2_g_b;
  c2_CoeficienteRollingMomentAileron = c2_V + c2_h_y;
  _SFD_SCRIPT_CALL(9U, chartInstance->c2_sfEvent, -58);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteRollingMomentAileron;
}

static real_T c2_Dldr(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta)
{
  real_T c2_CoeficienteRollingMomentRudder;
  uint32_T c2_debug_family_var_map[17];
  real_T c2_A[84];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DB;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i22;
  static real_T c2_dv10[84] = { 0.005, 0.007, 0.013, 0.018, 0.015, 0.021, 0.023,
    0.017, 0.016, 0.013, 0.015, 0.014, 0.011, 0.01, 0.014, 0.014, 0.011, 0.015,
    0.013, 0.01, 0.011, 0.01, 0.014, 0.012, 0.014, 0.013, 0.011, 0.011, -0.005,
    0.013, 0.011, 0.014, 0.012, 0.01, 0.011, 0.009, 0.009, 0.009, 0.014, 0.011,
    0.009, 0.01, 0.019, 0.012, 0.008, 0.014, 0.011, 0.008, 0.008, 0.005, 0.005,
    0.005, 0.015, 0.01, 0.01, 0.01, -0.0, 0.0, -0.002, 0.013, 0.008, 0.006,
    0.006, -0.005, 0.004, 0.005, 0.011, 0.008, 0.005, 0.014, -0.011, 0.009,
    0.003, 0.006, 0.007, 0.0, 0.02, 0.008, 0.007, 0.005, 0.001, 0.003, 0.001,
    0.0 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_u;
  real_T c2_c_b;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_c_u;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_d_b;
  real_T c2_b_y;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_d_u;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_c_y;
  real_T c2_a;
  real_T c2_e_b;
  real_T c2_d_y;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_e_y;
  real_T c2_b_a;
  real_T c2_f_b;
  real_T c2_f_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_g_y;
  real_T c2_c_a;
  real_T c2_g_b;
  real_T c2_h_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 17U, 17U, c2_l_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_i_sf_marshallOut,
    c2_h_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DB, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteRollingMomentRudder, 16U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(10, 0);
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 4);
  for (c2_i22 = 0; c2_i22 < 84; c2_i22++) {
    c2_A[c2_i22] = c2_dv10[c2_i22];
  }

  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 12);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 13);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 14);
  if (CV_SCRIPT_IF(10, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 15);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 17);
  if (CV_SCRIPT_IF(10, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 18);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 20);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 21);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_b_b = c2_d_x;
  c2_y = 1.1 * c2_b_b;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_b_u = c2_f_x;
  if (c2_b_u < 0.0) {
    c2_f_x = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_f_x = muDoubleScalarFloor(c2_b_u);
  }

  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 23);
  c2_c_b = c2_beta;
  c2_S = 0.1 * c2_c_b;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 24);
  c2_g_x = c2_S;
  c2_M = c2_g_x;
  c2_h_x = c2_M;
  c2_M = c2_h_x;
  c2_c_u = c2_M;
  if (c2_c_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_c_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_c_u);
  }

  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 25);
  if (CV_SCRIPT_IF(10, 2, c2_M == -3.0)) {
    _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 26);
    c2_M = -2.0;
  }

  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 28);
  if (CV_SCRIPT_IF(10, 3, c2_M >= 3.0)) {
    _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 29);
    c2_M = 2.0;
  }

  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 32);
  c2_DB = c2_S - c2_M;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 33);
  c2_i_x = c2_DB;
  c2_j_x = c2_i_x;
  c2_j_x = muDoubleScalarSign(c2_j_x);
  c2_d_b = c2_j_x;
  c2_b_y = 1.1 * c2_d_b;
  c2_k_x = c2_b_y;
  c2_l_x = c2_k_x;
  c2_d_u = c2_l_x;
  if (c2_d_u < 0.0) {
    c2_l_x = muDoubleScalarCeil(c2_d_u);
  } else {
    c2_l_x = muDoubleScalarFloor(c2_d_u);
  }

  c2_N = c2_M + c2_l_x;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 38);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 39);
  c2_L += 3.0;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 40);
  c2_M += 4.0;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 41);
  c2_N += 4.0;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 49);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 50);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 51);
  c2_m_x = c2_DA;
  c2_n_x = c2_m_x;
  c2_c_y = muDoubleScalarAbs(c2_n_x);
  c2_a = c2_c_y;
  c2_e_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_d_y = c2_a * c2_e_b;
  c2_V = c2_T + c2_d_y;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 52);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_e_y = muDoubleScalarAbs(c2_p_x);
  c2_b_a = c2_e_y;
  c2_f_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_f_y = c2_b_a * c2_f_b;
  c2_W = c2_U + c2_f_y;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, 55);
  c2_q_x = c2_DB;
  c2_r_x = c2_q_x;
  c2_g_y = muDoubleScalarAbs(c2_r_x);
  c2_c_a = c2_W - c2_V;
  c2_g_b = c2_g_y;
  c2_h_y = c2_c_a * c2_g_b;
  c2_CoeficienteRollingMomentRudder = c2_V + c2_h_y;
  _SFD_SCRIPT_CALL(10U, chartInstance->c2_sfEvent, -55);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteRollingMomentRudder;
}

static real_T c2_Cm(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_elevator)
{
  real_T c2_CoeficientePitching;
  uint32_T c2_debug_family_var_map[17];
  real_T c2_A[60];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DE;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i23;
  static real_T c2_dv11[60] = { 0.205, 0.081, -0.046, -0.174, -0.259, 0.168,
    0.077, -0.02, -0.145, -0.202, 0.186, 0.107, -0.009, -0.121, -0.184, 0.196,
    0.11, -0.005, -0.127, -0.193, 0.213, 0.11, -0.006, -0.129, -0.199, 0.251,
    0.141, 0.01, -0.102, -0.15, 0.245, 0.127, 0.006, -0.097, -0.16, 0.238, 0.119,
    -0.001, -0.113, -0.167, 0.252, 0.133, 0.014, -0.087, -0.104, 0.231, 0.108,
    0.0, -0.084, -0.076, 0.198, 0.081, -0.013, -0.069, -0.041, 0.192, 0.093,
    0.032, -0.006, -0.005 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_a;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_A;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_b_u;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_b_a;
  real_T c2_b_y;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_c_y;
  real_T c2_c_a;
  real_T c2_b_b;
  real_T c2_d_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_e_y;
  real_T c2_d_a;
  real_T c2_c_b;
  real_T c2_f_y;
  real_T c2_s_x;
  real_T c2_t_x;
  real_T c2_g_y;
  real_T c2_e_a;
  real_T c2_d_b;
  real_T c2_h_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 17U, 17U, c2_m_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_g_sf_marshallOut,
    c2_f_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DE, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_elevator, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficientePitching, 16U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(11, 0);
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 6);
  for (c2_i23 = 0; c2_i23 < 60; c2_i23++) {
    c2_A[c2_i23] = c2_dv11[c2_i23];
  }

  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 21);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 22);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 25);
  if (CV_SCRIPT_IF(11, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 26);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 28);
  if (CV_SCRIPT_IF(11, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 29);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 32);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 34);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_a = c2_d_x;
  c2_y = c2_a * 1.1;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_f_x = muDoubleScalarRound(c2_f_x);
  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 36);
  c2_b_A = c2_elevator;
  c2_g_x = c2_b_A;
  c2_h_x = c2_g_x;
  c2_S = c2_h_x / 12.0;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 37);
  c2_i_x = c2_S;
  c2_M = c2_i_x;
  c2_j_x = c2_M;
  c2_M = c2_j_x;
  c2_b_u = c2_M;
  if (c2_b_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_b_u);
  }

  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 40);
  if (CV_SCRIPT_IF(11, 2, c2_M <= -2.0)) {
    _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 41);
    c2_M = -1.0;
  }

  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 43);
  if (CV_SCRIPT_IF(11, 3, c2_M >= 2.0)) {
    _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 44);
    c2_M = 1.0;
  }

  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 47);
  c2_DE = c2_S - c2_M;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 49);
  c2_k_x = c2_DE;
  c2_l_x = c2_k_x;
  c2_l_x = muDoubleScalarSign(c2_l_x);
  c2_b_a = c2_l_x;
  c2_b_y = c2_b_a * 1.1;
  c2_m_x = c2_b_y;
  c2_n_x = c2_m_x;
  c2_n_x = muDoubleScalarRound(c2_n_x);
  c2_N = c2_M + c2_n_x;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 53);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 54);
  c2_M += 3.0;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 55);
  c2_L += 3.0;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 56);
  c2_N += 3.0;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 64);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 65);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 66);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_c_y = muDoubleScalarAbs(c2_p_x);
  c2_c_a = c2_c_y;
  c2_b_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_d_y = c2_c_a * c2_b_b;
  c2_V = c2_T + c2_d_y;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 67);
  c2_q_x = c2_DA;
  c2_r_x = c2_q_x;
  c2_e_y = muDoubleScalarAbs(c2_r_x);
  c2_d_a = c2_e_y;
  c2_c_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 5, 1, 0) + 5 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_f_y = c2_d_a * c2_c_b;
  c2_W = c2_U + c2_f_y;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, 70);
  c2_s_x = c2_DE;
  c2_t_x = c2_s_x;
  c2_g_y = muDoubleScalarAbs(c2_t_x);
  c2_e_a = c2_W - c2_V;
  c2_d_b = c2_g_y;
  c2_h_y = c2_e_a * c2_d_b;
  c2_CoeficientePitching = c2_V + c2_h_y;
  _SFD_SCRIPT_CALL(11U, chartInstance->c2_sfEvent, -70);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficientePitching;
}

static real_T c2_Cn(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                    c2_alpha, real_T c2_beta)
{
  real_T c2_CoeficienteMomentYawing;
  uint32_T c2_debug_family_var_map[18];
  real_T c2_A[84];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DB;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_DUM;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i24;
  static real_T c2_dv12[84] = { 0.0, 0.018, 0.038, 0.056, 0.064, 0.074, 0.079,
    0.0, 0.019, 0.042, 0.057, 0.077, 0.086, 0.09, 0.0, 0.018, 0.042, 0.059,
    0.076, 0.093, 0.106, 0.0, 0.019, 0.042, 0.058, 0.074, 0.089, 0.106, 0.0,
    0.019, 0.043, 0.058, 0.073, 0.08, 0.096, 0.0, 0.018, 0.039, 0.053, 0.057,
    0.062, 0.08, 0.0, 0.013, 0.03, 0.032, 0.029, 0.049, 0.068, 0.0, 0.007, 0.017,
    0.012, 0.07, 0.022, 0.03, 0.0, 0.004, 0.004, 0.002, 0.012, 0.028, 0.064, 0.0,
    -0.014, -0.035, -0.046, -0.034, -0.012, 0.015, 0.0, -0.017, -0.047, -0.071,
    -0.065, -0.002, 0.011, 0.0, -0.033, -0.057, -0.073, -0.041, -0.013, -0.001 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_u;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_b_y;
  real_T c2_c_b;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_c_u;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_d_b;
  real_T c2_c_y;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_d_u;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_d_y;
  real_T c2_a;
  real_T c2_e_b;
  real_T c2_e_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_f_y;
  real_T c2_b_a;
  real_T c2_f_b;
  real_T c2_g_y;
  real_T c2_s_x;
  real_T c2_t_x;
  real_T c2_h_y;
  real_T c2_c_a;
  real_T c2_g_b;
  real_T c2_i_y;
  real_T c2_u_x;
  real_T c2_v_x;
  real_T c2_d_a;
  real_T c2_h_b;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 18U, 18U, c2_n_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_i_sf_marshallOut,
    c2_h_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DB, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DUM, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 16U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteMomentYawing, 17U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(12, 0);
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 4);
  for (c2_i24 = 0; c2_i24 < 84; c2_i24++) {
    c2_A[c2_i24] = c2_dv12[c2_i24];
  }

  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 12);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 13);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 16);
  if (CV_SCRIPT_IF(12, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 17);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 19);
  if (CV_SCRIPT_IF(12, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 20);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 23);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 24);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_b_b = c2_d_x;
  c2_y = 1.1 * c2_b_b;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_b_u = c2_f_x;
  if (c2_b_u < 0.0) {
    c2_f_x = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_f_x = muDoubleScalarFloor(c2_b_u);
  }

  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 26);
  c2_g_x = c2_beta;
  c2_h_x = c2_g_x;
  c2_b_y = muDoubleScalarAbs(c2_h_x);
  c2_c_b = c2_b_y;
  c2_S = 0.2 * c2_c_b;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 27);
  c2_i_x = c2_S;
  c2_M = c2_i_x;
  c2_j_x = c2_M;
  c2_M = c2_j_x;
  c2_c_u = c2_M;
  if (c2_c_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_c_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_c_u);
  }

  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 29);
  if (CV_SCRIPT_IF(12, 2, c2_M == 0.0)) {
    _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 30);
    c2_M = 1.0;
  }

  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 32);
  if (CV_SCRIPT_IF(12, 3, c2_M >= 6.0)) {
    _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 33);
    c2_M = 5.0;
  }

  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 35);
  c2_DB = c2_S - c2_M;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 36);
  c2_k_x = c2_DB;
  c2_l_x = c2_k_x;
  c2_l_x = muDoubleScalarSign(c2_l_x);
  c2_d_b = c2_l_x;
  c2_c_y = 1.1 * c2_d_b;
  c2_m_x = c2_c_y;
  c2_n_x = c2_m_x;
  c2_d_u = c2_n_x;
  if (c2_d_u < 0.0) {
    c2_n_x = muDoubleScalarCeil(c2_d_u);
  } else {
    c2_n_x = muDoubleScalarFloor(c2_d_u);
  }

  c2_N = c2_M + c2_n_x;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 40);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 41);
  c2_L += 3.0;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 42);
  c2_M++;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 43);
  c2_N++;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 50);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 51);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 52);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_d_y = muDoubleScalarAbs(c2_p_x);
  c2_a = c2_d_y;
  c2_e_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_e_y = c2_a * c2_e_b;
  c2_V = c2_T + c2_e_y;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 53);
  c2_q_x = c2_DA;
  c2_r_x = c2_q_x;
  c2_f_y = muDoubleScalarAbs(c2_r_x);
  c2_b_a = c2_f_y;
  c2_f_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_g_y = c2_b_a * c2_f_b;
  c2_W = c2_U + c2_g_y;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 56);
  c2_s_x = c2_DB;
  c2_t_x = c2_s_x;
  c2_h_y = muDoubleScalarAbs(c2_t_x);
  c2_c_a = c2_W - c2_V;
  c2_g_b = c2_h_y;
  c2_i_y = c2_c_a * c2_g_b;
  c2_DUM = c2_V + c2_i_y;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, 58);
  c2_u_x = c2_beta;
  c2_v_x = c2_u_x;
  c2_v_x = muDoubleScalarSign(c2_v_x);
  c2_d_a = c2_DUM;
  c2_h_b = c2_v_x;
  c2_CoeficienteMomentYawing = c2_d_a * c2_h_b;
  _SFD_SCRIPT_CALL(12U, chartInstance->c2_sfEvent, -58);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteMomentYawing;
}

static real_T c2_Dnda(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta)
{
  real_T c2_CoeficienteYawingMomentAileron;
  uint32_T c2_debug_family_var_map[17];
  real_T c2_A[84];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DB;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i25;
  static real_T c2_dv13[84] = { 0.001, 0.002, -0.006, -0.011, -0.015, -0.024,
    -0.022, -0.027, -0.014, -0.008, -0.011, -0.015, -0.01, 0.002, -0.017, -0.016,
    -0.006, -0.01, -0.014, -0.004, -0.003, -0.013, -0.016, -0.006, -0.009,
    -0.012, -0.002, -0.005, -0.012, -0.014, -0.005, -0.008, -0.011, -0.001,
    -0.003, -0.016, -0.019, -0.008, -0.006, -0.008, 0.003, -0.001, 0.001, -0.021,
    -0.005, 0.0, -0.002, 0.014, -0.009, 0.017, 0.002, 0.007, 0.004, 0.002, 0.006,
    -0.009, 0.011, 0.012, 0.004, 0.007, 0.006, -0.001, -0.001, 0.017, 0.015,
    0.007, 0.01, 0.012, 0.004, 0.003, 0.008, 0.015, 0.006, 0.004, 0.011, 0.004,
    -0.002, 0.016, 0.011, 0.006, 0.01, 0.011, 0.006, 0.001 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_u;
  real_T c2_c_b;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_c_u;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_d_b;
  real_T c2_b_y;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_d_u;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_c_y;
  real_T c2_a;
  real_T c2_e_b;
  real_T c2_d_y;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_e_y;
  real_T c2_b_a;
  real_T c2_f_b;
  real_T c2_f_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_g_y;
  real_T c2_c_a;
  real_T c2_g_b;
  real_T c2_h_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 17U, 17U, c2_o_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_i_sf_marshallOut,
    c2_h_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DB, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteYawingMomentAileron, 16U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(13, 0);
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 4);
  for (c2_i25 = 0; c2_i25 < 84; c2_i25++) {
    c2_A[c2_i25] = c2_dv13[c2_i25];
  }

  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 13);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 14);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 15);
  if (CV_SCRIPT_IF(13, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 16);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 18);
  if (CV_SCRIPT_IF(13, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 19);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 21);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 22);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_b_b = c2_d_x;
  c2_y = 1.1 * c2_b_b;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_b_u = c2_f_x;
  if (c2_b_u < 0.0) {
    c2_f_x = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_f_x = muDoubleScalarFloor(c2_b_u);
  }

  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 24);
  c2_c_b = c2_beta;
  c2_S = 0.1 * c2_c_b;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 25);
  c2_g_x = c2_S;
  c2_M = c2_g_x;
  c2_h_x = c2_M;
  c2_M = c2_h_x;
  c2_c_u = c2_M;
  if (c2_c_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_c_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_c_u);
  }

  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 26);
  if (CV_SCRIPT_IF(13, 2, c2_M == -3.0)) {
    _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 27);
    c2_M = -2.0;
  }

  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 29);
  if (CV_SCRIPT_IF(13, 3, c2_M >= 3.0)) {
    _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 30);
    c2_M = 2.0;
  }

  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 33);
  c2_DB = c2_S - c2_M;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 34);
  c2_i_x = c2_DB;
  c2_j_x = c2_i_x;
  c2_j_x = muDoubleScalarSign(c2_j_x);
  c2_d_b = c2_j_x;
  c2_b_y = 1.1 * c2_d_b;
  c2_k_x = c2_b_y;
  c2_l_x = c2_k_x;
  c2_d_u = c2_l_x;
  if (c2_d_u < 0.0) {
    c2_l_x = muDoubleScalarCeil(c2_d_u);
  } else {
    c2_l_x = muDoubleScalarFloor(c2_d_u);
  }

  c2_N = c2_M + c2_l_x;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 39);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 40);
  c2_L += 3.0;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 41);
  c2_M += 4.0;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 42);
  c2_N += 4.0;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 50);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 51);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 52);
  c2_m_x = c2_DA;
  c2_n_x = c2_m_x;
  c2_c_y = muDoubleScalarAbs(c2_n_x);
  c2_a = c2_c_y;
  c2_e_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_d_y = c2_a * c2_e_b;
  c2_V = c2_T + c2_d_y;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 53);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_e_y = muDoubleScalarAbs(c2_p_x);
  c2_b_a = c2_e_y;
  c2_f_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_f_y = c2_b_a * c2_f_b;
  c2_W = c2_U + c2_f_y;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, 56);
  c2_q_x = c2_DB;
  c2_r_x = c2_q_x;
  c2_g_y = muDoubleScalarAbs(c2_r_x);
  c2_c_a = c2_W - c2_V;
  c2_g_b = c2_g_y;
  c2_h_y = c2_c_a * c2_g_b;
  c2_CoeficienteYawingMomentAileron = c2_V + c2_h_y;
  _SFD_SCRIPT_CALL(13U, chartInstance->c2_sfEvent, -56);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteYawingMomentAileron;
}

static real_T c2_Dndr(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
                      c2_alpha, real_T c2_beta)
{
  real_T c2_CoeficienteYawingMomentRudder;
  uint32_T c2_debug_family_var_map[17];
  real_T c2_A[84];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_M;
  real_T c2_DB;
  real_T c2_N;
  real_T c2_T;
  real_T c2_U;
  real_T c2_V;
  real_T c2_W;
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i26;
  static real_T c2_dv14[84] = { -0.018, -0.028, -0.037, -0.048, -0.043, -0.052,
    -0.062, -0.052, -0.051, -0.041, -0.045, -0.044, -0.034, -0.034, -0.052,
    -0.043, -0.038, -0.045, -0.041, -0.036, -0.027, -0.052, -0.046, -0.04,
    -0.045, -0.041, -0.036, -0.028, -0.054, -0.045, -0.04, -0.044, -0.04, -0.035,
    -0.027, -0.049, -0.049, -0.038, -0.045, -0.038, -0.028, -0.027, -0.059,
    -0.057, -0.037, -0.047, -0.034, -0.024, -0.023, -0.051, -0.052, -0.03,
    -0.048, -0.035, -0.023, -0.023, -0.03, -0.03, -0.027, -0.049, -0.035, -0.02,
    -0.019, -0.037, -0.033, -0.024, -0.045, -0.029, -0.016, -0.009, -0.026,
    -0.03, -0.019, -0.033, -0.022, -0.01, -0.025, -0.013, -0.008, -0.013, -0.016,
    -0.009, -0.014, -0.01 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_b_b;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  real_T c2_b_u;
  real_T c2_c_b;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_c_u;
  real_T c2_i_x;
  real_T c2_j_x;
  real_T c2_d_b;
  real_T c2_b_y;
  real_T c2_k_x;
  real_T c2_l_x;
  real_T c2_d_u;
  real_T c2_m_x;
  real_T c2_n_x;
  real_T c2_c_y;
  real_T c2_a;
  real_T c2_e_b;
  real_T c2_d_y;
  real_T c2_o_x;
  real_T c2_p_x;
  real_T c2_e_y;
  real_T c2_b_a;
  real_T c2_f_b;
  real_T c2_f_y;
  real_T c2_q_x;
  real_T c2_r_x;
  real_T c2_g_y;
  real_T c2_c_a;
  real_T c2_g_b;
  real_T c2_h_y;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 17U, 17U, c2_p_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_i_sf_marshallOut,
    c2_h_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_M, 5U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DB, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_N, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_T, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_U, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_V, 10U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_W, 11U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 12U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 13U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 14U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_beta, 15U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_CoeficienteYawingMomentRudder, 16U,
    c2_c_sf_marshallOut, c2_c_sf_marshallIn);
  CV_SCRIPT_FCN(14, 0);
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 4);
  for (c2_i26 = 0; c2_i26 < 84; c2_i26++) {
    c2_A[c2_i26] = c2_dv14[c2_i26];
  }

  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 12);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 13);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 14);
  if (CV_SCRIPT_IF(14, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 15);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 17);
  if (CV_SCRIPT_IF(14, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 18);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 20);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 21);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_b_b = c2_d_x;
  c2_y = 1.1 * c2_b_b;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_b_u = c2_f_x;
  if (c2_b_u < 0.0) {
    c2_f_x = muDoubleScalarCeil(c2_b_u);
  } else {
    c2_f_x = muDoubleScalarFloor(c2_b_u);
  }

  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 23);
  c2_c_b = c2_beta;
  c2_S = 0.1 * c2_c_b;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 24);
  c2_g_x = c2_S;
  c2_M = c2_g_x;
  c2_h_x = c2_M;
  c2_M = c2_h_x;
  c2_c_u = c2_M;
  if (c2_c_u < 0.0) {
    c2_M = muDoubleScalarCeil(c2_c_u);
  } else {
    c2_M = muDoubleScalarFloor(c2_c_u);
  }

  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 25);
  if (CV_SCRIPT_IF(14, 2, c2_M == -3.0)) {
    _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 26);
    c2_M = -2.0;
  }

  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 28);
  if (CV_SCRIPT_IF(14, 3, c2_M >= 3.0)) {
    _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 29);
    c2_M = 2.0;
  }

  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 32);
  c2_DB = c2_S - c2_M;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 33);
  c2_i_x = c2_DB;
  c2_j_x = c2_i_x;
  c2_j_x = muDoubleScalarSign(c2_j_x);
  c2_d_b = c2_j_x;
  c2_b_y = 1.1 * c2_d_b;
  c2_k_x = c2_b_y;
  c2_l_x = c2_k_x;
  c2_d_u = c2_l_x;
  if (c2_d_u < 0.0) {
    c2_l_x = muDoubleScalarCeil(c2_d_u);
  } else {
    c2_l_x = muDoubleScalarFloor(c2_d_u);
  }

  c2_N = c2_M + c2_l_x;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 37);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 38);
  c2_L += 3.0;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 39);
  c2_M += 4.0;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 40);
  c2_N += 4.0;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 43);
  c2_T = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 44);
  c2_U = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K", c2_K), 1,
    12, 2, 0) - 1)) - 1];
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 45);
  c2_m_x = c2_DA;
  c2_n_x = c2_m_x;
  c2_c_y = muDoubleScalarAbs(c2_n_x);
  c2_a = c2_c_y;
  c2_e_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("M", c2_M), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_T;
  c2_d_y = c2_a * c2_e_b;
  c2_V = c2_T + c2_d_y;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 46);
  c2_o_x = c2_DA;
  c2_p_x = c2_o_x;
  c2_e_y = muDoubleScalarAbs(c2_p_x);
  c2_b_a = c2_e_y;
  c2_f_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
    _SFD_INTEGER_CHECK("N", c2_N), 1, 7, 1, 0) + 7 * ((int32_T)(real_T)
    _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
    12, 2, 0) - 1)) - 1] - c2_U;
  c2_f_y = c2_b_a * c2_f_b;
  c2_W = c2_U + c2_f_y;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, 48);
  c2_q_x = c2_DB;
  c2_r_x = c2_q_x;
  c2_g_y = muDoubleScalarAbs(c2_r_x);
  c2_c_a = c2_W - c2_V;
  c2_g_b = c2_g_y;
  c2_h_y = c2_c_a * c2_g_b;
  c2_CoeficienteYawingMomentRudder = c2_V + c2_h_y;
  _SFD_SCRIPT_CALL(14U, chartInstance->c2_sfEvent, -48);
  _SFD_SYMBOL_SCOPE_POP();
  return c2_CoeficienteYawingMomentRudder;
}

static void c2_Damping(SFc2_F16_SimulinkInstanceStruct *chartInstance, real_T
  c2_alpha, real_T c2_DampCoeficientes[9])
{
  uint32_T c2_debug_family_var_map[11];
  real_T c2_A[108];
  real_T c2_S;
  real_T c2_K;
  real_T c2_DA;
  real_T c2_L;
  real_T c2_D[9];
  real_T c2_I;
  real_T c2_nargin = 1.0;
  real_T c2_nargout = 1.0;
  int32_T c2_i27;
  static real_T c2_dv15[108] = { -0.267, 0.882, -0.108, -8.8, -0.126, -0.36,
    -7.21, -0.38, 0.061, -0.11, 0.852, -0.108, -25.8, 0.026, -0.359, -0.54,
    -0.363, 0.052, 0.308, 0.876, -0.188, -28.9, 0.063, -0.443, -5.23, -0.378,
    0.052, 1.34, 0.958, -0.11, -31.4, 0.113, -0.42, -5.26, -0.386, -0.012, 2.08,
    0.962, 0.258, -31.2, 0.208, -0.383, -6.11, -0.37, -0.013, 2.91, 0.974, 0.226,
    -30.7, 0.23, -0.375, -6.64, -0.453, -0.024, 2.76, 0.819, 0.344, -27.7, 0.319,
    -0.329, -5.69, -0.55, 0.05, 2.05, 0.483, 0.362, -28.2, 0.437, -0.294, -6.0,
    -0.582, 0.15, 1.5, 0.59, 0.611, -29.0, 0.68, -0.23, -6.2, -0.595, 0.13, 1.49,
    1.21, 0.529, -29.8, 0.1, -0.21, -6.4, -0.637, 0.158, 1.83, -0.493, 0.298,
    -38.3, 0.447, -0.12, -6.6, -1.02, 0.24, 1.21, -1.04, -2.27, -35.3, -0.33,
    -0.1, -6.0, -0.84, 0.15 };

  real_T c2_b;
  real_T c2_x;
  real_T c2_b_x;
  real_T c2_u;
  real_T c2_c_x;
  real_T c2_d_x;
  real_T c2_a;
  real_T c2_y;
  real_T c2_e_x;
  real_T c2_f_x;
  int32_T c2_i28;
  int32_T c2_b_I;
  real_T c2_g_x;
  real_T c2_h_x;
  real_T c2_b_y;
  real_T c2_b_a;
  real_T c2_b_b;
  real_T c2_c_y;
  int32_T c2_i29;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 11U, 11U, c2_q_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_A, 0U, c2_j_sf_marshallOut,
    c2_i_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_S, 1U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_K, 2U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_DA, 3U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_L, 4U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_D, 5U, c2_e_sf_marshallOut,
    c2_d_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_I, 6U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 7U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 8U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_alpha, 9U, c2_c_sf_marshallOut,
    c2_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c2_DampCoeficientes, 10U,
    c2_e_sf_marshallOut, c2_d_sf_marshallIn);
  CV_SCRIPT_FCN(15, 0);
  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 5);
  for (c2_i27 = 0; c2_i27 < 108; c2_i27++) {
    c2_A[c2_i27] = c2_dv15[c2_i27];
  }

  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 15);
  c2_b = c2_alpha;
  c2_S = 0.2 * c2_b;
  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 16);
  c2_x = c2_S;
  c2_K = c2_x;
  c2_b_x = c2_K;
  c2_K = c2_b_x;
  c2_u = c2_K;
  if (c2_u < 0.0) {
    c2_K = muDoubleScalarCeil(c2_u);
  } else {
    c2_K = muDoubleScalarFloor(c2_u);
  }

  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 19);
  if (CV_SCRIPT_IF(15, 0, c2_K <= -2.0)) {
    _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 20);
    c2_K = -1.0;
  }

  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 22);
  if (CV_SCRIPT_IF(15, 1, c2_K >= 9.0)) {
    _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 23);
    c2_K = 8.0;
  }

  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 26);
  c2_DA = c2_S - c2_K;
  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 29);
  c2_K += 3.0;
  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 32);
  c2_c_x = c2_DA;
  c2_d_x = c2_c_x;
  c2_d_x = muDoubleScalarSign(c2_d_x);
  c2_a = c2_d_x;
  c2_y = c2_a * 1.1;
  c2_e_x = c2_y;
  c2_f_x = c2_e_x;
  c2_f_x = muDoubleScalarFloor(c2_f_x);
  c2_L = c2_K + c2_f_x;
  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 34);
  for (c2_i28 = 0; c2_i28 < 9; c2_i28++) {
    c2_D[c2_i28] = 0.0;
  }

  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 35);
  c2_I = 1.0;
  c2_b_I = 0;
  while (c2_b_I < 9) {
    c2_I = 1.0 + (real_T)c2_b_I;
    CV_SCRIPT_FOR(15, 0, 1);
    _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 37);
    c2_g_x = c2_DA;
    c2_h_x = c2_g_x;
    c2_b_y = muDoubleScalarAbs(c2_h_x);
    c2_b_a = c2_b_y;
    c2_b_b = c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
      _SFD_INTEGER_CHECK("I", c2_I), 1, 9, 1, 0) + 9 * ((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("L", c2_L), 1,
      12, 2, 0) - 1)) - 1] - c2_A[((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK(
      "A", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1, 9, 1, 0) + 9 * ((int32_T)
      (real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("K",
      c2_K), 1, 12, 2, 0) - 1)) - 1];
    c2_c_y = c2_b_a * c2_b_b;
    c2_D[(int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("D", (int32_T)
      _SFD_INTEGER_CHECK("I", c2_I), 1, 9, 1, 0) - 1] = c2_A[((int32_T)(real_T)
      _SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)_SFD_INTEGER_CHECK("I", c2_I), 1,
      9, 1, 0) + 9 * ((int32_T)(real_T)_SFD_EML_ARRAY_BOUNDS_CHECK("A", (int32_T)
      _SFD_INTEGER_CHECK("K", c2_K), 1, 12, 2, 0) - 1)) - 1] + c2_c_y;
    c2_b_I++;
    _SF_MEX_LISTEN_FOR_CTRL_C(chartInstance->S);
  }

  CV_SCRIPT_FOR(15, 0, 0);
  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, 40);
  for (c2_i29 = 0; c2_i29 < 9; c2_i29++) {
    c2_DampCoeficientes[c2_i29] = c2_D[c2_i29];
  }

  _SFD_SCRIPT_CALL(15U, chartInstance->c2_sfEvent, -40);
  _SFD_SYMBOL_SCOPE_POP();
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber)
{
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 0U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Atmosfera/ADC.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 1U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/TGear.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 2U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/PowerRate.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 3U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/Rtau.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 4U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/Thrust.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 5U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cx.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 6U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cy.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 7U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 8U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cl.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 9U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dlda.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 10U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dldr.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 11U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 12U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cn.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 13U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dnda.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 14U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dndr.m"));
  _SFD_SCRIPT_TRANSLATION(c2_chartNumber, 15U, sf_debug_get_script_id(
    "C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Damping.m"));
}

static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i30;
  real_T c2_b_inData[2];
  int32_T c2_i31;
  real_T c2_u[2];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i30 = 0; c2_i30 < 2; c2_i30++) {
    c2_b_inData[c2_i30] = (*(real_T (*)[2])c2_inData)[c2_i30];
  }

  for (c2_i31 = 0; c2_i31 < 2; c2_i31++) {
    c2_u[c2_i31] = c2_b_inData[c2_i31];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 2), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_y, const char_T *c2_identifier, real_T c2_b_y[2])
{
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_y), &c2_thisId, c2_b_y);
  sf_mex_destroy(&c2_y);
}

static void c2_b_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[2])
{
  real_T c2_dv16[2];
  int32_T c2_i32;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv16, 1, 0, 0U, 1, 0U, 1, 2);
  for (c2_i32 = 0; c2_i32 < 2; c2_i32++) {
    c2_y[c2_i32] = c2_dv16[c2_i32];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_y;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_b_y[2];
  int32_T c2_i33;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_y = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_y), &c2_thisId, c2_b_y);
  sf_mex_destroy(&c2_y);
  for (c2_i33 = 0; c2_i33 < 2; c2_i33++) {
    (*(real_T (*)[2])c2_outData)[c2_i33] = c2_b_y[c2_i33];
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i34;
  real_T c2_b_inData[13];
  int32_T c2_i35;
  real_T c2_u[13];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i34 = 0; c2_i34 < 13; c2_i34++) {
    c2_b_inData[c2_i34] = (*(real_T (*)[13])c2_inData)[c2_i34];
  }

  for (c2_i35 = 0; c2_i35 < 13; c2_i35++) {
    c2_u[c2_i35] = c2_b_inData[c2_i35];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 13), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_c_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_xd, const char_T *c2_identifier, real_T c2_y[13])
{
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_xd), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_xd);
}

static void c2_d_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[13])
{
  real_T c2_dv17[13];
  int32_T c2_i36;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv17, 1, 0, 0U, 1, 0U, 1, 13);
  for (c2_i36 = 0; c2_i36 < 13; c2_i36++) {
    c2_y[c2_i36] = c2_dv17[c2_i36];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_xd;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[13];
  int32_T c2_i37;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_xd = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_xd), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_xd);
  for (c2_i37 = 0; c2_i37 < 13; c2_i37++) {
    (*(real_T (*)[13])c2_outData)[c2_i37] = c2_y[c2_i37];
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_c_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(real_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static const mxArray *c2_d_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i38;
  real_T c2_b_inData[5];
  int32_T c2_i39;
  real_T c2_u[5];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i38 = 0; c2_i38 < 5; c2_i38++) {
    c2_b_inData[c2_i38] = (*(real_T (*)[5])c2_inData)[c2_i38];
  }

  for (c2_i39 = 0; c2_i39 < 5; c2_i39++) {
    c2_u[c2_i39] = c2_b_inData[c2_i39];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 5), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static real_T c2_e_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_nargout;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_nargout = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_nargout), &c2_thisId);
  sf_mex_destroy(&c2_nargout);
  *(real_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_e_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i40;
  real_T c2_b_inData[9];
  int32_T c2_i41;
  real_T c2_u[9];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i40 = 0; c2_i40 < 9; c2_i40++) {
    c2_b_inData[c2_i40] = (*(real_T (*)[9])c2_inData)[c2_i40];
  }

  for (c2_i41 = 0; c2_i41 < 9; c2_i41++) {
    c2_u[c2_i41] = c2_b_inData[c2_i41];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 1, 9), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_f_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[9])
{
  real_T c2_dv18[9];
  int32_T c2_i42;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv18, 1, 0, 0U, 1, 0U, 1, 9);
  for (c2_i42 = 0; c2_i42 < 9; c2_i42++) {
    c2_y[c2_i42] = c2_dv18[c2_i42];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_D;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[9];
  int32_T c2_i43;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_D = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_f_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_D), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_D);
  for (c2_i43 = 0; c2_i43 < 9; c2_i43++) {
    (*(real_T (*)[9])c2_outData)[c2_i43] = c2_y[c2_i43];
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_f_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i44;
  int32_T c2_i45;
  int32_T c2_i46;
  real_T c2_b_inData[36];
  int32_T c2_i47;
  int32_T c2_i48;
  int32_T c2_i49;
  real_T c2_u[36];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_i44 = 0;
  for (c2_i45 = 0; c2_i45 < 6; c2_i45++) {
    for (c2_i46 = 0; c2_i46 < 6; c2_i46++) {
      c2_b_inData[c2_i46 + c2_i44] = (*(real_T (*)[36])c2_inData)[c2_i46 +
        c2_i44];
    }

    c2_i44 += 6;
  }

  c2_i47 = 0;
  for (c2_i48 = 0; c2_i48 < 6; c2_i48++) {
    for (c2_i49 = 0; c2_i49 < 6; c2_i49++) {
      c2_u[c2_i49 + c2_i47] = c2_b_inData[c2_i49 + c2_i47];
    }

    c2_i47 += 6;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 6, 6), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_g_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[36])
{
  real_T c2_dv19[36];
  int32_T c2_i50;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv19, 1, 0, 0U, 1, 0U, 2, 6, 6);
  for (c2_i50 = 0; c2_i50 < 36; c2_i50++) {
    c2_y[c2_i50] = c2_dv19[c2_i50];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_e_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_C;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[36];
  int32_T c2_i51;
  int32_T c2_i52;
  int32_T c2_i53;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_C = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_g_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_C), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_C);
  c2_i51 = 0;
  for (c2_i52 = 0; c2_i52 < 6; c2_i52++) {
    for (c2_i53 = 0; c2_i53 < 6; c2_i53++) {
      (*(real_T (*)[36])c2_outData)[c2_i53 + c2_i51] = c2_y[c2_i53 + c2_i51];
    }

    c2_i51 += 6;
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_g_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i54;
  int32_T c2_i55;
  int32_T c2_i56;
  real_T c2_b_inData[60];
  int32_T c2_i57;
  int32_T c2_i58;
  int32_T c2_i59;
  real_T c2_u[60];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_i54 = 0;
  for (c2_i55 = 0; c2_i55 < 12; c2_i55++) {
    for (c2_i56 = 0; c2_i56 < 5; c2_i56++) {
      c2_b_inData[c2_i56 + c2_i54] = (*(real_T (*)[60])c2_inData)[c2_i56 +
        c2_i54];
    }

    c2_i54 += 5;
  }

  c2_i57 = 0;
  for (c2_i58 = 0; c2_i58 < 12; c2_i58++) {
    for (c2_i59 = 0; c2_i59 < 5; c2_i59++) {
      c2_u[c2_i59 + c2_i57] = c2_b_inData[c2_i59 + c2_i57];
    }

    c2_i57 += 5;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 5, 12), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_h_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[60])
{
  real_T c2_dv20[60];
  int32_T c2_i60;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv20, 1, 0, 0U, 1, 0U, 2, 5,
                12);
  for (c2_i60 = 0; c2_i60 < 60; c2_i60++) {
    c2_y[c2_i60] = c2_dv20[c2_i60];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_f_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_A;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[60];
  int32_T c2_i61;
  int32_T c2_i62;
  int32_T c2_i63;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_A = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_h_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_A), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_A);
  c2_i61 = 0;
  for (c2_i62 = 0; c2_i62 < 12; c2_i62++) {
    for (c2_i63 = 0; c2_i63 < 5; c2_i63++) {
      (*(real_T (*)[60])c2_outData)[c2_i63 + c2_i61] = c2_y[c2_i63 + c2_i61];
    }

    c2_i61 += 5;
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_h_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i64;
  real_T c2_b_inData[12];
  int32_T c2_i65;
  real_T c2_u[12];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  for (c2_i64 = 0; c2_i64 < 12; c2_i64++) {
    c2_b_inData[c2_i64] = (*(real_T (*)[12])c2_inData)[c2_i64];
  }

  for (c2_i65 = 0; c2_i65 < 12; c2_i65++) {
    c2_u[c2_i65] = c2_b_inData[c2_i65];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 1, 12), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_i_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[12])
{
  real_T c2_dv21[12];
  int32_T c2_i66;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv21, 1, 0, 0U, 1, 0U, 2, 1,
                12);
  for (c2_i66 = 0; c2_i66 < 12; c2_i66++) {
    c2_y[c2_i66] = c2_dv21[c2_i66];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_g_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_A;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[12];
  int32_T c2_i67;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_A = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_i_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_A), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_A);
  for (c2_i67 = 0; c2_i67 < 12; c2_i67++) {
    (*(real_T (*)[12])c2_outData)[c2_i67] = c2_y[c2_i67];
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_i_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i68;
  int32_T c2_i69;
  int32_T c2_i70;
  real_T c2_b_inData[84];
  int32_T c2_i71;
  int32_T c2_i72;
  int32_T c2_i73;
  real_T c2_u[84];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_i68 = 0;
  for (c2_i69 = 0; c2_i69 < 12; c2_i69++) {
    for (c2_i70 = 0; c2_i70 < 7; c2_i70++) {
      c2_b_inData[c2_i70 + c2_i68] = (*(real_T (*)[84])c2_inData)[c2_i70 +
        c2_i68];
    }

    c2_i68 += 7;
  }

  c2_i71 = 0;
  for (c2_i72 = 0; c2_i72 < 12; c2_i72++) {
    for (c2_i73 = 0; c2_i73 < 7; c2_i73++) {
      c2_u[c2_i73 + c2_i71] = c2_b_inData[c2_i73 + c2_i71];
    }

    c2_i71 += 7;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 7, 12), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_j_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[84])
{
  real_T c2_dv22[84];
  int32_T c2_i74;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv22, 1, 0, 0U, 1, 0U, 2, 7,
                12);
  for (c2_i74 = 0; c2_i74 < 84; c2_i74++) {
    c2_y[c2_i74] = c2_dv22[c2_i74];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_h_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_A;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[84];
  int32_T c2_i75;
  int32_T c2_i76;
  int32_T c2_i77;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_A = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_j_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_A), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_A);
  c2_i75 = 0;
  for (c2_i76 = 0; c2_i76 < 12; c2_i76++) {
    for (c2_i77 = 0; c2_i77 < 7; c2_i77++) {
      (*(real_T (*)[84])c2_outData)[c2_i77 + c2_i75] = c2_y[c2_i77 + c2_i75];
    }

    c2_i75 += 7;
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

static const mxArray *c2_j_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_i78;
  int32_T c2_i79;
  int32_T c2_i80;
  real_T c2_b_inData[108];
  int32_T c2_i81;
  int32_T c2_i82;
  int32_T c2_i83;
  real_T c2_u[108];
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_i78 = 0;
  for (c2_i79 = 0; c2_i79 < 12; c2_i79++) {
    for (c2_i80 = 0; c2_i80 < 9; c2_i80++) {
      c2_b_inData[c2_i80 + c2_i78] = (*(real_T (*)[108])c2_inData)[c2_i80 +
        c2_i78];
    }

    c2_i78 += 9;
  }

  c2_i81 = 0;
  for (c2_i82 = 0; c2_i82 < 12; c2_i82++) {
    for (c2_i83 = 0; c2_i83 < 9; c2_i83++) {
      c2_u[c2_i83 + c2_i81] = c2_b_inData[c2_i83 + c2_i81];
    }

    c2_i81 += 9;
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 0, 0U, 1U, 0U, 2, 9, 12), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static void c2_k_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct *chartInstance,
  const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId, real_T c2_y[108])
{
  real_T c2_dv23[108];
  int32_T c2_i84;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), c2_dv23, 1, 0, 0U, 1, 0U, 2, 9,
                12);
  for (c2_i84 = 0; c2_i84 < 108; c2_i84++) {
    c2_y[c2_i84] = c2_dv23[c2_i84];
  }

  sf_mex_destroy(&c2_u);
}

static void c2_i_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_A;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y[108];
  int32_T c2_i85;
  int32_T c2_i86;
  int32_T c2_i87;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_A = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_k_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_A), &c2_thisId, c2_y);
  sf_mex_destroy(&c2_A);
  c2_i85 = 0;
  for (c2_i86 = 0; c2_i86 < 12; c2_i86++) {
    for (c2_i87 = 0; c2_i87 < 9; c2_i87++) {
      (*(real_T (*)[108])c2_outData)[c2_i87 + c2_i85] = c2_y[c2_i87 + c2_i85];
    }

    c2_i85 += 9;
  }

  sf_mex_destroy(&c2_mxArrayInData);
}

const mxArray *sf_c2_F16_Simulink_get_eml_resolved_functions_info(void)
{
  const mxArray *c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  sf_mex_assign(&c2_nameCaptureInfo, sf_mex_createstruct("structure", 2, 107, 1),
                FALSE);
  c2_info_helper(&c2_nameCaptureInfo);
  c2_b_info_helper(&c2_nameCaptureInfo);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c2_nameCaptureInfo);
  return c2_nameCaptureInfo;
}

static void c2_info_helper(const mxArray **c2_info)
{
  const mxArray *c2_rhs0 = NULL;
  const mxArray *c2_lhs0 = NULL;
  const mxArray *c2_rhs1 = NULL;
  const mxArray *c2_lhs1 = NULL;
  const mxArray *c2_rhs2 = NULL;
  const mxArray *c2_lhs2 = NULL;
  const mxArray *c2_rhs3 = NULL;
  const mxArray *c2_lhs3 = NULL;
  const mxArray *c2_rhs4 = NULL;
  const mxArray *c2_lhs4 = NULL;
  const mxArray *c2_rhs5 = NULL;
  const mxArray *c2_lhs5 = NULL;
  const mxArray *c2_rhs6 = NULL;
  const mxArray *c2_lhs6 = NULL;
  const mxArray *c2_rhs7 = NULL;
  const mxArray *c2_lhs7 = NULL;
  const mxArray *c2_rhs8 = NULL;
  const mxArray *c2_lhs8 = NULL;
  const mxArray *c2_rhs9 = NULL;
  const mxArray *c2_lhs9 = NULL;
  const mxArray *c2_rhs10 = NULL;
  const mxArray *c2_lhs10 = NULL;
  const mxArray *c2_rhs11 = NULL;
  const mxArray *c2_lhs11 = NULL;
  const mxArray *c2_rhs12 = NULL;
  const mxArray *c2_lhs12 = NULL;
  const mxArray *c2_rhs13 = NULL;
  const mxArray *c2_lhs13 = NULL;
  const mxArray *c2_rhs14 = NULL;
  const mxArray *c2_lhs14 = NULL;
  const mxArray *c2_rhs15 = NULL;
  const mxArray *c2_lhs15 = NULL;
  const mxArray *c2_rhs16 = NULL;
  const mxArray *c2_lhs16 = NULL;
  const mxArray *c2_rhs17 = NULL;
  const mxArray *c2_lhs17 = NULL;
  const mxArray *c2_rhs18 = NULL;
  const mxArray *c2_lhs18 = NULL;
  const mxArray *c2_rhs19 = NULL;
  const mxArray *c2_lhs19 = NULL;
  const mxArray *c2_rhs20 = NULL;
  const mxArray *c2_lhs20 = NULL;
  const mxArray *c2_rhs21 = NULL;
  const mxArray *c2_lhs21 = NULL;
  const mxArray *c2_rhs22 = NULL;
  const mxArray *c2_lhs22 = NULL;
  const mxArray *c2_rhs23 = NULL;
  const mxArray *c2_lhs23 = NULL;
  const mxArray *c2_rhs24 = NULL;
  const mxArray *c2_lhs24 = NULL;
  const mxArray *c2_rhs25 = NULL;
  const mxArray *c2_lhs25 = NULL;
  const mxArray *c2_rhs26 = NULL;
  const mxArray *c2_lhs26 = NULL;
  const mxArray *c2_rhs27 = NULL;
  const mxArray *c2_lhs27 = NULL;
  const mxArray *c2_rhs28 = NULL;
  const mxArray *c2_lhs28 = NULL;
  const mxArray *c2_rhs29 = NULL;
  const mxArray *c2_lhs29 = NULL;
  const mxArray *c2_rhs30 = NULL;
  const mxArray *c2_lhs30 = NULL;
  const mxArray *c2_rhs31 = NULL;
  const mxArray *c2_lhs31 = NULL;
  const mxArray *c2_rhs32 = NULL;
  const mxArray *c2_lhs32 = NULL;
  const mxArray *c2_rhs33 = NULL;
  const mxArray *c2_lhs33 = NULL;
  const mxArray *c2_rhs34 = NULL;
  const mxArray *c2_lhs34 = NULL;
  const mxArray *c2_rhs35 = NULL;
  const mxArray *c2_lhs35 = NULL;
  const mxArray *c2_rhs36 = NULL;
  const mxArray *c2_lhs36 = NULL;
  const mxArray *c2_rhs37 = NULL;
  const mxArray *c2_lhs37 = NULL;
  const mxArray *c2_rhs38 = NULL;
  const mxArray *c2_lhs38 = NULL;
  const mxArray *c2_rhs39 = NULL;
  const mxArray *c2_lhs39 = NULL;
  const mxArray *c2_rhs40 = NULL;
  const mxArray *c2_lhs40 = NULL;
  const mxArray *c2_rhs41 = NULL;
  const mxArray *c2_lhs41 = NULL;
  const mxArray *c2_rhs42 = NULL;
  const mxArray *c2_lhs42 = NULL;
  const mxArray *c2_rhs43 = NULL;
  const mxArray *c2_lhs43 = NULL;
  const mxArray *c2_rhs44 = NULL;
  const mxArray *c2_lhs44 = NULL;
  const mxArray *c2_rhs45 = NULL;
  const mxArray *c2_lhs45 = NULL;
  const mxArray *c2_rhs46 = NULL;
  const mxArray *c2_lhs46 = NULL;
  const mxArray *c2_rhs47 = NULL;
  const mxArray *c2_lhs47 = NULL;
  const mxArray *c2_rhs48 = NULL;
  const mxArray *c2_lhs48 = NULL;
  const mxArray *c2_rhs49 = NULL;
  const mxArray *c2_lhs49 = NULL;
  const mxArray *c2_rhs50 = NULL;
  const mxArray *c2_lhs50 = NULL;
  const mxArray *c2_rhs51 = NULL;
  const mxArray *c2_lhs51 = NULL;
  const mxArray *c2_rhs52 = NULL;
  const mxArray *c2_lhs52 = NULL;
  const mxArray *c2_rhs53 = NULL;
  const mxArray *c2_lhs53 = NULL;
  const mxArray *c2_rhs54 = NULL;
  const mxArray *c2_lhs54 = NULL;
  const mxArray *c2_rhs55 = NULL;
  const mxArray *c2_lhs55 = NULL;
  const mxArray *c2_rhs56 = NULL;
  const mxArray *c2_lhs56 = NULL;
  const mxArray *c2_rhs57 = NULL;
  const mxArray *c2_lhs57 = NULL;
  const mxArray *c2_rhs58 = NULL;
  const mxArray *c2_lhs58 = NULL;
  const mxArray *c2_rhs59 = NULL;
  const mxArray *c2_lhs59 = NULL;
  const mxArray *c2_rhs60 = NULL;
  const mxArray *c2_lhs60 = NULL;
  const mxArray *c2_rhs61 = NULL;
  const mxArray *c2_lhs61 = NULL;
  const mxArray *c2_rhs62 = NULL;
  const mxArray *c2_lhs62 = NULL;
  const mxArray *c2_rhs63 = NULL;
  const mxArray *c2_lhs63 = NULL;
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 0);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 0);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 0);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 0);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 0);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 0);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 0);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 0);
  sf_mex_assign(&c2_rhs0, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs0, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs0), "rhs", "rhs", 0);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs0), "lhs", "lhs", 0);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m!common_checks"),
                  "context", "context", 1);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 1);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 1);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 1);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 1);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 1);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 1);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 1);
  sf_mex_assign(&c2_rhs1, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs1, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs1), "rhs", "rhs", 1);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs1), "lhs", "lhs", 1);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 2);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mrdivide"), "name", "name", 2);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 2);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p"), "resolved",
                  "resolved", 2);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1373324508U), "fileTimeLo",
                  "fileTimeLo", 2);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 2);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1319744366U), "mFileTimeLo",
                  "mFileTimeLo", 2);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 2);
  sf_mex_assign(&c2_rhs2, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs2, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs2), "rhs", "rhs", 2);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs2), "lhs", "lhs", 2);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p"), "context",
                  "context", 3);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("rdivide"), "name", "name", 3);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 3);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m"), "resolved",
                  "resolved", 3);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728280U), "fileTimeLo",
                  "fileTimeLo", 3);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 3);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 3);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 3);
  sf_mex_assign(&c2_rhs3, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs3, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs3), "rhs", "rhs", 3);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs3), "lhs", "lhs", 3);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m"), "context",
                  "context", 4);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 4);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 4);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 4);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 4);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 4);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 4);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 4);
  sf_mex_assign(&c2_rhs4, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs4, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs4), "rhs", "rhs", 4);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs4), "lhs", "lhs", 4);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m"), "context",
                  "context", 5);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalexp_compatible"),
                  "name", "name", 5);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 5);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_compatible.m"),
                  "resolved", "resolved", 5);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836796U), "fileTimeLo",
                  "fileTimeLo", 5);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 5);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 5);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 5);
  sf_mex_assign(&c2_rhs5, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs5, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs5), "rhs", "rhs", 5);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs5), "lhs", "lhs", 5);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m"), "context",
                  "context", 6);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_div"), "name", "name", 6);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 6);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_div.m"), "resolved",
                  "resolved", 6);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728266U), "fileTimeLo",
                  "fileTimeLo", 6);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 6);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 6);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 6);
  sf_mex_assign(&c2_rhs6, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs6, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs6), "rhs", "rhs", 6);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs6), "lhs", "lhs", 6);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 7);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("ADC"), "name", "name", 7);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 7);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Atmosfera/ADC.m"),
                  "resolved", "resolved", 7);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1493313472U), "fileTimeLo",
                  "fileTimeLo", 7);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 7);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 7);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 7);
  sf_mex_assign(&c2_rhs7, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs7, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs7), "rhs", "rhs", 7);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs7), "lhs", "lhs", 7);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Atmosfera/ADC.m"),
                  "context", "context", 8);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 8);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 8);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 8);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 8);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 8);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 8);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 8);
  sf_mex_assign(&c2_rhs8, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs8, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs8), "rhs", "rhs", 8);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs8), "lhs", "lhs", 8);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Atmosfera/ADC.m"),
                  "context", "context", 9);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mpower"), "name", "name", 9);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 9);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m"), "resolved",
                  "resolved", 9);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 9);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 9);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 9);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 9);
  sf_mex_assign(&c2_rhs9, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs9, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs9), "rhs", "rhs", 9);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs9), "lhs", "lhs", 9);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m"), "context",
                  "context", 10);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 10);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 10);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 10);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 10);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 10);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 10);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 10);
  sf_mex_assign(&c2_rhs10, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs10, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs10), "rhs", "rhs",
                  10);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs10), "lhs", "lhs",
                  10);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m"), "context",
                  "context", 11);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("ismatrix"), "name", "name", 11);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 11);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/ismatrix.m"), "resolved",
                  "resolved", 11);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1331319258U), "fileTimeLo",
                  "fileTimeLo", 11);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 11);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 11);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 11);
  sf_mex_assign(&c2_rhs11, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs11, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs11), "rhs", "rhs",
                  11);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs11), "lhs", "lhs",
                  11);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m"), "context",
                  "context", 12);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("power"), "name", "name", 12);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 12);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m"), "resolved",
                  "resolved", 12);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728280U), "fileTimeLo",
                  "fileTimeLo", 12);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 12);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 12);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 12);
  sf_mex_assign(&c2_rhs12, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs12, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs12), "rhs", "rhs",
                  12);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs12), "lhs", "lhs",
                  12);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m"), "context",
                  "context", 13);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 13);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 13);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 13);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 13);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 13);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 13);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 13);
  sf_mex_assign(&c2_rhs13, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs13, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs13), "rhs", "rhs",
                  13);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs13), "lhs", "lhs",
                  13);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower"), "context",
                  "context", 14);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_eg"), "name",
                  "name", 14);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 14);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m"), "resolved",
                  "resolved", 14);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836796U), "fileTimeLo",
                  "fileTimeLo", 14);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 14);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 14);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 14);
  sf_mex_assign(&c2_rhs14, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs14, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs14), "rhs", "rhs",
                  14);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs14), "lhs", "lhs",
                  14);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower"), "context",
                  "context", 15);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalexp_alloc"), "name",
                  "name", 15);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 15);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m"),
                  "resolved", "resolved", 15);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1358196940U), "fileTimeLo",
                  "fileTimeLo", 15);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 15);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 15);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 15);
  sf_mex_assign(&c2_rhs15, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs15, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs15), "rhs", "rhs",
                  15);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs15), "lhs", "lhs",
                  15);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower"), "context",
                  "context", 16);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("floor"), "name", "name", 16);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 16);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m"), "resolved",
                  "resolved", 16);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728254U), "fileTimeLo",
                  "fileTimeLo", 16);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 16);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 16);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 16);
  sf_mex_assign(&c2_rhs16, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs16, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs16), "rhs", "rhs",
                  16);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs16), "lhs", "lhs",
                  16);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m"), "context",
                  "context", 17);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 17);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 17);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 17);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 17);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 17);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 17);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 17);
  sf_mex_assign(&c2_rhs17, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs17, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs17), "rhs", "rhs",
                  17);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs17), "lhs", "lhs",
                  17);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m"), "context",
                  "context", 18);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_floor"), "name",
                  "name", 18);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 18);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_floor.m"),
                  "resolved", "resolved", 18);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836726U), "fileTimeLo",
                  "fileTimeLo", 18);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 18);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 18);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 18);
  sf_mex_assign(&c2_rhs18, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs18, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs18), "rhs", "rhs",
                  18);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs18), "lhs", "lhs",
                  18);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower"), "context",
                  "context", 19);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_error"), "name", "name",
                  19);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("char"), "dominantType",
                  "dominantType", 19);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_error.m"), "resolved",
                  "resolved", 19);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1343848358U), "fileTimeLo",
                  "fileTimeLo", 19);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 19);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 19);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 19);
  sf_mex_assign(&c2_rhs19, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs19, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs19), "rhs", "rhs",
                  19);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs19), "lhs", "lhs",
                  19);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power"),
                  "context", "context", 20);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_eg"), "name",
                  "name", 20);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 20);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m"), "resolved",
                  "resolved", 20);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836796U), "fileTimeLo",
                  "fileTimeLo", 20);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 20);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 20);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 20);
  sf_mex_assign(&c2_rhs20, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs20, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs20), "rhs", "rhs",
                  20);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs20), "lhs", "lhs",
                  20);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Atmosfera/ADC.m"),
                  "context", "context", 21);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sqrt"), "name", "name", 21);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 21);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m"), "resolved",
                  "resolved", 21);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1343848386U), "fileTimeLo",
                  "fileTimeLo", 21);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 21);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 21);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 21);
  sf_mex_assign(&c2_rhs21, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs21, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs21), "rhs", "rhs",
                  21);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs21), "lhs", "lhs",
                  21);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m"), "context",
                  "context", 22);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_error"), "name", "name",
                  22);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("char"), "dominantType",
                  "dominantType", 22);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_error.m"), "resolved",
                  "resolved", 22);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1343848358U), "fileTimeLo",
                  "fileTimeLo", 22);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 22);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 22);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 22);
  sf_mex_assign(&c2_rhs22, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs22, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs22), "rhs", "rhs",
                  22);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs22), "lhs", "lhs",
                  22);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m"), "context",
                  "context", 23);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_sqrt"), "name",
                  "name", 23);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 23);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_sqrt.m"),
                  "resolved", "resolved", 23);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836738U), "fileTimeLo",
                  "fileTimeLo", 23);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 23);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 23);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 23);
  sf_mex_assign(&c2_rhs23, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs23, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs23), "rhs", "rhs",
                  23);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs23), "lhs", "lhs",
                  23);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Atmosfera/ADC.m"),
                  "context", "context", 24);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mrdivide"), "name", "name", 24);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 24);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p"), "resolved",
                  "resolved", 24);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1373324508U), "fileTimeLo",
                  "fileTimeLo", 24);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 24);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1319744366U), "mFileTimeLo",
                  "mFileTimeLo", 24);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 24);
  sf_mex_assign(&c2_rhs24, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs24, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs24), "rhs", "rhs",
                  24);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs24), "lhs", "lhs",
                  24);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 25);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("TGear"), "name", "name", 25);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 25);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/TGear.m"),
                  "resolved", "resolved", 25);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1439384447U), "fileTimeLo",
                  "fileTimeLo", 25);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 25);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 25);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 25);
  sf_mex_assign(&c2_rhs25, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs25, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs25), "rhs", "rhs",
                  25);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs25), "lhs", "lhs",
                  25);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/TGear.m"),
                  "context", "context", 26);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 26);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 26);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 26);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 26);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 26);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 26);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 26);
  sf_mex_assign(&c2_rhs26, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs26, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs26), "rhs", "rhs",
                  26);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs26), "lhs", "lhs",
                  26);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 27);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("PowerRate"), "name", "name",
                  27);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 27);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/PowerRate.m"),
                  "resolved", "resolved", 27);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1506512061U), "fileTimeLo",
                  "fileTimeLo", 27);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 27);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 27);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 27);
  sf_mex_assign(&c2_rhs27, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs27, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs27), "rhs", "rhs",
                  27);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs27), "lhs", "lhs",
                  27);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/PowerRate.m"),
                  "context", "context", 28);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Rtau"), "name", "name", 28);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 28);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/Rtau.m"),
                  "resolved", "resolved", 28);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1439384447U), "fileTimeLo",
                  "fileTimeLo", 28);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 28);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 28);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 28);
  sf_mex_assign(&c2_rhs28, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs28, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs28), "rhs", "rhs",
                  28);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs28), "lhs", "lhs",
                  28);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/Rtau.m"),
                  "context", "context", 29);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 29);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 29);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 29);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 29);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 29);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 29);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 29);
  sf_mex_assign(&c2_rhs29, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs29, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs29), "rhs", "rhs",
                  29);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs29), "lhs", "lhs",
                  29);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/PowerRate.m"),
                  "context", "context", 30);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 30);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 30);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 30);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 30);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 30);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 30);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 30);
  sf_mex_assign(&c2_rhs30, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs30, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs30), "rhs", "rhs",
                  30);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs30), "lhs", "lhs",
                  30);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 31);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Thrust"), "name", "name", 31);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 31);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/Thrust.m"),
                  "resolved", "resolved", 31);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1506512420U), "fileTimeLo",
                  "fileTimeLo", 31);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 31);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 31);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 31);
  sf_mex_assign(&c2_rhs31, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs31, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs31), "rhs", "rhs",
                  31);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs31), "lhs", "lhs",
                  31);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/Thrust.m"),
                  "context", "context", 32);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 32);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 32);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 32);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 32);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 32);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 32);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 32);
  sf_mex_assign(&c2_rhs32, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs32, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs32), "rhs", "rhs",
                  32);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs32), "lhs", "lhs",
                  32);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/Turbina/Thrust.m"),
                  "context", "context", 33);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 33);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 33);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 33);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 33);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 33);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 33);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 33);
  sf_mex_assign(&c2_rhs33, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs33, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs33), "rhs", "rhs",
                  33);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs33), "lhs", "lhs",
                  33);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "context",
                  "context", 34);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 34);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 34);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 34);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 34);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 34);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 34);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 34);
  sf_mex_assign(&c2_rhs34, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs34, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs34), "rhs", "rhs",
                  34);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs34), "lhs", "lhs",
                  34);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "context",
                  "context", 35);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_fix"), "name",
                  "name", 35);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 35);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_fix.m"),
                  "resolved", "resolved", 35);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1307669238U), "fileTimeLo",
                  "fileTimeLo", 35);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 35);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 35);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 35);
  sf_mex_assign(&c2_rhs35, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs35, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs35), "rhs", "rhs",
                  35);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs35), "lhs", "lhs",
                  35);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 36);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Cx"), "name", "name", 36);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 36);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cx.m"),
                  "resolved", "resolved", 36);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1493212603U), "fileTimeLo",
                  "fileTimeLo", 36);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 36);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 36);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 36);
  sf_mex_assign(&c2_rhs36, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs36, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs36), "rhs", "rhs",
                  36);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs36), "lhs", "lhs",
                  36);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cx.m"),
                  "context", "context", 37);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 37);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 37);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 37);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 37);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 37);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 37);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 37);
  sf_mex_assign(&c2_rhs37, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs37, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs37), "rhs", "rhs",
                  37);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs37), "lhs", "lhs",
                  37);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cx.m"),
                  "context", "context", 38);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 38);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 38);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 38);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 38);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 38);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 38);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 38);
  sf_mex_assign(&c2_rhs38, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs38, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs38), "rhs", "rhs",
                  38);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs38), "lhs", "lhs",
                  38);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cx.m"),
                  "context", "context", 39);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 39);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 39);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 39);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 39);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 39);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 39);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 39);
  sf_mex_assign(&c2_rhs39, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs39, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs39), "rhs", "rhs",
                  39);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs39), "lhs", "lhs",
                  39);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "context",
                  "context", 40);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 40);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 40);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 40);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 40);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 40);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 40);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 40);
  sf_mex_assign(&c2_rhs40, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs40, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs40), "rhs", "rhs",
                  40);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs40), "lhs", "lhs",
                  40);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "context",
                  "context", 41);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_sign"), "name",
                  "name", 41);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 41);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_sign.m"),
                  "resolved", "resolved", 41);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1356552294U), "fileTimeLo",
                  "fileTimeLo", 41);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 41);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 41);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 41);
  sf_mex_assign(&c2_rhs41, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs41, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs41), "rhs", "rhs",
                  41);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs41), "lhs", "lhs",
                  41);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cx.m"),
                  "context", "context", 42);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mrdivide"), "name", "name", 42);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 42);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p"), "resolved",
                  "resolved", 42);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1373324508U), "fileTimeLo",
                  "fileTimeLo", 42);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 42);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1319744366U), "mFileTimeLo",
                  "mFileTimeLo", 42);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 42);
  sf_mex_assign(&c2_rhs42, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs42, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs42), "rhs", "rhs",
                  42);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs42), "lhs", "lhs",
                  42);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cx.m"),
                  "context", "context", 43);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 43);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 43);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 43);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 43);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 43);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 43);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 43);
  sf_mex_assign(&c2_rhs43, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs43, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs43), "rhs", "rhs",
                  43);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs43), "lhs", "lhs",
                  43);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "context",
                  "context", 44);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 44);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 44);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 44);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 44);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 44);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 44);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 44);
  sf_mex_assign(&c2_rhs44, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs44, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs44), "rhs", "rhs",
                  44);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs44), "lhs", "lhs",
                  44);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "context",
                  "context", 45);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_abs"), "name",
                  "name", 45);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 45);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_abs.m"),
                  "resolved", "resolved", 45);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836712U), "fileTimeLo",
                  "fileTimeLo", 45);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 45);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 45);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 45);
  sf_mex_assign(&c2_rhs45, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs45, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs45), "rhs", "rhs",
                  45);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs45), "lhs", "lhs",
                  45);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 46);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Cy"), "name", "name", 46);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 46);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cy.m"),
                  "resolved", "resolved", 46);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1439384447U), "fileTimeLo",
                  "fileTimeLo", 46);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 46);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 46);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 46);
  sf_mex_assign(&c2_rhs46, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs46, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs46), "rhs", "rhs",
                  46);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs46), "lhs", "lhs",
                  46);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cy.m"),
                  "context", "context", 47);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 47);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 47);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 47);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 47);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 47);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 47);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 47);
  sf_mex_assign(&c2_rhs47, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs47, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs47), "rhs", "rhs",
                  47);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs47), "lhs", "lhs",
                  47);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cy.m"),
                  "context", "context", 48);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mrdivide"), "name", "name", 48);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 48);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p"), "resolved",
                  "resolved", 48);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1373324508U), "fileTimeLo",
                  "fileTimeLo", 48);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 48);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1319744366U), "mFileTimeLo",
                  "mFileTimeLo", 48);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 48);
  sf_mex_assign(&c2_rhs48, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs48, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs48), "rhs", "rhs",
                  48);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs48), "lhs", "lhs",
                  48);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 49);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Cz"), "name", "name", 49);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 49);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "resolved", "resolved", 49);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1493212635U), "fileTimeLo",
                  "fileTimeLo", 49);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 49);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 49);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 49);
  sf_mex_assign(&c2_rhs49, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs49, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs49), "rhs", "rhs",
                  49);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs49), "lhs", "lhs",
                  49);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "context", "context", 50);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 50);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 50);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 50);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 50);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 50);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 50);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 50);
  sf_mex_assign(&c2_rhs50, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs50, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs50), "rhs", "rhs",
                  50);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs50), "lhs", "lhs",
                  50);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "context", "context", 51);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 51);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 51);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 51);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 51);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 51);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 51);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 51);
  sf_mex_assign(&c2_rhs51, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs51, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs51), "rhs", "rhs",
                  51);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs51), "lhs", "lhs",
                  51);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "context", "context", 52);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 52);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 52);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 52);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 52);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 52);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 52);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 52);
  sf_mex_assign(&c2_rhs52, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs52, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs52), "rhs", "rhs",
                  52);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs52), "lhs", "lhs",
                  52);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "context", "context", 53);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("round"), "name", "name", 53);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 53);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/round.m"), "resolved",
                  "resolved", 53);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728254U), "fileTimeLo",
                  "fileTimeLo", 53);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 53);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 53);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 53);
  sf_mex_assign(&c2_rhs53, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs53, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs53), "rhs", "rhs",
                  53);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs53), "lhs", "lhs",
                  53);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/round.m"), "context",
                  "context", 54);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "coder.internal.isBuiltInNumeric"), "name", "name", 54);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 54);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[IXE]$matlabroot$/toolbox/shared/coder/coder/+coder/+internal/isBuiltInNumeric.m"),
                  "resolved", "resolved", 54);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728956U), "fileTimeLo",
                  "fileTimeLo", 54);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 54);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 54);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 54);
  sf_mex_assign(&c2_rhs54, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs54, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs54), "rhs", "rhs",
                  54);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs54), "lhs", "lhs",
                  54);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/round.m"), "context",
                  "context", 55);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_round"), "name",
                  "name", 55);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 55);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_round.m"),
                  "resolved", "resolved", 55);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1307669238U), "fileTimeLo",
                  "fileTimeLo", 55);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 55);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 55);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 55);
  sf_mex_assign(&c2_rhs55, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs55, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs55), "rhs", "rhs",
                  55);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs55), "lhs", "lhs",
                  55);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "context", "context", 56);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 56);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 56);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 56);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 56);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 56);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 56);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 56);
  sf_mex_assign(&c2_rhs56, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs56, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs56), "rhs", "rhs",
                  56);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs56), "lhs", "lhs",
                  56);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "context", "context", 57);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mrdivide"), "name", "name", 57);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 57);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p"), "resolved",
                  "resolved", 57);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1373324508U), "fileTimeLo",
                  "fileTimeLo", 57);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 57);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1319744366U), "mFileTimeLo",
                  "mFileTimeLo", 57);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 57);
  sf_mex_assign(&c2_rhs57, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs57, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs57), "rhs", "rhs",
                  57);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs57), "lhs", "lhs",
                  57);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cz.m"),
                  "context", "context", 58);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mpower"), "name", "name", 58);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 58);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m"), "resolved",
                  "resolved", 58);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 58);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 58);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 58);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 58);
  sf_mex_assign(&c2_rhs58, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs58, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs58), "rhs", "rhs",
                  58);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs58), "lhs", "lhs",
                  58);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power"),
                  "context", "context", 59);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 59);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 59);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 59);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 59);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 59);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 59);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 59);
  sf_mex_assign(&c2_rhs59, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs59, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs59), "rhs", "rhs",
                  59);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs59), "lhs", "lhs",
                  59);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 60);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Cl"), "name", "name", 60);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 60);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cl.m"),
                  "resolved", "resolved", 60);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1493314355U), "fileTimeLo",
                  "fileTimeLo", 60);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 60);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 60);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 60);
  sf_mex_assign(&c2_rhs60, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs60, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs60), "rhs", "rhs",
                  60);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs60), "lhs", "lhs",
                  60);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cl.m"),
                  "context", "context", 61);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 61);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 61);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 61);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 61);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 61);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 61);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 61);
  sf_mex_assign(&c2_rhs61, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs61, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs61), "rhs", "rhs",
                  61);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs61), "lhs", "lhs",
                  61);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cl.m"),
                  "context", "context", 62);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 62);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 62);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 62);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 62);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 62);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 62);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 62);
  sf_mex_assign(&c2_rhs62, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs62, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs62), "rhs", "rhs",
                  62);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs62), "lhs", "lhs",
                  62);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cl.m"),
                  "context", "context", 63);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 63);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 63);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 63);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 63);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 63);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 63);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 63);
  sf_mex_assign(&c2_rhs63, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs63, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs63), "rhs", "rhs",
                  63);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs63), "lhs", "lhs",
                  63);
  sf_mex_destroy(&c2_rhs0);
  sf_mex_destroy(&c2_lhs0);
  sf_mex_destroy(&c2_rhs1);
  sf_mex_destroy(&c2_lhs1);
  sf_mex_destroy(&c2_rhs2);
  sf_mex_destroy(&c2_lhs2);
  sf_mex_destroy(&c2_rhs3);
  sf_mex_destroy(&c2_lhs3);
  sf_mex_destroy(&c2_rhs4);
  sf_mex_destroy(&c2_lhs4);
  sf_mex_destroy(&c2_rhs5);
  sf_mex_destroy(&c2_lhs5);
  sf_mex_destroy(&c2_rhs6);
  sf_mex_destroy(&c2_lhs6);
  sf_mex_destroy(&c2_rhs7);
  sf_mex_destroy(&c2_lhs7);
  sf_mex_destroy(&c2_rhs8);
  sf_mex_destroy(&c2_lhs8);
  sf_mex_destroy(&c2_rhs9);
  sf_mex_destroy(&c2_lhs9);
  sf_mex_destroy(&c2_rhs10);
  sf_mex_destroy(&c2_lhs10);
  sf_mex_destroy(&c2_rhs11);
  sf_mex_destroy(&c2_lhs11);
  sf_mex_destroy(&c2_rhs12);
  sf_mex_destroy(&c2_lhs12);
  sf_mex_destroy(&c2_rhs13);
  sf_mex_destroy(&c2_lhs13);
  sf_mex_destroy(&c2_rhs14);
  sf_mex_destroy(&c2_lhs14);
  sf_mex_destroy(&c2_rhs15);
  sf_mex_destroy(&c2_lhs15);
  sf_mex_destroy(&c2_rhs16);
  sf_mex_destroy(&c2_lhs16);
  sf_mex_destroy(&c2_rhs17);
  sf_mex_destroy(&c2_lhs17);
  sf_mex_destroy(&c2_rhs18);
  sf_mex_destroy(&c2_lhs18);
  sf_mex_destroy(&c2_rhs19);
  sf_mex_destroy(&c2_lhs19);
  sf_mex_destroy(&c2_rhs20);
  sf_mex_destroy(&c2_lhs20);
  sf_mex_destroy(&c2_rhs21);
  sf_mex_destroy(&c2_lhs21);
  sf_mex_destroy(&c2_rhs22);
  sf_mex_destroy(&c2_lhs22);
  sf_mex_destroy(&c2_rhs23);
  sf_mex_destroy(&c2_lhs23);
  sf_mex_destroy(&c2_rhs24);
  sf_mex_destroy(&c2_lhs24);
  sf_mex_destroy(&c2_rhs25);
  sf_mex_destroy(&c2_lhs25);
  sf_mex_destroy(&c2_rhs26);
  sf_mex_destroy(&c2_lhs26);
  sf_mex_destroy(&c2_rhs27);
  sf_mex_destroy(&c2_lhs27);
  sf_mex_destroy(&c2_rhs28);
  sf_mex_destroy(&c2_lhs28);
  sf_mex_destroy(&c2_rhs29);
  sf_mex_destroy(&c2_lhs29);
  sf_mex_destroy(&c2_rhs30);
  sf_mex_destroy(&c2_lhs30);
  sf_mex_destroy(&c2_rhs31);
  sf_mex_destroy(&c2_lhs31);
  sf_mex_destroy(&c2_rhs32);
  sf_mex_destroy(&c2_lhs32);
  sf_mex_destroy(&c2_rhs33);
  sf_mex_destroy(&c2_lhs33);
  sf_mex_destroy(&c2_rhs34);
  sf_mex_destroy(&c2_lhs34);
  sf_mex_destroy(&c2_rhs35);
  sf_mex_destroy(&c2_lhs35);
  sf_mex_destroy(&c2_rhs36);
  sf_mex_destroy(&c2_lhs36);
  sf_mex_destroy(&c2_rhs37);
  sf_mex_destroy(&c2_lhs37);
  sf_mex_destroy(&c2_rhs38);
  sf_mex_destroy(&c2_lhs38);
  sf_mex_destroy(&c2_rhs39);
  sf_mex_destroy(&c2_lhs39);
  sf_mex_destroy(&c2_rhs40);
  sf_mex_destroy(&c2_lhs40);
  sf_mex_destroy(&c2_rhs41);
  sf_mex_destroy(&c2_lhs41);
  sf_mex_destroy(&c2_rhs42);
  sf_mex_destroy(&c2_lhs42);
  sf_mex_destroy(&c2_rhs43);
  sf_mex_destroy(&c2_lhs43);
  sf_mex_destroy(&c2_rhs44);
  sf_mex_destroy(&c2_lhs44);
  sf_mex_destroy(&c2_rhs45);
  sf_mex_destroy(&c2_lhs45);
  sf_mex_destroy(&c2_rhs46);
  sf_mex_destroy(&c2_lhs46);
  sf_mex_destroy(&c2_rhs47);
  sf_mex_destroy(&c2_lhs47);
  sf_mex_destroy(&c2_rhs48);
  sf_mex_destroy(&c2_lhs48);
  sf_mex_destroy(&c2_rhs49);
  sf_mex_destroy(&c2_lhs49);
  sf_mex_destroy(&c2_rhs50);
  sf_mex_destroy(&c2_lhs50);
  sf_mex_destroy(&c2_rhs51);
  sf_mex_destroy(&c2_lhs51);
  sf_mex_destroy(&c2_rhs52);
  sf_mex_destroy(&c2_lhs52);
  sf_mex_destroy(&c2_rhs53);
  sf_mex_destroy(&c2_lhs53);
  sf_mex_destroy(&c2_rhs54);
  sf_mex_destroy(&c2_lhs54);
  sf_mex_destroy(&c2_rhs55);
  sf_mex_destroy(&c2_lhs55);
  sf_mex_destroy(&c2_rhs56);
  sf_mex_destroy(&c2_lhs56);
  sf_mex_destroy(&c2_rhs57);
  sf_mex_destroy(&c2_lhs57);
  sf_mex_destroy(&c2_rhs58);
  sf_mex_destroy(&c2_lhs58);
  sf_mex_destroy(&c2_rhs59);
  sf_mex_destroy(&c2_lhs59);
  sf_mex_destroy(&c2_rhs60);
  sf_mex_destroy(&c2_lhs60);
  sf_mex_destroy(&c2_rhs61);
  sf_mex_destroy(&c2_lhs61);
  sf_mex_destroy(&c2_rhs62);
  sf_mex_destroy(&c2_lhs62);
  sf_mex_destroy(&c2_rhs63);
  sf_mex_destroy(&c2_lhs63);
}

static const mxArray *c2_emlrt_marshallOut(char * c2_u)
{
  const mxArray *c2_y = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 15, 0U, 0U, 0U, 2, 1, strlen
    (c2_u)), FALSE);
  return c2_y;
}

static const mxArray *c2_b_emlrt_marshallOut(uint32_T c2_u)
{
  const mxArray *c2_y = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 7, 0U, 0U, 0U, 0), FALSE);
  return c2_y;
}

static void c2_b_info_helper(const mxArray **c2_info)
{
  const mxArray *c2_rhs64 = NULL;
  const mxArray *c2_lhs64 = NULL;
  const mxArray *c2_rhs65 = NULL;
  const mxArray *c2_lhs65 = NULL;
  const mxArray *c2_rhs66 = NULL;
  const mxArray *c2_lhs66 = NULL;
  const mxArray *c2_rhs67 = NULL;
  const mxArray *c2_lhs67 = NULL;
  const mxArray *c2_rhs68 = NULL;
  const mxArray *c2_lhs68 = NULL;
  const mxArray *c2_rhs69 = NULL;
  const mxArray *c2_lhs69 = NULL;
  const mxArray *c2_rhs70 = NULL;
  const mxArray *c2_lhs70 = NULL;
  const mxArray *c2_rhs71 = NULL;
  const mxArray *c2_lhs71 = NULL;
  const mxArray *c2_rhs72 = NULL;
  const mxArray *c2_lhs72 = NULL;
  const mxArray *c2_rhs73 = NULL;
  const mxArray *c2_lhs73 = NULL;
  const mxArray *c2_rhs74 = NULL;
  const mxArray *c2_lhs74 = NULL;
  const mxArray *c2_rhs75 = NULL;
  const mxArray *c2_lhs75 = NULL;
  const mxArray *c2_rhs76 = NULL;
  const mxArray *c2_lhs76 = NULL;
  const mxArray *c2_rhs77 = NULL;
  const mxArray *c2_lhs77 = NULL;
  const mxArray *c2_rhs78 = NULL;
  const mxArray *c2_lhs78 = NULL;
  const mxArray *c2_rhs79 = NULL;
  const mxArray *c2_lhs79 = NULL;
  const mxArray *c2_rhs80 = NULL;
  const mxArray *c2_lhs80 = NULL;
  const mxArray *c2_rhs81 = NULL;
  const mxArray *c2_lhs81 = NULL;
  const mxArray *c2_rhs82 = NULL;
  const mxArray *c2_lhs82 = NULL;
  const mxArray *c2_rhs83 = NULL;
  const mxArray *c2_lhs83 = NULL;
  const mxArray *c2_rhs84 = NULL;
  const mxArray *c2_lhs84 = NULL;
  const mxArray *c2_rhs85 = NULL;
  const mxArray *c2_lhs85 = NULL;
  const mxArray *c2_rhs86 = NULL;
  const mxArray *c2_lhs86 = NULL;
  const mxArray *c2_rhs87 = NULL;
  const mxArray *c2_lhs87 = NULL;
  const mxArray *c2_rhs88 = NULL;
  const mxArray *c2_lhs88 = NULL;
  const mxArray *c2_rhs89 = NULL;
  const mxArray *c2_lhs89 = NULL;
  const mxArray *c2_rhs90 = NULL;
  const mxArray *c2_lhs90 = NULL;
  const mxArray *c2_rhs91 = NULL;
  const mxArray *c2_lhs91 = NULL;
  const mxArray *c2_rhs92 = NULL;
  const mxArray *c2_lhs92 = NULL;
  const mxArray *c2_rhs93 = NULL;
  const mxArray *c2_lhs93 = NULL;
  const mxArray *c2_rhs94 = NULL;
  const mxArray *c2_lhs94 = NULL;
  const mxArray *c2_rhs95 = NULL;
  const mxArray *c2_lhs95 = NULL;
  const mxArray *c2_rhs96 = NULL;
  const mxArray *c2_lhs96 = NULL;
  const mxArray *c2_rhs97 = NULL;
  const mxArray *c2_lhs97 = NULL;
  const mxArray *c2_rhs98 = NULL;
  const mxArray *c2_lhs98 = NULL;
  const mxArray *c2_rhs99 = NULL;
  const mxArray *c2_lhs99 = NULL;
  const mxArray *c2_rhs100 = NULL;
  const mxArray *c2_lhs100 = NULL;
  const mxArray *c2_rhs101 = NULL;
  const mxArray *c2_lhs101 = NULL;
  const mxArray *c2_rhs102 = NULL;
  const mxArray *c2_lhs102 = NULL;
  const mxArray *c2_rhs103 = NULL;
  const mxArray *c2_lhs103 = NULL;
  const mxArray *c2_rhs104 = NULL;
  const mxArray *c2_lhs104 = NULL;
  const mxArray *c2_rhs105 = NULL;
  const mxArray *c2_lhs105 = NULL;
  const mxArray *c2_rhs106 = NULL;
  const mxArray *c2_lhs106 = NULL;
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cl.m"),
                  "context", "context", 64);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 64);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 64);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 64);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 64);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 64);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 64);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 64);
  sf_mex_assign(&c2_rhs64, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs64, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs64), "rhs", "rhs",
                  64);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs64), "lhs", "lhs",
                  64);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 65);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Dlda"), "name", "name", 65);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 65);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dlda.m"),
                  "resolved", "resolved", 65);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1493212437U), "fileTimeLo",
                  "fileTimeLo", 65);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 65);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 65);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 65);
  sf_mex_assign(&c2_rhs65, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs65, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs65), "rhs", "rhs",
                  65);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs65), "lhs", "lhs",
                  65);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dlda.m"),
                  "context", "context", 66);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 66);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 66);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 66);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 66);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 66);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 66);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 66);
  sf_mex_assign(&c2_rhs66, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs66, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs66), "rhs", "rhs",
                  66);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs66), "lhs", "lhs",
                  66);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dlda.m"),
                  "context", "context", 67);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 67);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 67);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 67);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 67);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 67);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 67);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 67);
  sf_mex_assign(&c2_rhs67, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs67, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs67), "rhs", "rhs",
                  67);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs67), "lhs", "lhs",
                  67);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dlda.m"),
                  "context", "context", 68);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 68);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 68);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 68);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 68);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 68);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 68);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 68);
  sf_mex_assign(&c2_rhs68, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs68, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs68), "rhs", "rhs",
                  68);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs68), "lhs", "lhs",
                  68);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dlda.m"),
                  "context", "context", 69);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 69);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 69);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 69);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 69);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 69);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 69);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 69);
  sf_mex_assign(&c2_rhs69, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs69, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs69), "rhs", "rhs",
                  69);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs69), "lhs", "lhs",
                  69);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 70);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Dldr"), "name", "name", 70);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 70);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dldr.m"),
                  "resolved", "resolved", 70);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1439384447U), "fileTimeLo",
                  "fileTimeLo", 70);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 70);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 70);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 70);
  sf_mex_assign(&c2_rhs70, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs70, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs70), "rhs", "rhs",
                  70);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs70), "lhs", "lhs",
                  70);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dldr.m"),
                  "context", "context", 71);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 71);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 71);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 71);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 71);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 71);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 71);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 71);
  sf_mex_assign(&c2_rhs71, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs71, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs71), "rhs", "rhs",
                  71);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs71), "lhs", "lhs",
                  71);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dldr.m"),
                  "context", "context", 72);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 72);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 72);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 72);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 72);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 72);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 72);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 72);
  sf_mex_assign(&c2_rhs72, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs72, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs72), "rhs", "rhs",
                  72);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs72), "lhs", "lhs",
                  72);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dldr.m"),
                  "context", "context", 73);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 73);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 73);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 73);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 73);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 73);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 73);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 73);
  sf_mex_assign(&c2_rhs73, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs73, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs73), "rhs", "rhs",
                  73);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs73), "lhs", "lhs",
                  73);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dldr.m"),
                  "context", "context", 74);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 74);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 74);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 74);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 74);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 74);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 74);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 74);
  sf_mex_assign(&c2_rhs74, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs74, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs74), "rhs", "rhs",
                  74);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs74), "lhs", "lhs",
                  74);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 75);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Cm"), "name", "name", 75);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 75);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"),
                  "resolved", "resolved", 75);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1493313929U), "fileTimeLo",
                  "fileTimeLo", 75);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 75);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 75);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 75);
  sf_mex_assign(&c2_rhs75, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs75, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs75), "rhs", "rhs",
                  75);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs75), "lhs", "lhs",
                  75);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"),
                  "context", "context", 76);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 76);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 76);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 76);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 76);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 76);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 76);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 76);
  sf_mex_assign(&c2_rhs76, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs76, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs76), "rhs", "rhs",
                  76);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs76), "lhs", "lhs",
                  76);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"),
                  "context", "context", 77);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 77);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 77);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 77);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 77);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 77);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 77);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 77);
  sf_mex_assign(&c2_rhs77, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs77, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs77), "rhs", "rhs",
                  77);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs77), "lhs", "lhs",
                  77);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"),
                  "context", "context", 78);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 78);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 78);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 78);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 78);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 78);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 78);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 78);
  sf_mex_assign(&c2_rhs78, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs78, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs78), "rhs", "rhs",
                  78);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs78), "lhs", "lhs",
                  78);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"),
                  "context", "context", 79);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("round"), "name", "name", 79);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 79);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/round.m"), "resolved",
                  "resolved", 79);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728254U), "fileTimeLo",
                  "fileTimeLo", 79);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 79);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 79);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 79);
  sf_mex_assign(&c2_rhs79, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs79, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs79), "rhs", "rhs",
                  79);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs79), "lhs", "lhs",
                  79);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"),
                  "context", "context", 80);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mrdivide"), "name", "name", 80);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 80);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p"), "resolved",
                  "resolved", 80);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1373324508U), "fileTimeLo",
                  "fileTimeLo", 80);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 80);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1319744366U), "mFileTimeLo",
                  "mFileTimeLo", 80);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 80);
  sf_mex_assign(&c2_rhs80, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs80, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs80), "rhs", "rhs",
                  80);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs80), "lhs", "lhs",
                  80);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cm.m"),
                  "context", "context", 81);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 81);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 81);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 81);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 81);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 81);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 81);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 81);
  sf_mex_assign(&c2_rhs81, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs81, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs81), "rhs", "rhs",
                  81);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs81), "lhs", "lhs",
                  81);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 82);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Cn"), "name", "name", 82);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 82);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cn.m"),
                  "resolved", "resolved", 82);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1493212593U), "fileTimeLo",
                  "fileTimeLo", 82);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 82);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 82);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 82);
  sf_mex_assign(&c2_rhs82, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs82, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs82), "rhs", "rhs",
                  82);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs82), "lhs", "lhs",
                  82);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cn.m"),
                  "context", "context", 83);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 83);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 83);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 83);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 83);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 83);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 83);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 83);
  sf_mex_assign(&c2_rhs83, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs83, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs83), "rhs", "rhs",
                  83);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs83), "lhs", "lhs",
                  83);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cn.m"),
                  "context", "context", 84);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 84);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 84);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 84);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 84);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 84);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 84);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 84);
  sf_mex_assign(&c2_rhs84, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs84, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs84), "rhs", "rhs",
                  84);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs84), "lhs", "lhs",
                  84);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cn.m"),
                  "context", "context", 85);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 85);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 85);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 85);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 85);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 85);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 85);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 85);
  sf_mex_assign(&c2_rhs85, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs85, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs85), "rhs", "rhs",
                  85);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs85), "lhs", "lhs",
                  85);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Cn.m"),
                  "context", "context", 86);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 86);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 86);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 86);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 86);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 86);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 86);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 86);
  sf_mex_assign(&c2_rhs86, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs86, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs86), "rhs", "rhs",
                  86);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs86), "lhs", "lhs",
                  86);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 87);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Dnda"), "name", "name", 87);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 87);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dnda.m"),
                  "resolved", "resolved", 87);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1439384447U), "fileTimeLo",
                  "fileTimeLo", 87);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 87);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 87);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 87);
  sf_mex_assign(&c2_rhs87, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs87, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs87), "rhs", "rhs",
                  87);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs87), "lhs", "lhs",
                  87);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dnda.m"),
                  "context", "context", 88);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 88);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 88);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 88);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 88);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 88);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 88);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 88);
  sf_mex_assign(&c2_rhs88, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs88, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs88), "rhs", "rhs",
                  88);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs88), "lhs", "lhs",
                  88);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dnda.m"),
                  "context", "context", 89);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 89);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 89);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 89);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 89);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 89);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 89);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 89);
  sf_mex_assign(&c2_rhs89, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs89, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs89), "rhs", "rhs",
                  89);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs89), "lhs", "lhs",
                  89);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dnda.m"),
                  "context", "context", 90);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 90);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 90);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 90);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 90);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 90);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 90);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 90);
  sf_mex_assign(&c2_rhs90, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs90, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs90), "rhs", "rhs",
                  90);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs90), "lhs", "lhs",
                  90);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dnda.m"),
                  "context", "context", 91);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 91);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 91);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 91);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 91);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 91);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 91);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 91);
  sf_mex_assign(&c2_rhs91, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs91, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs91), "rhs", "rhs",
                  91);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs91), "lhs", "lhs",
                  91);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 92);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Dndr"), "name", "name", 92);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 92);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dndr.m"),
                  "resolved", "resolved", 92);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1439384447U), "fileTimeLo",
                  "fileTimeLo", 92);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 92);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 92);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 92);
  sf_mex_assign(&c2_rhs92, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs92, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs92), "rhs", "rhs",
                  92);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs92), "lhs", "lhs",
                  92);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dndr.m"),
                  "context", "context", 93);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 93);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 93);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 93);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 93);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 93);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 93);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 93);
  sf_mex_assign(&c2_rhs93, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs93, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs93), "rhs", "rhs",
                  93);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs93), "lhs", "lhs",
                  93);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dndr.m"),
                  "context", "context", 94);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 94);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 94);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 94);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 94);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 94);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 94);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 94);
  sf_mex_assign(&c2_rhs94, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs94, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs94), "rhs", "rhs",
                  94);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs94), "lhs", "lhs",
                  94);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dndr.m"),
                  "context", "context", 95);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 95);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 95);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 95);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 95);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 95);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 95);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 95);
  sf_mex_assign(&c2_rhs95, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs95, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs95), "rhs", "rhs",
                  95);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs95), "lhs", "lhs",
                  95);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Dndr.m"),
                  "context", "context", 96);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 96);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 96);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 96);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 96);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 96);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 96);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 96);
  sf_mex_assign(&c2_rhs96, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs96, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs96), "rhs", "rhs",
                  96);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs96), "lhs", "lhs",
                  96);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 97);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("Damping"), "name", "name", 97);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 97);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Damping.m"),
                  "resolved", "resolved", 97);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1506614396U), "fileTimeLo",
                  "fileTimeLo", 97);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 97);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 97);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 97);
  sf_mex_assign(&c2_rhs97, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs97, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs97), "rhs", "rhs",
                  97);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs97), "lhs", "lhs",
                  97);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Damping.m"),
                  "context", "context", 98);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("mtimes"), "name", "name", 98);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 98);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m"), "resolved",
                  "resolved", 98);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728278U), "fileTimeLo",
                  "fileTimeLo", 98);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 98);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 98);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 98);
  sf_mex_assign(&c2_rhs98, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs98, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs98), "rhs", "rhs",
                  98);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs98), "lhs", "lhs",
                  98);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Damping.m"),
                  "context", "context", 99);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("fix"), "name", "name", 99);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 99);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/fix.m"), "resolved",
                  "resolved", 99);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 99);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 99);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 99);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 99);
  sf_mex_assign(&c2_rhs99, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs99, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs99), "rhs", "rhs",
                  99);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs99), "lhs", "lhs",
                  99);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Damping.m"),
                  "context", "context", 100);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sign"), "name", "name", 100);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 100);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sign.m"), "resolved",
                  "resolved", 100);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728256U), "fileTimeLo",
                  "fileTimeLo", 100);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 100);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 100);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 100);
  sf_mex_assign(&c2_rhs100, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs100, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs100), "rhs", "rhs",
                  100);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs100), "lhs", "lhs",
                  100);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Damping.m"),
                  "context", "context", 101);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("floor"), "name", "name", 101);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 101);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m"), "resolved",
                  "resolved", 101);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728254U), "fileTimeLo",
                  "fileTimeLo", 101);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 101);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 101);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 101);
  sf_mex_assign(&c2_rhs101, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs101, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs101), "rhs", "rhs",
                  101);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs101), "lhs", "lhs",
                  101);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[E]C:/Users/Eduardo/Desktop/F16 - Classe/Simulink F16/CoeficientesAerodinamicos/Damping.m"),
                  "context", "context", 102);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("abs"), "name", "name", 102);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 102);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/abs.m"), "resolved",
                  "resolved", 102);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1363728252U), "fileTimeLo",
                  "fileTimeLo", 102);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 102);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 102);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 102);
  sf_mex_assign(&c2_rhs102, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs102, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs102), "rhs", "rhs",
                  102);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs102), "lhs", "lhs",
                  102);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 103);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("cos"), "name", "name", 103);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 103);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/cos.m"), "resolved",
                  "resolved", 103);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1343848372U), "fileTimeLo",
                  "fileTimeLo", 103);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 103);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 103);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 103);
  sf_mex_assign(&c2_rhs103, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs103, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs103), "rhs", "rhs",
                  103);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs103), "lhs", "lhs",
                  103);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/cos.m"), "context",
                  "context", 104);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_cos"), "name",
                  "name", 104);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 104);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_cos.m"),
                  "resolved", "resolved", 104);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836722U), "fileTimeLo",
                  "fileTimeLo", 104);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 104);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 104);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 104);
  sf_mex_assign(&c2_rhs104, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs104, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs104), "rhs", "rhs",
                  104);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs104), "lhs", "lhs",
                  104);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(""), "context", "context", 105);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("sin"), "name", "name", 105);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 105);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sin.m"), "resolved",
                  "resolved", 105);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1343848386U), "fileTimeLo",
                  "fileTimeLo", 105);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 105);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 105);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 105);
  sf_mex_assign(&c2_rhs105, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs105, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs105), "rhs", "rhs",
                  105);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs105), "lhs", "lhs",
                  105);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sin.m"), "context",
                  "context", 106);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("eml_scalar_sin"), "name",
                  "name", 106);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut("double"), "dominantType",
                  "dominantType", 106);
  sf_mex_addfield(*c2_info, c2_emlrt_marshallOut(
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_sin.m"),
                  "resolved", "resolved", 106);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(1286836736U), "fileTimeLo",
                  "fileTimeLo", 106);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "fileTimeHi",
                  "fileTimeHi", 106);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeLo",
                  "mFileTimeLo", 106);
  sf_mex_addfield(*c2_info, c2_b_emlrt_marshallOut(0U), "mFileTimeHi",
                  "mFileTimeHi", 106);
  sf_mex_assign(&c2_rhs106, sf_mex_createcellarray(0), FALSE);
  sf_mex_assign(&c2_lhs106, sf_mex_createcellarray(0), FALSE);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_rhs106), "rhs", "rhs",
                  106);
  sf_mex_addfield(*c2_info, sf_mex_duplicatearraysafe(&c2_lhs106), "lhs", "lhs",
                  106);
  sf_mex_destroy(&c2_rhs64);
  sf_mex_destroy(&c2_lhs64);
  sf_mex_destroy(&c2_rhs65);
  sf_mex_destroy(&c2_lhs65);
  sf_mex_destroy(&c2_rhs66);
  sf_mex_destroy(&c2_lhs66);
  sf_mex_destroy(&c2_rhs67);
  sf_mex_destroy(&c2_lhs67);
  sf_mex_destroy(&c2_rhs68);
  sf_mex_destroy(&c2_lhs68);
  sf_mex_destroy(&c2_rhs69);
  sf_mex_destroy(&c2_lhs69);
  sf_mex_destroy(&c2_rhs70);
  sf_mex_destroy(&c2_lhs70);
  sf_mex_destroy(&c2_rhs71);
  sf_mex_destroy(&c2_lhs71);
  sf_mex_destroy(&c2_rhs72);
  sf_mex_destroy(&c2_lhs72);
  sf_mex_destroy(&c2_rhs73);
  sf_mex_destroy(&c2_lhs73);
  sf_mex_destroy(&c2_rhs74);
  sf_mex_destroy(&c2_lhs74);
  sf_mex_destroy(&c2_rhs75);
  sf_mex_destroy(&c2_lhs75);
  sf_mex_destroy(&c2_rhs76);
  sf_mex_destroy(&c2_lhs76);
  sf_mex_destroy(&c2_rhs77);
  sf_mex_destroy(&c2_lhs77);
  sf_mex_destroy(&c2_rhs78);
  sf_mex_destroy(&c2_lhs78);
  sf_mex_destroy(&c2_rhs79);
  sf_mex_destroy(&c2_lhs79);
  sf_mex_destroy(&c2_rhs80);
  sf_mex_destroy(&c2_lhs80);
  sf_mex_destroy(&c2_rhs81);
  sf_mex_destroy(&c2_lhs81);
  sf_mex_destroy(&c2_rhs82);
  sf_mex_destroy(&c2_lhs82);
  sf_mex_destroy(&c2_rhs83);
  sf_mex_destroy(&c2_lhs83);
  sf_mex_destroy(&c2_rhs84);
  sf_mex_destroy(&c2_lhs84);
  sf_mex_destroy(&c2_rhs85);
  sf_mex_destroy(&c2_lhs85);
  sf_mex_destroy(&c2_rhs86);
  sf_mex_destroy(&c2_lhs86);
  sf_mex_destroy(&c2_rhs87);
  sf_mex_destroy(&c2_lhs87);
  sf_mex_destroy(&c2_rhs88);
  sf_mex_destroy(&c2_lhs88);
  sf_mex_destroy(&c2_rhs89);
  sf_mex_destroy(&c2_lhs89);
  sf_mex_destroy(&c2_rhs90);
  sf_mex_destroy(&c2_lhs90);
  sf_mex_destroy(&c2_rhs91);
  sf_mex_destroy(&c2_lhs91);
  sf_mex_destroy(&c2_rhs92);
  sf_mex_destroy(&c2_lhs92);
  sf_mex_destroy(&c2_rhs93);
  sf_mex_destroy(&c2_lhs93);
  sf_mex_destroy(&c2_rhs94);
  sf_mex_destroy(&c2_lhs94);
  sf_mex_destroy(&c2_rhs95);
  sf_mex_destroy(&c2_lhs95);
  sf_mex_destroy(&c2_rhs96);
  sf_mex_destroy(&c2_lhs96);
  sf_mex_destroy(&c2_rhs97);
  sf_mex_destroy(&c2_lhs97);
  sf_mex_destroy(&c2_rhs98);
  sf_mex_destroy(&c2_lhs98);
  sf_mex_destroy(&c2_rhs99);
  sf_mex_destroy(&c2_lhs99);
  sf_mex_destroy(&c2_rhs100);
  sf_mex_destroy(&c2_lhs100);
  sf_mex_destroy(&c2_rhs101);
  sf_mex_destroy(&c2_lhs101);
  sf_mex_destroy(&c2_rhs102);
  sf_mex_destroy(&c2_lhs102);
  sf_mex_destroy(&c2_rhs103);
  sf_mex_destroy(&c2_lhs103);
  sf_mex_destroy(&c2_rhs104);
  sf_mex_destroy(&c2_lhs104);
  sf_mex_destroy(&c2_rhs105);
  sf_mex_destroy(&c2_lhs105);
  sf_mex_destroy(&c2_rhs106);
  sf_mex_destroy(&c2_lhs106);
}

static void c2_eml_scalar_eg(SFc2_F16_SimulinkInstanceStruct *chartInstance)
{
}

static void c2_eml_error(SFc2_F16_SimulinkInstanceStruct *chartInstance)
{
  int32_T c2_i88;
  static char_T c2_cv0[31] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o', 'l',
    'b', 'o', 'x', ':', 'p', 'o', 'w', 'e', 'r', '_', 'd', 'o', 'm', 'a', 'i',
    'n', 'E', 'r', 'r', 'o', 'r' };

  char_T c2_u[31];
  const mxArray *c2_y = NULL;
  for (c2_i88 = 0; c2_i88 < 31; c2_i88++) {
    c2_u[c2_i88] = c2_cv0[c2_i88];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 10, 0U, 1U, 0U, 2, 1, 31), FALSE);
  sf_mex_call_debug("error", 0U, 1U, 14, sf_mex_call_debug("message", 1U, 1U, 14,
    c2_y));
}

static void c2_b_eml_error(SFc2_F16_SimulinkInstanceStruct *chartInstance)
{
  int32_T c2_i89;
  static char_T c2_cv1[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o', 'l',
    'b', 'o', 'x', ':', 'E', 'l', 'F', 'u', 'n', 'D', 'o', 'm', 'a', 'i', 'n',
    'E', 'r', 'r', 'o', 'r' };

  char_T c2_u[30];
  const mxArray *c2_y = NULL;
  int32_T c2_i90;
  static char_T c2_cv2[4] = { 's', 'q', 'r', 't' };

  char_T c2_b_u[4];
  const mxArray *c2_b_y = NULL;
  for (c2_i89 = 0; c2_i89 < 30; c2_i89++) {
    c2_u[c2_i89] = c2_cv1[c2_i89];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_u, 10, 0U, 1U, 0U, 2, 1, 30), FALSE);
  for (c2_i90 = 0; c2_i90 < 4; c2_i90++) {
    c2_b_u[c2_i90] = c2_cv2[c2_i90];
  }

  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", c2_b_u, 10, 0U, 1U, 0U, 2, 1, 4),
                FALSE);
  sf_mex_call_debug("error", 0U, 1U, 14, sf_mex_call_debug("message", 1U, 2U, 14,
    c2_y, 14, c2_b_y));
}

static const mxArray *c2_k_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(int32_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 6, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static int32_T c2_l_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  int32_T c2_y;
  int32_T c2_i91;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_i91, 1, 6, 0U, 0, 0U, 0);
  c2_y = c2_i91;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_j_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_sfEvent;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_y;
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)chartInstanceVoid;
  c2_b_sfEvent = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_l_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_sfEvent),
    &c2_thisId);
  sf_mex_destroy(&c2_b_sfEvent);
  *(int32_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static uint8_T c2_m_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_b_is_active_c2_F16_Simulink, const char_T
  *c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_n_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_F16_Simulink), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_F16_Simulink);
  return c2_y;
}

static uint8_T c2_n_emlrt_marshallIn(SFc2_F16_SimulinkInstanceStruct
  *chartInstance, const mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info(SFc2_F16_SimulinkInstanceStruct *chartInstance)
{
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c2_F16_Simulink_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(4171657161U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1576627010U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(527093325U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1571103271U);
}

mxArray *sf_c2_F16_Simulink_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("BsfLMP8O2YxZp5h0lR2gbF");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,3,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(13);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(5);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,2,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,2,"type",mxType);
    }

    mxSetField(mxData,2,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(13);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(2);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c2_F16_Simulink_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c2_F16_Simulink_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c2_F16_Simulink(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x3'type','srcId','name','auxInfo'{{M[1],M[8],T\"xd\",},{M[1],M[5],T\"y\",},{M[8],M[0],T\"is_active_c2_F16_Simulink\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 3, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_F16_Simulink_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_F16_SimulinkInstanceStruct *chartInstance;
    chartInstance = (SFc2_F16_SimulinkInstanceStruct *) ((ChartInfoStruct *)
      (ssGetUserData(S)))->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _F16_SimulinkMachineNumber_,
           2,
           1,
           1,
           5,
           0,
           0,
           0,
           0,
           16,
           &(chartInstance->chartNumber),
           &(chartInstance->instanceNumber),
           ssGetPath(S),
           (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation(_F16_SimulinkMachineNumber_,
            chartInstance->chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,_F16_SimulinkMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _F16_SimulinkMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"x");
          _SFD_SET_DATA_PROPS(1,2,0,1,"xd");
          _SFD_SET_DATA_PROPS(2,1,1,0,"u");
          _SFD_SET_DATA_PROPS(3,2,0,1,"y");
          _SFD_SET_DATA_PROPS(4,1,1,0,"t");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,7045);
        _SFD_CV_INIT_SCRIPT(0,1,1,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(0,0,"ADC",0,-1,433);
        _SFD_CV_INIT_SCRIPT_IF(0,0,208,227,-1,245);
        _SFD_CV_INIT_SCRIPT(1,1,1,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(1,0,"TGear",0,-1,321);
        _SFD_CV_INIT_SCRIPT_IF(1,0,232,249,274,316);
        _SFD_CV_INIT_SCRIPT(2,1,3,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(2,0,"PowerRate",0,-1,449);
        _SFD_CV_INIT_SCRIPT_IF(2,0,159,172,296,424);
        _SFD_CV_INIT_SCRIPT_IF(2,1,177,192,231,295);
        _SFD_CV_INIT_SCRIPT_IF(2,2,305,320,361,415);
        _SFD_CV_INIT_SCRIPT(3,1,2,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(3,0,"Rtau",0,-1,179);
        _SFD_CV_INIT_SCRIPT_IF(3,0,69,84,102,174);
        _SFD_CV_INIT_SCRIPT_IF(3,1,102,120,138,174);
        _SFD_CV_INIT_SCRIPT(4,1,3,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(4,0,"Thrust",0,-1,2585);
        _SFD_CV_INIT_SCRIPT_IF(4,0,1247,1258,-1,1273);
        _SFD_CV_INIT_SCRIPT_IF(4,1,1372,1383,-1,1398);
        _SFD_CV_INIT_SCRIPT_IF(4,2,2260,2273,2419,2579);
        _SFD_CV_INIT_SCRIPT(5,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(5,0,"Cx",0,-1,1604);
        _SFD_CV_INIT_SCRIPT_IF(5,0,642,653,-1,669);
        _SFD_CV_INIT_SCRIPT_IF(5,1,670,680,-1,695);
        _SFD_CV_INIT_SCRIPT_IF(5,2,1029,1040,-1,1056);
        _SFD_CV_INIT_SCRIPT_IF(5,3,1057,1067,-1,1082);
        _SFD_CV_INIT_SCRIPT(6,1,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(6,0,"Cy",0,-1,142);
        _SFD_CV_INIT_SCRIPT(7,1,2,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(7,0,"Cz",0,-1,795);
        _SFD_CV_INIT_SCRIPT_IF(7,0,192,203,-1,220);
        _SFD_CV_INIT_SCRIPT_IF(7,1,221,231,-1,246);
        _SFD_CV_INIT_SCRIPT(8,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(8,0,"Cl",0,-1,2369);
        _SFD_CV_INIT_SCRIPT_IF(8,0,1603,1614,-1,1632);
        _SFD_CV_INIT_SCRIPT_IF(8,1,1634,1644,-1,1661);
        _SFD_CV_INIT_SCRIPT_IF(8,2,1758,1769,-1,1786);
        _SFD_CV_INIT_SCRIPT_IF(8,3,1788,1799,-1,1816);
        _SFD_CV_INIT_SCRIPT(9,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(9,0,"Dlda",0,-1,1606);
        _SFD_CV_INIT_SCRIPT_IF(9,0,869,880,-1,896);
        _SFD_CV_INIT_SCRIPT_IF(9,1,897,907,-1,922);
        _SFD_CV_INIT_SCRIPT_IF(9,2,1042,1053,-1,1069);
        _SFD_CV_INIT_SCRIPT_IF(9,3,1070,1080,-1,1095);
        _SFD_CV_INIT_SCRIPT(10,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(10,0,"Dldr",0,-1,1515);
        _SFD_CV_INIT_SCRIPT_IF(10,0,788,799,-1,815);
        _SFD_CV_INIT_SCRIPT_IF(10,1,816,826,-1,841);
        _SFD_CV_INIT_SCRIPT_IF(10,2,945,956,-1,972);
        _SFD_CV_INIT_SCRIPT_IF(10,3,973,983,-1,998);
        _SFD_CV_INIT_SCRIPT(11,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(11,0,"Cm",0,-1,2039);
        _SFD_CV_INIT_SCRIPT_IF(11,0,1100,1111,-1,1127);
        _SFD_CV_INIT_SCRIPT_IF(11,1,1128,1138,-1,1153);
        _SFD_CV_INIT_SCRIPT_IF(11,2,1358,1369,-1,1385);
        _SFD_CV_INIT_SCRIPT_IF(11,3,1386,1396,-1,1411);
        _SFD_CV_INIT_SCRIPT(12,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(12,0,"Cn",0,-1,1542);
        _SFD_CV_INIT_SCRIPT_IF(12,0,777,788,-1,806);
        _SFD_CV_INIT_SCRIPT_IF(12,1,808,818,-1,835);
        _SFD_CV_INIT_SCRIPT_IF(12,2,931,942,-1,959);
        _SFD_CV_INIT_SCRIPT_IF(12,3,961,972,-1,989);
        _SFD_CV_INIT_SCRIPT(13,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(13,0,"Dnda",0,-1,1544);
        _SFD_CV_INIT_SCRIPT_IF(13,0,824,835,-1,851);
        _SFD_CV_INIT_SCRIPT_IF(13,1,852,862,-1,877);
        _SFD_CV_INIT_SCRIPT_IF(13,2,981,992,-1,1008);
        _SFD_CV_INIT_SCRIPT_IF(13,3,1009,1019,-1,1034);
        _SFD_CV_INIT_SCRIPT(14,1,4,0,0,0,0,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(14,0,"Dndr",0,-1,1465);
        _SFD_CV_INIT_SCRIPT_IF(14,0,845,856,-1,872);
        _SFD_CV_INIT_SCRIPT_IF(14,1,873,883,-1,898);
        _SFD_CV_INIT_SCRIPT_IF(14,2,1002,1013,-1,1029);
        _SFD_CV_INIT_SCRIPT_IF(14,3,1030,1040,-1,1055);
        _SFD_CV_INIT_SCRIPT(15,1,2,0,0,0,1,0,0,0);
        _SFD_CV_INIT_SCRIPT_FCN(15,0,"Damping",0,-1,1997);
        _SFD_CV_INIT_SCRIPT_IF(15,0,1240,1252,-1,1293);
        _SFD_CV_INIT_SCRIPT_IF(15,1,1294,1305,-1,1320);
        _SFD_CV_INIT_SCRIPT_FOR(15,0,1727,1739,1842);

        {
          unsigned int dimVector[1];
          dimVector[0]= 13;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 13;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_b_sf_marshallOut,(MexInFcnForType)
            c2_b_sf_marshallIn);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 5;
          _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_d_sf_marshallOut,(MexInFcnForType)NULL);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 2;
          _SFD_SET_DATA_COMPILED_PROPS(3,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)
            c2_sf_marshallIn);
        }

        _SFD_SET_DATA_COMPILED_PROPS(4,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_c_sf_marshallOut,(MexInFcnForType)NULL);

        {
          real_T *c2_t;
          real_T (*c2_x)[13];
          real_T (*c2_xd)[13];
          real_T (*c2_u)[5];
          real_T (*c2_y)[2];
          c2_t = (real_T *)ssGetInputPortSignal(chartInstance->S, 2);
          c2_y = (real_T (*)[2])ssGetOutputPortSignal(chartInstance->S, 2);
          c2_u = (real_T (*)[5])ssGetInputPortSignal(chartInstance->S, 1);
          c2_xd = (real_T (*)[13])ssGetOutputPortSignal(chartInstance->S, 1);
          c2_x = (real_T (*)[13])ssGetInputPortSignal(chartInstance->S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, *c2_x);
          _SFD_SET_DATA_VALUE_PTR(1U, *c2_xd);
          _SFD_SET_DATA_VALUE_PTR(2U, *c2_u);
          _SFD_SET_DATA_VALUE_PTR(3U, *c2_y);
          _SFD_SET_DATA_VALUE_PTR(4U, c2_t);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _F16_SimulinkMachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "Cgj1t7bu3hNEx0x6ft5bjD";
}

static void sf_opaque_initialize_c2_F16_Simulink(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc2_F16_SimulinkInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*)
    chartInstanceVar);
  initialize_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c2_F16_Simulink(void *chartInstanceVar)
{
  enable_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c2_F16_Simulink(void *chartInstanceVar)
{
  disable_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c2_F16_Simulink(void *chartInstanceVar)
{
  sf_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*) chartInstanceVar);
}

extern const mxArray* sf_internal_get_sim_state_c2_F16_Simulink(SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c2_F16_Simulink
    ((SFc2_F16_SimulinkInstanceStruct*)chartInfo->chartInstance);/* raw sim ctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c2_F16_Simulink();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_raw2high'.\n");
  }

  return plhs[0];
}

extern void sf_internal_set_sim_state_c2_F16_Simulink(SimStruct* S, const
  mxArray *st)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = mxDuplicateArray(st);      /* high level simctx */
  prhs[3] = (mxArray*) sf_get_sim_state_info_c2_F16_Simulink();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*)
    chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray* sf_opaque_get_sim_state_c2_F16_Simulink(SimStruct* S)
{
  return sf_internal_get_sim_state_c2_F16_Simulink(S);
}

static void sf_opaque_set_sim_state_c2_F16_Simulink(SimStruct* S, const mxArray *
  st)
{
  sf_internal_set_sim_state_c2_F16_Simulink(S, st);
}

static void sf_opaque_terminate_c2_F16_Simulink(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_F16_SimulinkInstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_F16_Simulink_optimization_info();
    }

    finalize_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*) chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*)
    chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_F16_Simulink(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_F16_Simulink((SFc2_F16_SimulinkInstanceStruct*)
      (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c2_F16_Simulink(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_F16_Simulink_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,2,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,2,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,2);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,2,3);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,2,2);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=2; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 3; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,2);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(3110903685U));
  ssSetChecksum1(S,(2395853381U));
  ssSetChecksum2(S,(308840028U));
  ssSetChecksum3(S,(2874297151U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c2_F16_Simulink(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_F16_Simulink(SimStruct *S)
{
  SFc2_F16_SimulinkInstanceStruct *chartInstance;
  chartInstance = (SFc2_F16_SimulinkInstanceStruct *)utMalloc(sizeof
    (SFc2_F16_SimulinkInstanceStruct));
  memset(chartInstance, 0, sizeof(SFc2_F16_SimulinkInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway = sf_opaque_gateway_c2_F16_Simulink;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_F16_Simulink;
  chartInstance->chartInfo.terminateChart = sf_opaque_terminate_c2_F16_Simulink;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c2_F16_Simulink;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c2_F16_Simulink;
  chartInstance->chartInfo.getSimState = sf_opaque_get_sim_state_c2_F16_Simulink;
  chartInstance->chartInfo.setSimState = sf_opaque_set_sim_state_c2_F16_Simulink;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_F16_Simulink;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_F16_Simulink;
  chartInstance->chartInfo.mdlStart = mdlStart_c2_F16_Simulink;
  chartInstance->chartInfo.mdlSetWorkWidths = mdlSetWorkWidths_c2_F16_Simulink;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->S = S;
  ssSetUserData(S,(void *)(&(chartInstance->chartInfo)));/* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
  chart_debug_initialization(S,1);
}

void c2_F16_Simulink_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_F16_Simulink(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_F16_Simulink(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_F16_Simulink(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_F16_Simulink_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
