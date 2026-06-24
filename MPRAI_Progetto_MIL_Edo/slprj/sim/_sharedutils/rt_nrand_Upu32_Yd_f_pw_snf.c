#include "rtwtypes.h"
#include "rt_nrand_Upu32_Yd_f_pw_snf.h"
#include "rt_urand_Upu32_Yd_f_pw_snf.h"
#include "mwmathutil.h"
real_T rt_nrand_Upu32_Yd_f_pw_snf ( uint32_T * u_prot ) { real_T si_prot ;
real_T sr_prot ; real_T y_prot ; do { sr_prot = 2.0 *
rt_urand_Upu32_Yd_f_pw_snf ( u_prot ) - 1.0 ; si_prot = 2.0 *
rt_urand_Upu32_Yd_f_pw_snf ( u_prot ) - 1.0 ; si_prot = sr_prot * sr_prot +
si_prot * si_prot ; } while ( si_prot > 1.0 ) ; y_prot = muDoubleScalarSqrt ( -
2.0 * muDoubleScalarLog ( si_prot ) / si_prot ) * sr_prot ; return y_prot ; }
