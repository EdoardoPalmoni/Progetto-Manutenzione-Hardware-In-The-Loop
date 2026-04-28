/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Algorithm_to_deploy.c
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

#include "Algorithm_to_deploy.h"
#include "rtwtypes.h"
#include "mw_cmsis.h"
#include "rt_atan2f_snf.h"
#include <math.h>
#include "Algorithm_to_deploy_types.h"
#include "Algorithm_to_deploy_private.h"

/* System initialize for referenced model: 'Algorithm_to_deploy' */
void Algorithm_to_deploy_Init(DW_Algorithm_to_deploy_f_T *localDW)
{
  /* InitializeConditions for Delay: '<S11>/Delay' */
  localDW->Delay_DSTATE_d = 15.19F;
}

/* Output and update for referenced model: 'Algorithm_to_deploy' */
void Algorithm_to_deploy(const real32_T rtu_pm[3], const real32_T rtu_pdotms[3],
  const real32_T rtu_omegarads[3], const real32_T rtu_R[9], const real32_T
  rtu_prm[3], const real32_T rtu_prdotms[3], const real32_T rtu_prddotms2[3],
  const real32_T *rtu_yawrrad, const real32_T *rtu_yawrdotrads, const real32_T
  *rtu_yawrddotrads2, real32_T rty_u[6], DW_Algorithm_to_deploy_f_T *localDW)
{
  cell_wrap_4_Algorithm_to_depl_T reshapes[3];
  int32_T i;
  int32_T trueCount;
  real32_T rtu_R_1[18];
  real32_T rtu_R_0[9];
  real32_T tmp_1[9];
  real32_T tmp_0[4];
  real32_T a_0[3];
  real32_T gomega[3];
  real32_T out[3];
  real32_T rtb_T3rd[3];
  real32_T tmp[3];
  real32_T Delay_DSTATE_tmp;
  real32_T Delay_DSTATE_tmp_0;
  real32_T a;
  real32_T a_idx_0;
  real32_T a_idx_1;
  real32_T b;
  real32_T b_0;
  real32_T b_1;
  real32_T b_a_idx_0;
  real32_T b_a_idx_0_0;
  real32_T b_a_idx_1;
  real32_T b_a_idx_1_0;
  real32_T b_a_idx_2;
  real32_T b_a_idx_2_0;
  real32_T cy;
  real32_T cySq;
  real32_T eulShaped_idx_0;
  real32_T eulShaped_idx_1;
  real32_T eulShaped_idx_2;
  real32_T rtb_Add_i_idx_0_tmp;
  real32_T rtb_Add_i_idx_1_tmp;
  real32_T rtb_Add_i_idx_2_tmp;
  real32_T rtb_T3rd_tmp;
  real32_T rtu_R_2;
  real32_T rtu_R_3;
  real32_T rtu_R_4;
  real32_T rtu_pdotms_idx_0;
  real32_T rtu_pdotms_idx_1;
  real32_T rtu_pdotms_idx_2;
  real32_T varargin_1_data;
  real32_T x_data;
  real32_T zB;
  real32_T zB_0;
  real32_T zB_1;
  int8_T zB_tmp[3];
  static const int8_T b_2[3] = { 0, 0, 1 };

  int32_T i_0;
  int32_T varargin_1_data_tmp;

  /* Sum: '<S11>/Add' incorporates:
   *  Delay: '<S11>/Delay'
   *  Delay: '<S11>/Delay1'
   */
  localDW->Delay_DSTATE_d += localDW->Delay1_DSTATE;

  /* MATLAB Function: '<S1>/MATLAB Function2' */
  cySq = rtu_R[0] * rtu_R[0] + rtu_R[1] * rtu_R[1];
  mw_arm_sqrt_f32(&cySq, &cy, 1U);
  eulShaped_idx_0 = rt_atan2f_snf(rtu_R[5], rtu_R[8]);
  eulShaped_idx_1 = rt_atan2f_snf(-rtu_R[2], cy);
  eulShaped_idx_2 = rt_atan2f_snf(rtu_R[1], rtu_R[0]);
  if (cySq < 1.1920929E-6F) {
    trueCount = 0;
    for (i = 0; i < 1; i++) {
      trueCount++;
    }

    if (trueCount - 1 >= 0) {
      x_data = -rtu_R[7];
    }

    if ((int8_T)trueCount - 1 >= 0) {
      varargin_1_data = rt_atan2f_snf(x_data, rtu_R[4]);
    }

    if (trueCount - 1 >= 0) {
      x_data = -rtu_R[2];
    }

    if (trueCount - 1 >= 0) {
      reshapes[1].f1.data = rt_atan2f_snf(x_data, cy);
    }

    if ((int8_T)trueCount - 1 >= 0) {
      gomega[0] = varargin_1_data;
    }

    if (trueCount - 1 >= 0) {
      gomega[1] = reshapes[1].f1.data;
    }

    gomega[2] = 0.0F;
    for (i_0 = 0; i_0 < trueCount; i_0++) {
      eulShaped_idx_0 = gomega[0];
      eulShaped_idx_1 = gomega[1];
      eulShaped_idx_2 = gomega[2];
    }
  }

  /* MATLAB Function: '<S1>/MATLAB Function' incorporates:
   *  MATLAB Function: '<S1>/MATLAB Function2'
   *  MATLAB Function: '<S2>/MATLAB Function'
   */
  x_data = cosf(eulShaped_idx_1);
  varargin_1_data = cosf(eulShaped_idx_0);
  rtb_T3rd_tmp = sinf(eulShaped_idx_0);
  rtb_T3rd[0] = 0.0F;
  rtb_T3rd[1] = rtb_T3rd_tmp / x_data;
  rtb_T3rd[2] = varargin_1_data / x_data;

  /* Sum: '<S12>/Add' incorporates:
   *  Delay: '<S12>/Delay'
   *  Delay: '<S12>/Delay1'
   */
  localDW->Delay_DSTATE_e += localDW->Delay1_DSTATE_k;

  /* Sum: '<S14>/Add' incorporates:
   *  Delay: '<S14>/Delay'
   *  Delay: '<S14>/Delay1'
   *  Delay: '<S18>/Delay'
   */
  localDW->Delay_DSTATE_k[0] += localDW->Delay1_DSTATE_h[0];

  /* MATLAB Function: '<S3>/Linear controllers' */
  b_a_idx_0 = 0.0F;

  /* Sum: '<S14>/Add' incorporates:
   *  Delay: '<S14>/Delay'
   *  Delay: '<S14>/Delay1'
   *  Delay: '<S18>/Delay'
   */
  localDW->Delay_DSTATE_k[1] += localDW->Delay1_DSTATE_h[1];

  /* MATLAB Function: '<S3>/Linear controllers' */
  b_a_idx_1 = 0.0F;

  /* Sum: '<S14>/Add' incorporates:
   *  Delay: '<S14>/Delay'
   *  Delay: '<S14>/Delay1'
   *  Delay: '<S18>/Delay'
   */
  localDW->Delay_DSTATE_k[2] += localDW->Delay1_DSTATE_h[2];

  /* MATLAB Function: '<S3>/Linear controllers' incorporates:
   *  Delay: '<S11>/Delay'
   *  Delay: '<S1>/Delay'
   *  Delay: '<S1>/Delay1'
   *  MATLAB Function: '<S2>/Dynamic Feedback Linearization'
   *  Sum: '<S3>/Add'
   */
  b_a_idx_2 = 0.0F;
  zB = 0.0F;
  zB_0 = 0.0F;
  zB_1 = 0.0F;
  for (i = 0; i < 3; i++) {
    a_idx_0 = rtu_omegarads[i];
    cySq = rtu_R[3 * i];
    b_a_idx_0 += cySq * a_idx_0;
    cy = rtu_R[3 * i + 1];
    b_a_idx_1 += cy * a_idx_0;
    eulShaped_idx_0 = rtu_R[3 * i + 2];
    b_a_idx_2 += eulShaped_idx_0 * a_idx_0;

    /* MATLAB Function: '<S6>/Force Observer (NDO)' */
    zB_tmp[i] = b_2[i];
    i_0 = zB_tmp[i];
    zB += cySq * (real32_T)i_0;
    zB_0 += cy * (real32_T)i_0;
    zB_1 += eulShaped_idx_0 * (real32_T)i_0;
  }

  rtb_Add_i_idx_0_tmp = b_a_idx_1 * zB_1 - zB_0 * b_a_idx_2;
  eulShaped_idx_0 = ((-localDW->Delay_DSTATE_e * zB - rtb_Add_i_idx_0_tmp *
                      localDW->Delay_DSTATE_d) + localDW->Delay1_DSTATE_o[0]) /
    1.55F;
  a_0[0] = ((15.19F * (real32_T)zB_tmp[0] - localDW->Delay_DSTATE_d * zB) +
            localDW->Delay_DSTATE_dt[0]) / 1.55F - rtu_prddotms2[0];
  rtb_Add_i_idx_1_tmp = zB * b_a_idx_2 - b_a_idx_0 * zB_1;
  cySq = ((-localDW->Delay_DSTATE_e * zB_0 - rtb_Add_i_idx_1_tmp *
           localDW->Delay_DSTATE_d) + localDW->Delay1_DSTATE_o[1]) / 1.55F;
  a_0[1] = ((15.19F * (real32_T)zB_tmp[1] - localDW->Delay_DSTATE_d * zB_0) +
            localDW->Delay_DSTATE_dt[1]) / 1.55F - rtu_prddotms2[1];
  rtb_Add_i_idx_2_tmp = b_a_idx_0 * zB_0 - zB * b_a_idx_1;
  cy = ((-localDW->Delay_DSTATE_e * zB_1 - rtb_Add_i_idx_2_tmp *
         localDW->Delay_DSTATE_d) + localDW->Delay1_DSTATE_o[2]) / 1.55F;
  a_0[2] = ((15.19F * (real32_T)zB_tmp[2] - localDW->Delay_DSTATE_d * zB_1) +
            localDW->Delay_DSTATE_dt[2]) / 1.55F - rtu_prddotms2[2];
  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    gomega[i_0] = -((rtCP_Linearcontrollers_mask_k3[i_0 + 3] * cySq +
                     rtCP_Linearcontrollers_mask_k3[i_0] * eulShaped_idx_0) +
                    rtCP_Linearcontrollers_mask_k3[i_0 + 6] * cy);
    Delay_DSTATE_tmp_0 = a_0[i_0];
    a_idx_0 += rtCP_Linearcontrollers_mask_k2[3 * i_0] * Delay_DSTATE_tmp_0;
    a_idx_1 += rtCP_Linearcontrollers_mask_k2[3 * i_0 + 1] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp += rtCP_Linearcontrollers_mask_k2[3 * i_0 + 2] *
      Delay_DSTATE_tmp_0;
  }

  tmp[2] = Delay_DSTATE_tmp;
  tmp[1] = a_idx_1;
  tmp[0] = a_idx_0;
  rtu_pdotms_idx_0 = rtu_pdotms[0] - rtu_prdotms[0];
  eulShaped_idx_0 = rtu_pm[0] - rtu_prm[0];
  a_0[0] = eulShaped_idx_0;
  rtu_pdotms_idx_1 = rtu_pdotms[1] - rtu_prdotms[1];
  cySq = rtu_pm[1] - rtu_prm[1];
  a_0[1] = cySq;
  rtu_pdotms_idx_2 = rtu_pdotms[2] - rtu_prdotms[2];
  cy = rtu_pm[2] - rtu_prm[2];
  a_0[2] = cy;
  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;

  /* MATLAB Function: '<S2>/Dynamic Feedback Linearization' */
  b = 0.0F;
  b_0 = 0.0F;
  b_1 = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    /* MATLAB Function: '<S3>/Linear controllers' incorporates:
     *  MATLAB Function: '<S2>/Dynamic Feedback Linearization'
     */
    out[i_0] = (gomega[i_0] - tmp[i_0]) - ((rtCP_Linearcontrollers_mask_k1[i_0 +
      3] * rtu_pdotms_idx_1 + rtCP_Linearcontrollers_mask_k1[i_0] *
      rtu_pdotms_idx_0) + rtCP_Linearcontrollers_mask_k1[i_0 + 6] *
      rtu_pdotms_idx_2);
    Delay_DSTATE_tmp_0 = a_0[i_0];
    a_idx_0 += rtCP_Linearcontrollers_mask_k0[3 * i_0] * Delay_DSTATE_tmp_0;
    trueCount = 3 * i_0 + 1;
    a_idx_1 += rtCP_Linearcontrollers_mask_k0[trueCount] * Delay_DSTATE_tmp_0;
    i = 3 * i_0 + 2;
    Delay_DSTATE_tmp += rtCP_Linearcontrollers_mask_k0[i] * Delay_DSTATE_tmp_0;

    /* MATLAB Function: '<S2>/Dynamic Feedback Linearization' */
    Delay_DSTATE_tmp_0 = rtu_omegarads[i_0];
    b += rtCP_DynamicFeedbackLineariza_k[3 * i_0] * Delay_DSTATE_tmp_0;
    b_0 += rtCP_DynamicFeedbackLineariza_k[trueCount] * Delay_DSTATE_tmp_0;
    b_1 += rtCP_DynamicFeedbackLineariza_k[i] * Delay_DSTATE_tmp_0;
  }

  /* MATLAB Function: '<S2>/Dynamic Feedback Linearization' incorporates:
   *  Delay: '<S11>/Delay'
   *  Delay: '<S1>/Delay2'
   *  Delay: '<S1>/Delay3'
   *  MATLAB Function: '<S3>/Linear controllers'
   */
  for (i_0 = 0; i_0 < 9; i_0++) {
    rtu_R_0[i_0] = -rtCP_DynamicFeedbackLineariza_c[i_0];
  }

  gomega[0] = rtu_omegarads[1] * b_1 - b_0 * rtu_omegarads[2];
  gomega[1] = b * rtu_omegarads[2] - rtu_omegarads[0] * b_1;
  gomega[2] = rtu_omegarads[0] * b_0 - b * rtu_omegarads[1];
  rtu_pdotms_idx_0 = 0.0F;
  rtu_pdotms_idx_1 = 0.0F;
  rtu_pdotms_idx_2 = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    Delay_DSTATE_tmp_0 = gomega[i_0];
    rtu_pdotms_idx_0 += rtu_R_0[3 * i_0] * Delay_DSTATE_tmp_0;
    rtu_pdotms_idx_1 += rtu_R_0[3 * i_0 + 1] * Delay_DSTATE_tmp_0;
    rtu_pdotms_idx_2 += rtu_R_0[3 * i_0 + 2] * Delay_DSTATE_tmp_0;
  }

  gomega[2] = rtu_pdotms_idx_2;
  gomega[1] = rtu_pdotms_idx_1;
  gomega[0] = rtu_pdotms_idx_0;
  b_a_idx_0_0 = 0.0F;
  b_a_idx_1_0 = 0.0F;
  b_a_idx_2_0 = 0.0F;
  a = -2.0F * localDW->Delay_DSTATE_e;
  b = 0.0F;
  b_0 = 0.0F;
  b_1 = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    Delay_DSTATE_tmp_0 = gomega[i_0];
    b_a_idx_0_0 += rtu_R[3 * i_0] * Delay_DSTATE_tmp_0;
    trueCount = 3 * i_0 + 1;
    b_a_idx_1_0 += rtu_R[trueCount] * Delay_DSTATE_tmp_0;
    varargin_1_data_tmp = 3 * i_0 + 2;
    b_a_idx_2_0 += rtu_R[varargin_1_data_tmp] * Delay_DSTATE_tmp_0;
    rtu_R_2 = 0.0F;
    rtu_R_3 = 0.0F;
    rtu_R_4 = 0.0F;
    for (i = 0; i < 3; i++) {
      Delay_DSTATE_tmp_0 = rtCP_DynamicFeedbackLineariza_c[3 * i_0 + i];
      rtu_R_2 += rtu_R[3 * i] * Delay_DSTATE_tmp_0;
      rtu_R_3 += rtu_R[3 * i + 1] * Delay_DSTATE_tmp_0;
      rtu_R_4 += rtu_R[3 * i + 2] * Delay_DSTATE_tmp_0;
    }

    rtu_R_0[varargin_1_data_tmp] = rtu_R_4;
    rtu_R_0[trueCount] = rtu_R_3;
    rtu_R_0[3 * i_0] = rtu_R_2;
    Delay_DSTATE_tmp_0 = localDW->Delay3_DSTATE[i_0];
    b += rtu_R_0[3 * i_0] * Delay_DSTATE_tmp_0;
    b_0 += rtu_R_0[trueCount] * Delay_DSTATE_tmp_0;
    b_1 += rtu_R_0[varargin_1_data_tmp] * Delay_DSTATE_tmp_0;
  }

  a_idx_0 = ((-(a * rtb_Add_i_idx_0_tmp - ((b_a_idx_1 * rtb_Add_i_idx_2_tmp -
    rtb_Add_i_idx_1_tmp * b_a_idx_2) + (b_a_idx_1_0 * zB_1 - zB_0 * b_a_idx_2_0))
                * localDW->Delay_DSTATE_d) - (zB_0 * b_1 - b_0 * zB_1) *
              localDW->Delay_DSTATE_d) - localDW->Delay2_DSTATE[0]) + (out[0] -
    a_idx_0) * 1.55F;
  a_idx_1 = ((-(a * rtb_Add_i_idx_1_tmp - ((rtb_Add_i_idx_0_tmp * b_a_idx_2 -
    b_a_idx_0 * rtb_Add_i_idx_2_tmp) + (zB * b_a_idx_2_0 - b_a_idx_0_0 * zB_1)) *
                localDW->Delay_DSTATE_d) - (b * zB_1 - zB * b_1) *
              localDW->Delay_DSTATE_d) - localDW->Delay2_DSTATE[1]) + (out[1] -
    a_idx_1) * 1.55F;
  b_0 = ((-(a * rtb_Add_i_idx_2_tmp - ((b_a_idx_0 * rtb_Add_i_idx_1_tmp -
             rtb_Add_i_idx_0_tmp * b_a_idx_1) + (b_a_idx_0_0 * zB_0 - zB *
             b_a_idx_1_0)) * localDW->Delay_DSTATE_d) - (zB * b_0 - b * zB_0) *
          localDW->Delay_DSTATE_d) - localDW->Delay2_DSTATE[2]) + (out[2] -
    Delay_DSTATE_tmp) * 1.55F;

  /* MATLAB Function: '<S2>/MATLAB Function' */
  Delay_DSTATE_tmp = tanf(eulShaped_idx_1);
  Delay_DSTATE_tmp_0 = sinf(eulShaped_idx_1);

  /* MATLAB Function: '<S2>/Dynamic Feedback Linearization' */
  eulShaped_idx_1 = 0.0F;

  /* MATLAB Function: '<S3>/Linear controllers' */
  b = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    /* MATLAB Function: '<S2>/Dynamic Feedback Linearization' incorporates:
     *  Delay: '<S1>/Delay3'
     */
    i = 3 * i_0 + 1;
    trueCount = 3 * i_0 + 2;
    out[i_0] = (rtu_R[3 * i_0] * a_idx_0 + rtu_R[i] * a_idx_1) + rtu_R[trueCount]
      * b_0;
    eulShaped_idx_1 += ((rtCP_DynamicFeedbackLineariza_c[3 * i_0] * 0.0F +
                         rtCP_DynamicFeedbackLineariza_c[i] * rtb_T3rd[1]) +
                        rtCP_DynamicFeedbackLineariza_c[trueCount] * rtb_T3rd[2])
      * localDW->Delay3_DSTATE[i_0];

    /* MATLAB Function: '<S3>/Linear controllers' */
    b += rtb_T3rd[i_0] * rtu_omegarads[i_0];
  }

  /* MATLAB Function: '<S2>/Dynamic Feedback Linearization' incorporates:
   *  Delay: '<S11>/Delay'
   */
  a_idx_0 = out[1] / localDW->Delay_DSTATE_d;
  a_idx_1 = -out[0] / localDW->Delay_DSTATE_d;

  /* MATLAB Function: '<S2>/Control Allocation' incorporates:
   *  MATLAB Function: '<S2>/Dynamic Feedback Linearization'
   */
  gomega[0] = a_idx_0;
  gomega[1] = a_idx_1;

  /* MATLAB Function: '<S2>/Dynamic Feedback Linearization' incorporates:
   *  MATLAB Function: '<S2>/MATLAB Function'
   */
  b_0 = rtu_omegarads[1] * varargin_1_data - rtu_omegarads[2] * rtb_T3rd_tmp;
  b_1 = x_data * x_data;
  Delay_DSTATE_tmp = (rtu_omegarads[2] * varargin_1_data * Delay_DSTATE_tmp +
                      rtu_omegarads[0]) + rtu_omegarads[1] * rtb_T3rd_tmp *
    Delay_DSTATE_tmp;

  /* MATLAB Function: '<S2>/Control Allocation' incorporates:
   *  Delay: '<S11>/Delay'
   *  Delay: '<S2>/Delay'
   *  MATLAB Function: '<S1>/MATLAB Function2'
   *  MATLAB Function: '<S2>/Dynamic Feedback Linearization'
   *  MATLAB Function: '<S2>/MATLAB Function'
   *  MATLAB Function: '<S3>/Linear controllers'
   */
  gomega[2] = (((((((-(rtb_T3rd_tmp * Delay_DSTATE_tmp_0 * b_0 / b_1 +
                       Delay_DSTATE_tmp * varargin_1_data / x_data) *
                     rtu_omegarads[1] + -0.0F * rtu_omegarads[0]) +
                    -(varargin_1_data * Delay_DSTATE_tmp_0 * b_0 / b_1 -
                      Delay_DSTATE_tmp * rtb_T3rd_tmp / x_data) * rtu_omegarads
                    [2]) - ((0.0F * rtu_pdotms_idx_0 + rtb_T3rd[1] *
    rtu_pdotms_idx_1) + rtb_T3rd[2] * rtu_pdotms_idx_2)) - 0.0F * a_idx_0) -
                 rtb_T3rd[1] * a_idx_1) - eulShaped_idx_1) +
               ((*rtu_yawrddotrads2 - (b - *rtu_yawrdotrads) * 3.0F) -
                (eulShaped_idx_2 - *rtu_yawrrad) * 2.0F)) / rtb_T3rd[2];
  eulShaped_idx_2 = 0.0F;
  x_data = 0.0F;
  varargin_1_data = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    a_idx_0 = gomega[i_0];
    eulShaped_idx_2 += rtCP_ControlAllocation_mask_J[3 * i_0] * a_idx_0;
    x_data += rtCP_ControlAllocation_mask_J[3 * i_0 + 1] * a_idx_0;
    varargin_1_data += rtCP_ControlAllocation_mask_J[3 * i_0 + 2] * a_idx_0;
  }

  tmp_0[0] = -localDW->Delay_DSTATE_d;
  tmp_0[1] = eulShaped_idx_2;
  tmp_0[2] = x_data;
  tmp_0[3] = varargin_1_data;
  for (i_0 = 0; i_0 < 6; i_0++) {
    localDW->Delay_DSTATE[i_0] = 0.0F;
  }

  for (i_0 = 0; i_0 < 4; i_0++) {
    a_idx_0 = tmp_0[i_0];
    for (i = 0; i < 6; i++) {
      localDW->Delay_DSTATE[i] += rtCP_ControlAllocation_A_pinv[6 * i_0 + i] *
        a_idx_0;
    }
  }

  /* Gain: '<S2>/Gain1' incorporates:
   *  Delay: '<S2>/Delay'
   */
  for (i = 0; i < 6; i++) {
    rty_u[i] = localDW->Delay_DSTATE[i];
  }

  /* End of Gain: '<S2>/Gain1' */

  /* MATLAB Function: '<S6>/Force Observer (NDO)' */
  eulShaped_idx_2 = rtu_pdotms[1];
  x_data = rtu_pdotms[0];
  varargin_1_data = rtu_pdotms[2];
  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;
  for (i = 0; i < 3; i++) {
    /* Sum: '<S16>/Add' incorporates:
     *  Delay: '<S16>/Delay'
     *  Delay: '<S16>/Delay1'
     */
    rtb_T3rd_tmp = localDW->Delay_DSTATE_j[i] + localDW->Delay1_DSTATE_p[i];
    localDW->Delay_DSTATE_j[i] = rtb_T3rd_tmp;

    /* MATLAB Function: '<S6>/Force Observer (NDO)' */
    rtb_T3rd[i] = ((rtCP_ForceObserverNDO_mask_H[i + 3] * 1.55F *
                    eulShaped_idx_2 + rtCP_ForceObserverNDO_mask_H[i] * 1.55F *
                    x_data) + rtCP_ForceObserverNDO_mask_H[i + 6] * 1.55F *
                   varargin_1_data) + rtb_T3rd_tmp;
    Delay_DSTATE_tmp_0 = rtb_T3rd[i];
    a_idx_0 += rtCP_ForceObserverNDO_mask_C[3 * i] * Delay_DSTATE_tmp_0;
    a_idx_1 += rtCP_ForceObserverNDO_mask_C[3 * i + 1] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp += rtCP_ForceObserverNDO_mask_C[3 * i + 2] *
      Delay_DSTATE_tmp_0;
  }

  /* MATLAB Function: '<S6>/Force Observer (NDO)' incorporates:
   *  Delay: '<S1>/Delay'
   *  Delay: '<S1>/Delay1'
   *  Delay: '<S1>/Delay2'
   */
  gomega[2] = Delay_DSTATE_tmp;
  gomega[1] = a_idx_1;
  gomega[0] = a_idx_0;
  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    localDW->Delay_DSTATE_dt[i_0] = gomega[i_0];
    Delay_DSTATE_tmp_0 = 0.0F;
    eulShaped_idx_2 = 0.0F;
    x_data = 0.0F;
    for (i = 0; i < 3; i++) {
      Delay_DSTATE_tmp_0 += rtCP_ForceObserverNDO_mask_C[3 * i] * 0.0F;
      eulShaped_idx_2 += rtCP_ForceObserverNDO_mask_C[3 * i + 1] * 0.0F;
      x_data += rtCP_ForceObserverNDO_mask_C[3 * i + 2] * 0.0F;
    }

    trueCount = 3 * i_0 + 2;
    rtu_R_0[trueCount] = x_data;
    i = 3 * i_0 + 1;
    rtu_R_0[i] = eulShaped_idx_2;
    rtu_R_0[3 * i_0] = Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp_0 = rtb_T3rd[i_0];
    a_idx_0 += rtu_R_0[3 * i_0] * Delay_DSTATE_tmp_0;
    a_idx_1 += rtu_R_0[i] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp += rtu_R_0[trueCount] * Delay_DSTATE_tmp_0;
  }

  gomega[2] = Delay_DSTATE_tmp;
  gomega[1] = a_idx_1;
  gomega[0] = a_idx_0;
  for (i_0 = 0; i_0 < 3; i_0++) {
    localDW->Delay1_DSTATE_o[i_0] = gomega[i_0];
    rtu_R_0[3 * i_0] = 0.0F;
    i = 3 * i_0 + 1;
    rtu_R_0[i] = 0.0F;
    varargin_1_data_tmp = 3 * i_0 + 2;
    rtu_R_0[varargin_1_data_tmp] = 0.0F;
    for (trueCount = 0; trueCount < 3; trueCount++) {
      tmp_1[trueCount + 3 * i_0] = 0.0F;
    }

    a_idx_0 = tmp_1[3 * i_0];
    a_idx_1 = tmp_1[i];
    Delay_DSTATE_tmp = tmp_1[varargin_1_data_tmp];
    for (trueCount = 0; trueCount < 3; trueCount++) {
      Delay_DSTATE_tmp_0 = rtu_R_0[3 * i_0 + trueCount];
      a_idx_0 += rtCP_ForceObserverNDO_mask_C[3 * trueCount] *
        Delay_DSTATE_tmp_0;
      a_idx_1 += rtCP_ForceObserverNDO_mask_C[3 * trueCount + 1] *
        Delay_DSTATE_tmp_0;
      Delay_DSTATE_tmp += rtCP_ForceObserverNDO_mask_C[3 * trueCount + 2] *
        Delay_DSTATE_tmp_0;
    }

    tmp_1[varargin_1_data_tmp] = Delay_DSTATE_tmp;
    tmp_1[i] = a_idx_1;
    tmp_1[3 * i_0] = a_idx_0;
  }

  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    Delay_DSTATE_tmp_0 = rtb_T3rd[i_0];
    a_idx_0 += tmp_1[3 * i_0] * Delay_DSTATE_tmp_0;
    a_idx_1 += tmp_1[3 * i_0 + 1] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp += tmp_1[3 * i_0 + 2] * Delay_DSTATE_tmp_0;
  }

  localDW->Delay2_DSTATE[0] = a_idx_0;
  localDW->Delay2_DSTATE[1] = a_idx_1;
  localDW->Delay2_DSTATE[2] = Delay_DSTATE_tmp;
  for (i_0 = 0; i_0 < 6; i_0++) {
    rtu_R_2 = 0.0F;
    rtu_R_3 = 0.0F;
    rtu_R_4 = 0.0F;
    for (i = 0; i < 3; i++) {
      a_idx_0 = rtCP_ForceObserverNDO_mask_F1[3 * i_0 + i];
      rtu_R_2 += rtu_R[3 * i] * a_idx_0;
      rtu_R_3 += rtu_R[3 * i + 1] * a_idx_0;
      rtu_R_4 += rtu_R[3 * i + 2] * a_idx_0;
    }

    rtu_R_1[3 * i_0 + 2] = rtu_R_4;
    rtu_R_1[3 * i_0 + 1] = rtu_R_3;
    rtu_R_1[3 * i_0] = rtu_R_2;
  }

  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;
  Delay_DSTATE_tmp_0 = 0.0F;
  eulShaped_idx_2 = 0.0F;
  x_data = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    varargin_1_data = 0.0F;
    for (i = 0; i < 6; i++) {
      varargin_1_data += rtu_R_1[3 * i + i_0] * rty_u[i];
    }

    a_0[i_0] = 15.19F * (real32_T)zB_tmp[i_0] + varargin_1_data;
    varargin_1_data = rtb_T3rd[i_0];
    a_idx_0 += rtCP_ForceObserverNDO_mask_AH[3 * i_0] * varargin_1_data;
    trueCount = 3 * i_0 + 1;
    a_idx_1 += rtCP_ForceObserverNDO_mask_AH[trueCount] * varargin_1_data;
    i = 3 * i_0 + 2;
    Delay_DSTATE_tmp += rtCP_ForceObserverNDO_mask_AH[i] * varargin_1_data;
    varargin_1_data = a_0[i_0];
    Delay_DSTATE_tmp_0 += rtCP_ForceObserverNDO_mask_H[3 * i_0] *
      varargin_1_data;
    eulShaped_idx_2 += rtCP_ForceObserverNDO_mask_H[trueCount] * varargin_1_data;
    x_data += rtCP_ForceObserverNDO_mask_H[i] * varargin_1_data;
  }

  gomega[2] = Delay_DSTATE_tmp;
  gomega[1] = a_idx_1;
  gomega[0] = a_idx_0;
  tmp[2] = x_data;
  tmp[1] = eulShaped_idx_2;
  tmp[0] = Delay_DSTATE_tmp_0;
  for (i = 0; i < 3; i++) {
    /* Gain: '<S16>/Gain' incorporates:
     *  Delay: '<S16>/Delay1'
     *  MATLAB Function: '<S6>/Force Observer (NDO)'
     */
    localDW->Delay1_DSTATE_p[i] = (gomega[i] - tmp[i]) * 0.005F;

    /* Sum: '<S18>/Add' incorporates:
     *  Delay: '<S18>/Delay'
     *  Delay: '<S18>/Delay1'
     */
    localDW->Delay_DSTATE_dm[i] += localDW->Delay1_DSTATE_hw[i];

    /* MATLAB Function: '<S7>/Force Observer (NDO)' */
    a_idx_0 = 0.0F;
    a_idx_1 = 0.0F;
    Delay_DSTATE_tmp = 0.0F;
    for (i_0 = 0; i_0 < 3; i_0++) {
      Delay_DSTATE_tmp_0 = rtCP_ForceObserverNDO_mask_J[3 * i + i_0];
      a_idx_0 += rtCP_ForceObserverNDO_mask_H_f[3 * i_0] * Delay_DSTATE_tmp_0;
      a_idx_1 += rtCP_ForceObserverNDO_mask_H_f[3 * i_0 + 1] *
        Delay_DSTATE_tmp_0;
      Delay_DSTATE_tmp += rtCP_ForceObserverNDO_mask_H_f[3 * i_0 + 2] *
        Delay_DSTATE_tmp_0;
    }

    rtu_R_0[3 * i + 2] = Delay_DSTATE_tmp;
    rtu_R_0[3 * i + 1] = a_idx_1;
    rtu_R_0[3 * i] = a_idx_0;
  }

  /* MATLAB Function: '<S7>/Force Observer (NDO)' incorporates:
   *  Delay: '<S18>/Delay'
   *  Delay: '<S1>/Delay3'
   */
  eulShaped_idx_2 = rtu_omegarads[1];
  x_data = rtu_omegarads[0];
  varargin_1_data = rtu_omegarads[2];
  b = 0.0F;
  b_0 = 0.0F;
  b_1 = 0.0F;
  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    rtb_T3rd[i_0] = ((rtu_R_0[i_0 + 3] * eulShaped_idx_2 + rtu_R_0[i_0] * x_data)
                     + rtu_R_0[i_0 + 6] * varargin_1_data) +
      localDW->Delay_DSTATE_dm[i_0];
    Delay_DSTATE_tmp_0 = rtu_omegarads[i_0];
    b += rtCP_ForceObserverNDO_mask_J[3 * i_0] * Delay_DSTATE_tmp_0;
    trueCount = 3 * i_0 + 1;
    b_0 += rtCP_ForceObserverNDO_mask_J[trueCount] * Delay_DSTATE_tmp_0;
    i = 3 * i_0 + 2;
    b_1 += rtCP_ForceObserverNDO_mask_J[i] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp_0 = rtb_T3rd[i_0];
    a_idx_0 += rtCP_ForceObserverNDO_mask_C_c[3 * i_0] * Delay_DSTATE_tmp_0;
    a_idx_1 += rtCP_ForceObserverNDO_mask_C_c[trueCount] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp += rtCP_ForceObserverNDO_mask_C_c[i] * Delay_DSTATE_tmp_0;
  }

  localDW->Delay3_DSTATE[0] = a_idx_0;
  eulShaped_idx_2 = 0.0F;
  localDW->Delay3_DSTATE[1] = a_idx_1;
  x_data = 0.0F;
  localDW->Delay3_DSTATE[2] = Delay_DSTATE_tmp;
  varargin_1_data = 0.0F;
  for (i_0 = 0; i_0 < 6; i_0++) {
    a_idx_0 = rty_u[i_0];
    eulShaped_idx_2 += rtCP_ForceObserverNDO_mask_F2[3 * i_0] * a_idx_0;
    x_data += rtCP_ForceObserverNDO_mask_F2[3 * i_0 + 1] * a_idx_0;
    varargin_1_data += rtCP_ForceObserverNDO_mask_F2[3 * i_0 + 2] * a_idx_0;
  }

  gomega[0] = -(rtu_omegarads[1] * b_1 - b_0 * rtu_omegarads[2]) +
    eulShaped_idx_2;
  eulShaped_idx_2 = 0.0F;
  gomega[1] = -(b * rtu_omegarads[2] - rtu_omegarads[0] * b_1) + x_data;
  x_data = 0.0F;
  gomega[2] = -(rtu_omegarads[0] * b_0 - b * rtu_omegarads[1]) + varargin_1_data;
  varargin_1_data = 0.0F;
  a_idx_0 = 0.0F;
  a_idx_1 = 0.0F;
  Delay_DSTATE_tmp = 0.0F;
  for (i_0 = 0; i_0 < 3; i_0++) {
    Delay_DSTATE_tmp_0 = rtb_T3rd[i_0];
    eulShaped_idx_2 += rtCP_ForceObserverNDO_mask_AH_a[3 * i_0] *
      Delay_DSTATE_tmp_0;
    trueCount = 3 * i_0 + 1;
    x_data += rtCP_ForceObserverNDO_mask_AH_a[trueCount] * Delay_DSTATE_tmp_0;
    i = 3 * i_0 + 2;
    varargin_1_data += rtCP_ForceObserverNDO_mask_AH_a[i] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp_0 = gomega[i_0];
    a_idx_0 += rtCP_ForceObserverNDO_mask_H_f[3 * i_0] * Delay_DSTATE_tmp_0;
    a_idx_1 += rtCP_ForceObserverNDO_mask_H_f[trueCount] * Delay_DSTATE_tmp_0;
    Delay_DSTATE_tmp += rtCP_ForceObserverNDO_mask_H_f[i] * Delay_DSTATE_tmp_0;
  }

  /* Gain: '<S12>/Gain' incorporates:
   *  Delay: '<S12>/Delay1'
   *  MATLAB Function: '<S2>/Dynamic Feedback Linearization'
   */
  localDW->Delay1_DSTATE_k = 0.005F * -out[2];

  /* Gain: '<S18>/Gain' incorporates:
   *  Delay: '<S18>/Delay1'
   *  MATLAB Function: '<S7>/Force Observer (NDO)'
   */
  localDW->Delay1_DSTATE_hw[0] = (eulShaped_idx_2 - a_idx_0) * 0.005F;

  /* Gain: '<S14>/Gain' incorporates:
   *  Delay: '<S14>/Delay1'
   */
  localDW->Delay1_DSTATE_h[0] = eulShaped_idx_0 * 0.005F;

  /* Gain: '<S18>/Gain' incorporates:
   *  Delay: '<S18>/Delay1'
   *  MATLAB Function: '<S7>/Force Observer (NDO)'
   */
  localDW->Delay1_DSTATE_hw[1] = (x_data - a_idx_1) * 0.005F;

  /* Gain: '<S14>/Gain' incorporates:
   *  Delay: '<S14>/Delay1'
   */
  localDW->Delay1_DSTATE_h[1] = cySq * 0.005F;

  /* Gain: '<S18>/Gain' incorporates:
   *  Delay: '<S18>/Delay1'
   *  MATLAB Function: '<S7>/Force Observer (NDO)'
   */
  localDW->Delay1_DSTATE_hw[2] = (varargin_1_data - Delay_DSTATE_tmp) * 0.005F;

  /* Gain: '<S14>/Gain' incorporates:
   *  Delay: '<S14>/Delay1'
   */
  localDW->Delay1_DSTATE_h[2] = cy * 0.005F;

  /* Update for Delay: '<S11>/Delay1' incorporates:
   *  Gain: '<S11>/Gain'
   */
  localDW->Delay1_DSTATE = 0.005F * localDW->Delay_DSTATE_e;
}

/* Model initialize function */
void Algorithm_to_deploy_initialize(const char_T **rt_errorStatus,
  RT_MODEL_Algorithm_to_deploy_T *const Algorithm_to_deploy_M)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatusPointer(Algorithm_to_deploy_M, rt_errorStatus);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
