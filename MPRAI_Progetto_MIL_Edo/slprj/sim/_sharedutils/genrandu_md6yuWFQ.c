#include "rtwtypes.h"
#include "genrandu_md6yuWFQ.h"
#include "genrand_uint32_vector_VMchaRuj.h"
real_T genrandu_md6yuWFQ ( uint32_T mt_prot [ 625 ] ) { real_T r_prot ;
int32_T exitg1 ; int32_T k_prot ; uint32_T b_u_prot [ 2 ] ; uint32_T
u_idx_0_prot ; uint32_T u_idx_1_prot ; boolean_T b_isvalid_prot ; boolean_T
exitg2 ; do { exitg1 = 0 ; genrand_uint32_vector_VMchaRuj ( mt_prot ,
b_u_prot ) ; u_idx_0_prot = b_u_prot [ 0 ] >> 5U ; u_idx_1_prot = b_u_prot [
1 ] >> 6U ; if ( ( u_idx_0_prot == 0U ) && ( u_idx_1_prot == 0U ) ) { if ( ( mt_prot [ 624 ] >= 1U ) && ( mt_prot [ 624 ] < 625U ) ) { b_isvalid_prot = false ; k_prot = 1 ; exitg2 = false ; while ( ( ! exitg2 ) && ( k_prot < 625 ) ) { if ( mt_prot [ k_prot - 1 ] == 0U ) { k_prot ++ ; } else { b_isvalid_prot = true ; exitg2 = true ; } } } else { b_isvalid_prot = false ; } if ( ! b_isvalid_prot ) { u_idx_0_prot = 5489U ; mt_prot [ 0 ] = 5489U ; for ( k_prot = 0 ; k_prot < 623 ; k_prot ++ ) { u_idx_0_prot = ( ( u_idx_0_prot >> 30U ^ u_idx_0_prot ) * 1812433253U + ( uint32_T ) k_prot ) + 1U ; mt_prot [ k_prot + 1 ] = u_idx_0_prot ; } mt_prot [ 624 ] = 624U ; } } else { exitg1 = 1 ; } } while ( exitg1 == 0 ) ; r_prot = ( ( real_T ) u_idx_0_prot * 6.7108864E+7 + ( real_T ) u_idx_1_prot ) * 1.1102230246251565E-16 ; return r_prot ; }
