/*
 * File: coder_assumptions.h
 *
 * Abstract: Coder assumptions header file
 */

#ifndef CODER_ASSUMPTIONS_H
#define CODER_ASSUMPTIONS_H

/* include model specific checks */
#include "Algorithm_to_deploy_ca.h"

/* global results variable mapping for static code */
#define CA_Expected                    CA_Algorithm_to_deploy_Exp
#define CA_Actual                      CA_Algorithm_to_deploy_Act
#define CA_TestResults                 CA_Algorithm_to_deploy_Res
#define CA_PortableWordSizes_Results   CA_Algorithm_to_deploy_PWSRes

/* entry point function mapping for static code */
#define CA_Run_Tests                   Algorithm_to_deploy_caRunTests
#define CA_MODEL_SPECIFIC_CHECKS_ENABLED 0
#endif                                 /* CODER_ASSUMPTIONS_H */
