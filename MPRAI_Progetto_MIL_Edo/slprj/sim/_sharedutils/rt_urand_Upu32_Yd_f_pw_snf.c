#include "rtwtypes.h"
#include "rt_urand_Upu32_Yd_f_pw_snf.h"
real_T rt_urand_Upu32_Yd_f_pw_snf ( uint32_T * u_prot ) { uint32_T hi_prot ;
uint32_T lo_prot ; lo_prot = * u_prot % 127773U * 16807U ; hi_prot = * u_prot
/ 127773U * 2836U ; if ( lo_prot < hi_prot ) { * u_prot = 2147483647U - ( hi_prot - lo_prot ) ; } else { * u_prot = lo_prot - hi_prot ; } return ( real_T ) * u_prot * 4.6566128752457969E-10 ; }
