#include "rtwtypes.h"
#include "xzlascl_4fCVFuyQ.h"
#include "mwmathutil.h"
#include <emmintrin.h>
void xzlascl_4fCVFuyQ ( real_T cfrom_prot , real_T cto_prot , int32_T m_prot
, real_T A_prot [ 2 ] , int32_T iA0_prot ) { __m128d tmp_prot ; real_T
cfrom1_prot ; real_T cfromc_prot ; real_T cto1_prot ; real_T ctoc_prot ;
real_T mul_prot ; int32_T b_i_prot ; int32_T scalarLB_prot ; int32_T
tmp_p_prot ; int32_T vectorUB_prot ; boolean_T notdone_prot ; cfromc_prot =
cfrom_prot ; ctoc_prot = cto_prot ; notdone_prot = true ; while ( notdone_prot
) { cfrom1_prot = cfromc_prot * 2.0041683600089728E-292 ; cto1_prot =
ctoc_prot / 4.9896007738368E+291 ; if ( ( muDoubleScalarAbs ( cfrom1_prot ) >
muDoubleScalarAbs ( ctoc_prot ) ) && ( ctoc_prot != 0.0 ) ) { mul_prot =
2.0041683600089728E-292 ; cfromc_prot = cfrom1_prot ; } else if ( muDoubleScalarAbs ( cto1_prot ) > muDoubleScalarAbs ( cfromc_prot ) ) { mul_prot = 4.9896007738368E+291 ; ctoc_prot = cto1_prot ; } else { mul_prot = ctoc_prot / cfromc_prot ; notdone_prot = false ; } scalarLB_prot = ( m_prot / 2 ) << 1 ; vectorUB_prot = scalarLB_prot - 2 ; for ( b_i_prot = 0 ; b_i_prot <= vectorUB_prot ; b_i_prot += 2 ) { tmp_p_prot = ( b_i_prot + iA0_prot ) - 1 ; tmp_prot = _mm_loadu_pd ( & A_prot [ tmp_p_prot ] ) ; _mm_storeu_pd ( & A_prot [ tmp_p_prot ] , _mm_mul_pd ( tmp_prot , _mm_set1_pd ( mul_prot ) ) ) ; } for ( b_i_prot = scalarLB_prot ; b_i_prot < m_prot ; b_i_prot ++ ) { tmp_p_prot = ( b_i_prot + iA0_prot ) - 1 ; A_prot [ tmp_p_prot ] *= mul_prot ; } } }
