/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Algorithm_to_deploy.h
 *
 * Code generated for Simulink model 'Algorithm_to_deploy'.
 *
 * Model version                  : 9.14
 * Simulink Coder version         : 25.2 (R2025b) 28-Jul-2025
 * C/C++ source code generated on : Thu Apr 23 12:19:12 2026
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-M
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef Algorithm_to_deploy_h_
#define Algorithm_to_deploy_h_
#ifndef Algorithm_to_deploy_COMMON_INCLUDES_
#define Algorithm_to_deploy_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rt_nonfinite.h"
#include "math.h"
#endif                                /* Algorithm_to_deploy_COMMON_INCLUDES_ */

#include "Algorithm_to_deploy_types.h"
#include "rtGetNaN.h"

/* Block states (default storage) for model 'Algorithm_to_deploy' */
typedef struct {
  real32_T Delay_DSTATE[6];            /* '<S2>/Delay' */
  real32_T Delay_DSTATE_d;             /* '<S11>/Delay' */
  real32_T Delay1_DSTATE;              /* '<S11>/Delay1' */
  real32_T Delay2_DSTATE[3];           /* '<S1>/Delay2' */
  real32_T Delay3_DSTATE[3];           /* '<S1>/Delay3' */
  real32_T Delay_DSTATE_e;             /* '<S12>/Delay' */
  real32_T Delay1_DSTATE_k;            /* '<S12>/Delay1' */
  real32_T Delay_DSTATE_dt[3];         /* '<S1>/Delay' */
  real32_T Delay1_DSTATE_o[3];         /* '<S1>/Delay1' */
  real32_T Delay_DSTATE_k[3];          /* '<S14>/Delay' */
  real32_T Delay1_DSTATE_h[3];         /* '<S14>/Delay1' */
  real32_T Delay_DSTATE_j[3];          /* '<S16>/Delay' */
  real32_T Delay1_DSTATE_p[3];         /* '<S16>/Delay1' */
  real32_T Delay_DSTATE_dm[3];         /* '<S18>/Delay' */
  real32_T Delay1_DSTATE_hw[3];        /* '<S18>/Delay1' */
} DW_Algorithm_to_deploy_f_T;

/* Real-time Model Data Structure */
struct tag_RTM_Algorithm_to_deploy_T {
  const char_T **errorStatus;
};

typedef struct {
  DW_Algorithm_to_deploy_f_T rtdw;
  RT_MODEL_Algorithm_to_deploy_T rtm;
} MdlrefDW_Algorithm_to_deploy_T;

/* Model reference registration function */
extern void Algorithm_to_deploy_initialize(const char_T **rt_errorStatus,
  RT_MODEL_Algorithm_to_deploy_T *const Algorithm_to_deploy_M);
extern void Algorithm_to_deploy_Init(DW_Algorithm_to_deploy_f_T *localDW);
extern void Algorithm_to_deploy(const real32_T rtu_pm[3], const real32_T
  rtu_pdotms[3], const real32_T rtu_omegarads[3], const real32_T rtu_R[9], const
  real32_T rtu_prm[3], const real32_T rtu_prdotms[3], const real32_T
  rtu_prddotms2[3], const real32_T *rtu_yawrrad, const real32_T *rtu_yawrdotrads,
  const real32_T *rtu_yawrddotrads2, real32_T rty_u[6],
  DW_Algorithm_to_deploy_f_T *localDW);

/*-
 * These blocks were eliminated from the model due to optimizations:
 *
 * Block '<S2>/Scope' : Unused code path elimination
 * Block '<S1>/i [0,na]1' : Unused code path elimination
 * Block '<S1>/Gain' : Eliminated nontunable gain of 1
 * Block '<S1>/Gain1' : Eliminated nontunable gain of 1
 * Block '<S1>/Gain2' : Eliminated nontunable gain of 1
 * Block '<S1>/Gain3' : Eliminated nontunable gain of 1
 */

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Algorithm_to_deploy'
 * '<S1>'   : 'Algorithm_to_deploy/Controller'
 * '<S2>'   : 'Algorithm_to_deploy/Controller/Feedback linearization stage for standard multirotors'
 * '<S3>'   : 'Algorithm_to_deploy/Controller/Linear internal controller for standard multirotors'
 * '<S4>'   : 'Algorithm_to_deploy/Controller/MATLAB Function'
 * '<S5>'   : 'Algorithm_to_deploy/Controller/MATLAB Function2'
 * '<S6>'   : 'Algorithm_to_deploy/Controller/Subsystem'
 * '<S7>'   : 'Algorithm_to_deploy/Controller/Subsystem1'
 * '<S8>'   : 'Algorithm_to_deploy/Controller/Feedback linearization stage for standard multirotors/Control Allocation'
 * '<S9>'   : 'Algorithm_to_deploy/Controller/Feedback linearization stage for standard multirotors/Dynamic Feedback Linearization'
 * '<S10>'  : 'Algorithm_to_deploy/Controller/Feedback linearization stage for standard multirotors/MATLAB Function'
 * '<S11>'  : 'Algorithm_to_deploy/Controller/Feedback linearization stage for standard multirotors/Subsystem1'
 * '<S12>'  : 'Algorithm_to_deploy/Controller/Feedback linearization stage for standard multirotors/Subsystem4'
 * '<S13>'  : 'Algorithm_to_deploy/Controller/Linear internal controller for standard multirotors/Linear controllers'
 * '<S14>'  : 'Algorithm_to_deploy/Controller/Linear internal controller for standard multirotors/Subsystem4'
 * '<S15>'  : 'Algorithm_to_deploy/Controller/Subsystem/Force Observer (NDO)'
 * '<S16>'  : 'Algorithm_to_deploy/Controller/Subsystem/Subsystem4'
 * '<S17>'  : 'Algorithm_to_deploy/Controller/Subsystem1/Force Observer (NDO)'
 * '<S18>'  : 'Algorithm_to_deploy/Controller/Subsystem1/Subsystem4'
 */
#endif                                 /* Algorithm_to_deploy_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
