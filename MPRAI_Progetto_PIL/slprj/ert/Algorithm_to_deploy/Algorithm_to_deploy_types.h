/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Algorithm_to_deploy_types.h
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

#ifndef Algorithm_to_deploy_types_h_
#define Algorithm_to_deploy_types_h_
#include "rtwtypes.h"
#ifndef struct_emxArray_real32_T_1x1x1
#define struct_emxArray_real32_T_1x1x1

struct emxArray_real32_T_1x1x1
{
  real32_T data;
  int32_T size[3];
};

#endif                                 /* struct_emxArray_real32_T_1x1x1 */

#ifndef typedef_emxArray_real32_T_1x1x1_Algor_T
#define typedef_emxArray_real32_T_1x1x1_Algor_T

typedef struct emxArray_real32_T_1x1x1 emxArray_real32_T_1x1x1_Algor_T;

#endif                             /* typedef_emxArray_real32_T_1x1x1_Algor_T */

#ifndef struct_tag_Xhu7O64DRxIVq4nB1ag53B
#define struct_tag_Xhu7O64DRxIVq4nB1ag53B

struct tag_Xhu7O64DRxIVq4nB1ag53B
{
  emxArray_real32_T_1x1x1_Algor_T f1;
};

#endif                                 /* struct_tag_Xhu7O64DRxIVq4nB1ag53B */

#ifndef typedef_cell_wrap_4_Algorithm_to_depl_T
#define typedef_cell_wrap_4_Algorithm_to_depl_T

typedef struct tag_Xhu7O64DRxIVq4nB1ag53B cell_wrap_4_Algorithm_to_depl_T;

#endif                             /* typedef_cell_wrap_4_Algorithm_to_depl_T */

/* Forward declaration for rtModel */
typedef struct tag_RTM_Algorithm_to_deploy_T RT_MODEL_Algorithm_to_deploy_T;

#endif                                 /* Algorithm_to_deploy_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
