#include "rtwtypes.h"
#include "norm_dhO47Bzt.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"
real_T norm_dhO47Bzt ( const real_T x_prot [ 9 ] ) { real_T s_prot ; real_T
y_prot ; int32_T j_prot ; boolean_T exitg1 ; y_prot = 0.0 ; j_prot = 0 ;
exitg1 = false ; while ( ( ! exitg1 ) && ( j_prot < 3 ) ) { s_prot = ( muDoubleScalarAbs ( x_prot [ 3 * j_prot + 1 ] ) + muDoubleScalarAbs ( x_prot [ 3 * j_prot ] ) ) + muDoubleScalarAbs ( x_prot [ 3 * j_prot + 2 ] ) ; if ( muDoubleScalarIsNaN ( s_prot ) ) { y_prot = ( rtNaN ) ; exitg1 = true ; } else { if ( s_prot > y_prot ) { y_prot = s_prot ; } j_prot ++ ; } } return y_prot ; }
