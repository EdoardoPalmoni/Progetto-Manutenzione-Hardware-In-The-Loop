#include "rtwtypes.h"
#include "eml_rand_shr3cong_JYuPX7KM.h"
#include "mwmathutil.h"
real_T eml_rand_shr3cong_JYuPX7KM ( uint32_T state_prot [ 2 ] ) { real_T
r_prot ; real_T r_tmp_prot ; real_T s_prot ; real_T x_prot ; real_T y_prot ;
uint32_T icng_prot ; uint32_T j_prot ; uint32_T jsr_prot ; uint32_T ui_prot ;
static const real_T b_prot [ 65 ] = { 0.340945 , 0.4573146 , 0.5397793 ,
0.6062427 , 0.6631691 , 0.7136975 , 0.7596125 , 0.8020356 , 0.8417227 ,
0.8792102 , 0.9148948 , 0.9490791 , 0.9820005 , 1.0138492 , 1.044781 ,
1.0749254 , 1.1043917 , 1.1332738 , 1.161653 , 1.189601 , 1.2171815 ,
1.2444516 , 1.2714635 , 1.298265 , 1.3249008 , 1.3514125 , 1.3778399 ,
1.4042211 , 1.4305929 , 1.4569915 , 1.4834527 , 1.5100122 , 1.5367061 ,
1.5635712 , 1.5906454 , 1.617968 , 1.6455802 , 1.6735255 , 1.7018503 ,
1.7306045 , 1.7598422 , 1.7896223 , 1.8200099 , 1.851077 , 1.8829044 ,
1.9155831 , 1.9492166 , 1.9839239 , 2.0198431 , 2.0571356 , 2.095993 ,
2.136645 , 2.1793713 , 2.2245175 , 2.2725186 , 2.3239338 , 2.3795008 ,
2.4402218 , 2.5075117 , 2.5834658 , 2.6713916 , 2.7769942 , 2.7769942 ,
2.7769942 , 2.7769942 } ; icng_prot = 69069U * state_prot [ 0 ] + 1234567U ;
jsr_prot = state_prot [ 1 ] << 13 ^ state_prot [ 1 ] ; jsr_prot ^= jsr_prot
>> 17 ; jsr_prot ^= jsr_prot << 5 ; ui_prot = icng_prot + jsr_prot ; j_prot =
( ui_prot & 63U ) + 1U ; r_tmp_prot = b_prot [ ( int32_T ) j_prot ] ; r_prot
= ( real_T ) ( int32_T ) ui_prot * 4.6566128730773926E-10 * r_tmp_prot ;
x_prot = muDoubleScalarAbs ( r_prot ) ; y_prot = b_prot [ ( int32_T ) j_prot
- 1 ] ; if ( ! ( x_prot <= y_prot ) ) { x_prot = ( x_prot - y_prot ) / ( r_tmp_prot - y_prot ) ; icng_prot = 69069U * icng_prot + 1234567U ; jsr_prot ^= jsr_prot << 13 ; jsr_prot ^= jsr_prot >> 17 ; jsr_prot ^= jsr_prot << 5 ; y_prot = ( real_T ) ( int32_T ) ( icng_prot + jsr_prot ) * 2.328306436538696E-10 + 0.5 ; s_prot = x_prot + y_prot ; if ( s_prot > 1.301198 ) { if ( r_prot < 0.0 ) { r_prot = 0.4878992 * x_prot - 0.4878992 ; } else { r_prot = 0.4878992 - 0.4878992 * x_prot ; } } else if ( ! ( s_prot <= 0.9689279 ) ) { x_prot = 0.4878992 - 0.4878992 * x_prot ; if ( y_prot > 12.67706 - muDoubleScalarExp ( - 0.5 * x_prot * x_prot ) * 12.37586 ) { if ( r_prot < 0.0 ) { r_prot = - x_prot ; } else { r_prot = x_prot ; } } else if ( ! ( muDoubleScalarExp ( - 0.5 * r_tmp_prot * r_tmp_prot ) + y_prot * 0.01958303 / r_tmp_prot <= muDoubleScalarExp ( - 0.5 * r_prot * r_prot ) ) ) { do { icng_prot = 69069U * icng_prot + 1234567U ; jsr_prot ^= jsr_prot << 13 ; jsr_prot ^= jsr_prot >> 17 ; jsr_prot ^= jsr_prot << 5 ; x_prot = muDoubleScalarLog ( ( real_T ) ( int32_T ) ( icng_prot + jsr_prot ) * 2.328306436538696E-10 + 0.5 ) / 2.776994 ; icng_prot = 69069U * icng_prot + 1234567U ; jsr_prot ^= jsr_prot << 13 ; jsr_prot ^= jsr_prot >> 17 ; jsr_prot ^= jsr_prot << 5 ; } while ( ! ( muDoubleScalarLog ( ( real_T ) ( int32_T ) ( icng_prot + jsr_prot ) * 2.328306436538696E-10 + 0.5 ) * - 2.0 > x_prot * x_prot ) ) ; if ( r_prot < 0.0 ) { r_prot = x_prot - 2.776994 ; } else { r_prot = 2.776994 - x_prot ; } } } } state_prot [ 0 ] = icng_prot ; state_prot [ 1 ] = jsr_prot ; return r_prot ; }
