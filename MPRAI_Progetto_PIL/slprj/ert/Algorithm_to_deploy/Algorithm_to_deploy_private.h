/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Algorithm_to_deploy_private.h
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

#ifndef Algorithm_to_deploy_private_h_
#define Algorithm_to_deploy_private_h_
#include "rtwtypes.h"
#include "Algorithm_to_deploy_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         (*((rtm)->errorStatus))
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    (*((rtm)->errorStatus) = (val))
#endif

#ifndef rtmGetErrorStatusPointer
#define rtmGetErrorStatusPointer(rtm)  (rtm)->errorStatus
#endif

#ifndef rtmSetErrorStatusPointer
#define rtmSetErrorStatusPointer(rtm, val) ((rtm)->errorStatus = (val))
#endif

extern const real32_T rtCP_pooled_69TSNfyu4cTx[24];
extern const real32_T rtCP_pooled_B2iBytop0Ikp[9];
extern const real32_T rtCP_pooled_rmCMULFkJXve[9];
extern const real32_T rtCP_pooled_s9H5KrlHjNiC[9];
extern const real32_T rtCP_pooled_gBNrhtb6N0ty[9];
extern const real32_T rtCP_pooled_0dKMm3TDe3N4[9];
extern const real32_T rtCP_pooled_IEoPeCxjPnLW[9];
extern const real32_T rtCP_pooled_MLS5dHCd19pa[9];
extern const real32_T rtCP_pooled_xsXKc6bcgD0j[9];
extern const real32_T rtCP_pooled_MXhYEHOlcVRP[9];
extern const real32_T rtCP_pooled_G2yvaIUd97LH[18];
extern const real32_T rtCP_pooled_5bVyuvFQbcY2[9];
extern const real32_T rtCP_pooled_M79cbV50gVQp[9];
extern const real32_T rtCP_pooled_bMCPhwlmPwtT[18];
extern const real32_T rtCP_pooled_vhSFZ2nMSwdo[9];

#define rtCP_ControlAllocation_A_pinv  rtCP_pooled_69TSNfyu4cTx  /* Expression: A_pinv
                                                                  * Referenced by: '<S2>/Control Allocation'
                                                                  */
#define rtCP_ControlAllocation_mask_J  rtCP_pooled_B2iBytop0Ikp  /* Expression: mask_J
                                                                  * Referenced by: '<S2>/Control Allocation'
                                                                  */
#define rtCP_DynamicFeedbackLineariza_k rtCP_pooled_rmCMULFkJXve /* Expression: mask_J
                                                                  * Referenced by: '<S2>/Dynamic Feedback Linearization'
                                                                  */
#define rtCP_DynamicFeedbackLineariza_c rtCP_pooled_s9H5KrlHjNiC /* Expression: mask_Jinv
                                                                  * Referenced by: '<S2>/Dynamic Feedback Linearization'
                                                                  */
#define rtCP_Linearcontrollers_mask_k0 rtCP_pooled_gBNrhtb6N0ty  /* Expression: mask_k0
                                                                  * Referenced by: '<S3>/Linear controllers'
                                                                  */
#define rtCP_Linearcontrollers_mask_k1 rtCP_pooled_0dKMm3TDe3N4  /* Expression: mask_k1
                                                                  * Referenced by: '<S3>/Linear controllers'
                                                                  */
#define rtCP_Linearcontrollers_mask_k2 rtCP_pooled_IEoPeCxjPnLW  /* Expression: mask_k2
                                                                  * Referenced by: '<S3>/Linear controllers'
                                                                  */
#define rtCP_Linearcontrollers_mask_k3 rtCP_pooled_MLS5dHCd19pa  /* Expression: mask_k3
                                                                  * Referenced by: '<S3>/Linear controllers'
                                                                  */
#define rtCP_ForceObserverNDO_mask_AH  rtCP_pooled_xsXKc6bcgD0j  /* Expression: mask_AH
                                                                  * Referenced by: '<S6>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_C   rtCP_pooled_MXhYEHOlcVRP  /* Expression: mask_C
                                                                  * Referenced by: '<S6>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_F1  rtCP_pooled_G2yvaIUd97LH  /* Expression: mask_F1
                                                                  * Referenced by: '<S6>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_H   rtCP_pooled_5bVyuvFQbcY2  /* Expression: mask_H
                                                                  * Referenced by: '<S6>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_AH_a rtCP_pooled_xsXKc6bcgD0j /* Expression: mask_AH
                                                                  * Referenced by: '<S7>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_C_c rtCP_pooled_M79cbV50gVQp  /* Expression: mask_C
                                                                  * Referenced by: '<S7>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_F2  rtCP_pooled_bMCPhwlmPwtT  /* Expression: mask_F2
                                                                  * Referenced by: '<S7>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_H_f rtCP_pooled_5bVyuvFQbcY2  /* Expression: mask_H
                                                                  * Referenced by: '<S7>/Force Observer (NDO)'
                                                                  */
#define rtCP_ForceObserverNDO_mask_J   rtCP_pooled_vhSFZ2nMSwdo  /* Expression: mask_J
                                                                  * Referenced by: '<S7>/Force Observer (NDO)'
                                                                  */
#endif                                 /* Algorithm_to_deploy_private_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
