#include "rtwtypes.h"
#include "recomputeBlockDiag_LVGklLwo.h"
#include "mwmathutil.h"
#include <emmintrin.h>
void recomputeBlockDiag_LVGklLwo ( const real_T A_prot [ 9 ] , real_T F_prot
[ 9 ] , const int32_T blockFormat_prot [ 2 ] ) { real_T tmp_prot [ 2 ] ;
real_T delta_prot ; real_T expa_prot ; real_T sinchdelta_prot ; real_T x_prot
; if ( blockFormat_prot [ 0 ] != 0 ) { if ( blockFormat_prot [ 0 ] == 1 ) {
delta_prot = muDoubleScalarExp ( A_prot [ 0 ] ) ; expa_prot =
muDoubleScalarExp ( A_prot [ 4 ] ) ; sinchdelta_prot = ( A_prot [ 0 ] +
A_prot [ 4 ] ) / 2.0 ; if ( muDoubleScalarMax ( sinchdelta_prot ,
muDoubleScalarAbs ( A_prot [ 0 ] - A_prot [ 4 ] ) / 2.0 ) < 709.782712893384
) { x_prot = ( A_prot [ 4 ] - A_prot [ 0 ] ) / 2.0 ; if ( x_prot == 0.0 ) {
x_prot = 1.0 ; } else { x_prot = muDoubleScalarSinh ( x_prot ) / x_prot ; }
sinchdelta_prot = A_prot [ 3 ] * muDoubleScalarExp ( sinchdelta_prot ) *
x_prot ; } else { sinchdelta_prot = ( expa_prot - delta_prot ) * A_prot [ 3 ]
/ ( A_prot [ 4 ] - A_prot [ 0 ] ) ; } F_prot [ 0 ] = delta_prot ; F_prot [ 3
] = sinchdelta_prot ; F_prot [ 4 ] = expa_prot ; } else { delta_prot =
muDoubleScalarSqrt ( muDoubleScalarAbs ( A_prot [ 1 ] * A_prot [ 3 ] ) ) ;
expa_prot = muDoubleScalarExp ( A_prot [ 0 ] ) ; if ( delta_prot == 0.0 ) {
sinchdelta_prot = 1.0 ; } else { sinchdelta_prot = muDoubleScalarSin ( delta_prot ) / delta_prot ; } F_prot [ 0 ] = expa_prot * muDoubleScalarCos ( delta_prot ) ; _mm_storeu_pd ( & tmp_prot [ 0 ] , _mm_mul_pd ( _mm_mul_pd ( _mm_set1_pd ( expa_prot ) , _mm_set_pd ( A_prot [ 3 ] , A_prot [ 1 ] ) ) , _mm_set1_pd ( sinchdelta_prot ) ) ) ; F_prot [ 1 ] = tmp_prot [ 0 ] ; F_prot [ 3 ] = tmp_prot [ 1 ] ; F_prot [ 4 ] = F_prot [ 0 ] ; } } if ( blockFormat_prot [ 1 ] != 0 ) { if ( blockFormat_prot [ 1 ] == 1 ) { delta_prot = muDoubleScalarExp ( A_prot [ 4 ] ) ; expa_prot = muDoubleScalarExp ( A_prot [ 8 ] ) ; sinchdelta_prot = ( A_prot [ 4 ] + A_prot [ 8 ] ) / 2.0 ; if ( muDoubleScalarMax ( sinchdelta_prot , muDoubleScalarAbs ( A_prot [ 4 ] - A_prot [ 8 ] ) / 2.0 ) < 709.782712893384 ) { x_prot = ( A_prot [ 8 ] - A_prot [ 4 ] ) / 2.0 ; if ( x_prot == 0.0 ) { x_prot = 1.0 ; } else { x_prot = muDoubleScalarSinh ( x_prot ) / x_prot ; } sinchdelta_prot = A_prot [ 7 ] * muDoubleScalarExp ( sinchdelta_prot ) * x_prot ; } else { sinchdelta_prot = ( expa_prot - delta_prot ) * A_prot [ 7 ] / ( A_prot [ 8 ] - A_prot [ 4 ] ) ; } F_prot [ 4 ] = delta_prot ; F_prot [ 7 ] = sinchdelta_prot ; F_prot [ 8 ] = expa_prot ; } else { delta_prot = muDoubleScalarSqrt ( muDoubleScalarAbs ( A_prot [ 5 ] * A_prot [ 7 ] ) ) ; expa_prot = muDoubleScalarExp ( A_prot [ 4 ] ) ; if ( delta_prot == 0.0 ) { sinchdelta_prot = 1.0 ; } else { sinchdelta_prot = muDoubleScalarSin ( delta_prot ) / delta_prot ; } F_prot [ 4 ] = expa_prot * muDoubleScalarCos ( delta_prot ) ; _mm_storeu_pd ( & tmp_prot [ 0 ] , _mm_mul_pd ( _mm_mul_pd ( _mm_set1_pd ( expa_prot ) , _mm_set_pd ( A_prot [ 7 ] , A_prot [ 5 ] ) ) , _mm_set1_pd ( sinchdelta_prot ) ) ) ; F_prot [ 5 ] = tmp_prot [ 0 ] ; F_prot [ 7 ] = tmp_prot [ 1 ] ; F_prot [ 8 ] = F_prot [ 4 ] ; } } if ( blockFormat_prot [ 1 ] == 0 ) { F_prot [ 8 ] = muDoubleScalarExp ( A_prot [ 8 ] ) ; } }
