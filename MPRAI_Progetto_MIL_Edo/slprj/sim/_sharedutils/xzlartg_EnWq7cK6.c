#include "rtwtypes.h"
#include "xzlartg_EnWq7cK6.h"
#include "mwmathutil.h"
void xzlartg_EnWq7cK6 ( real_T f_prot , real_T g_prot , real_T * cs_prot ,
real_T * sn_prot , real_T * r_prot ) { real_T f1_prot ; real_T fs_prot ;
real_T gs_prot ; f1_prot = muDoubleScalarAbs ( f_prot ) ; * r_prot =
muDoubleScalarAbs ( g_prot ) ; if ( g_prot == 0.0 ) { * cs_prot = 1.0 ; *
sn_prot = 0.0 ; * r_prot = f_prot ; } else if ( f_prot == 0.0 ) { * cs_prot =
0.0 ; if ( g_prot >= 0.0 ) { * sn_prot = 1.0 ; } else { * sn_prot = - 1.0 ; }
} else if ( ( f1_prot > 1.4916681462400413E-154 ) && ( f1_prot <
4.7403759540545887E+153 ) && ( * r_prot > 1.4916681462400413E-154 ) && ( *
r_prot < 4.7403759540545887E+153 ) ) { * r_prot = muDoubleScalarSqrt ( f_prot
* f_prot + g_prot * g_prot ) ; * cs_prot = f1_prot / * r_prot ; if ( ! ( f_prot
>= 0.0 ) ) { * r_prot = - * r_prot ; } * sn_prot = g_prot / * r_prot ; } else
{ f1_prot = muDoubleScalarMin ( 4.49423283715579E+307 , muDoubleScalarMax ( 2.2250738585072014E-308 , muDoubleScalarMax ( f1_prot , * r_prot ) ) ) ; fs_prot = f_prot / f1_prot ; gs_prot = g_prot / f1_prot ; * r_prot = muDoubleScalarSqrt ( fs_prot * fs_prot + gs_prot * gs_prot ) ; * cs_prot = muDoubleScalarAbs ( fs_prot ) / * r_prot ; if ( ! ( f_prot >= 0.0 ) ) { * r_prot = - * r_prot ; } * sn_prot = gs_prot / * r_prot ; * r_prot *= f1_prot ; } }
