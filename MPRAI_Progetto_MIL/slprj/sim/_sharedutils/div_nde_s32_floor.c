#include "div_nde_s32_floor.h"
#include "rtwtypes.h"
int32_T div_nde_s32_floor ( int32_T numerator_prot , int32_T denominator_prot
) { return ( ( ( numerator_prot < 0 ) != ( denominator_prot < 0 ) ) && ( numerator_prot % denominator_prot != 0 ) ? - 1 : 0 ) + numerator_prot / denominator_prot ; }
