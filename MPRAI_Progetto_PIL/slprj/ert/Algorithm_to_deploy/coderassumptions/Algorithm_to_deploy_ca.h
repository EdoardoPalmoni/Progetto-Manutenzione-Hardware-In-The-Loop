/*
 * File: Algorithm_to_deploy_ca.h
 *
 * Abstract: Tests assumptions in the generated code.
 */

#ifndef ALGORITHM_TO_DEPLOY_CA_H
#define ALGORITHM_TO_DEPLOY_CA_H

/* preprocessor validation checks */
#include "Algorithm_to_deploy_ca_preproc.h"
#include "coder_assumptions_hwimpl.h"

/* variables holding test results */
extern CA_ChecksTestResults CA_Algorithm_to_deploy_Res;
extern CA_PWS_TestResults CA_Algorithm_to_deploy_PWSRes;

/* variables holding "expected" and "actual" hardware implementation */
extern const CA_Checks CA_Algorithm_to_deploy_Exp;
extern CA_Checks CA_Algorithm_to_deploy_Act;
extern const int numberOfImportedTypes;

/* entry point function to run tests */
void Algorithm_to_deploy_caRunTests(void);

#endif                                 /* ALGORITHM_TO_DEPLOY_CA_H */
