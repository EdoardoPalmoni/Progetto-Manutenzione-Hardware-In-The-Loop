#include "rtwtypes.h"
#include "genrandu_PP7J367r.h"
void genrandu_PP7J367r ( uint32_T s_prot , uint32_T * state_prot , real_T *
r_prot ) { uint32_T a_prot ; uint32_T hi_prot ; hi_prot = s_prot / 127773U ;
a_prot = ( s_prot - hi_prot * 127773U ) * 16807U ; hi_prot *= 2836U ; if ( a_prot < hi_prot ) { * state_prot = ~ ( hi_prot - a_prot ) & 2147483647U ; } else { * state_prot = a_prot - hi_prot ; } * r_prot = ( real_T ) * state_prot * 4.6566128752457969E-10 ; }
