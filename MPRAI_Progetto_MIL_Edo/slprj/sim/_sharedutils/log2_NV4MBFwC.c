#include "rtwtypes.h"
#include "log2_NV4MBFwC.h"
#include "mwmathutil.h"
#include <math.h>
#include "rt_nonfinite.h"
real_T log2_NV4MBFwC ( real_T x_prot ) { real_T f_prot ; real_T t_prot ;
int32_T inte_prot ; if ( x_prot == 0.0 ) { f_prot = ( rtMinusInf ) ; } else
if ( ( ! muDoubleScalarIsInf ( x_prot ) ) && ( ! muDoubleScalarIsNaN ( x_prot
) ) ) { t_prot = frexp ( x_prot , & inte_prot ) ; if ( t_prot == 0.5 ) {
f_prot = ( real_T ) inte_prot - 1.0 ; } else if ( ( inte_prot == 1 ) && ( t_prot
< 0.75 ) ) { f_prot = muDoubleScalarLog ( 2.0 * t_prot ) /
0.69314718055994529 ; } else { f_prot = muDoubleScalarLog ( t_prot ) /
0.69314718055994529 + ( real_T ) inte_prot ; } } else { f_prot = x_prot ; }
return f_prot ; }
