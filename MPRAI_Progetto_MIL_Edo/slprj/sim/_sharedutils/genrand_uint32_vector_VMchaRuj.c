#include "rtwtypes.h"
#include "genrand_uint32_vector_VMchaRuj.h"
void genrand_uint32_vector_VMchaRuj ( uint32_T mt_prot [ 625 ] , uint32_T
u_prot [ 2 ] ) { int32_T j_prot ; int32_T kk_prot ; uint32_T mti_prot ;
uint32_T y_prot ; for ( j_prot = 0 ; j_prot < 2 ; j_prot ++ ) { mti_prot =
mt_prot [ 624 ] + 1U ; if ( mt_prot [ 624 ] + 1U >= 625U ) { for ( kk_prot =
0 ; kk_prot < 227 ; kk_prot ++ ) { mti_prot = ( mt_prot [ kk_prot + 1 ] &
2147483647U ) | ( mt_prot [ kk_prot ] & 2147483648U ) ; if ( ( mti_prot & 1U
) == 0U ) { mti_prot >>= 1U ; } else { mti_prot = mti_prot >> 1U ^
2567483615U ; } mt_prot [ kk_prot ] = mt_prot [ kk_prot + 397 ] ^ mti_prot ;
} for ( kk_prot = 0 ; kk_prot < 396 ; kk_prot ++ ) { mti_prot = ( mt_prot [
kk_prot + 227 ] & 2147483648U ) | ( mt_prot [ kk_prot + 228 ] & 2147483647U )
; if ( ( mti_prot & 1U ) == 0U ) { mti_prot >>= 1U ; } else { mti_prot =
mti_prot >> 1U ^ 2567483615U ; } mt_prot [ kk_prot + 227 ] = mt_prot [
kk_prot ] ^ mti_prot ; } mti_prot = ( mt_prot [ 623 ] & 2147483648U ) | ( mt_prot [ 0 ] & 2147483647U ) ; if ( ( mti_prot & 1U ) == 0U ) { mti_prot >>= 1U ; } else { mti_prot = mti_prot >> 1U ^ 2567483615U ; } mt_prot [ 623 ] = mt_prot [ 396 ] ^ mti_prot ; mti_prot = 1U ; } y_prot = mt_prot [ ( int32_T ) mti_prot - 1 ] ; mt_prot [ 624 ] = mti_prot ; y_prot ^= y_prot >> 11U ; y_prot ^= y_prot << 7U & 2636928640U ; y_prot ^= y_prot << 15U & 4022730752U ; u_prot [ j_prot ] = y_prot >> 18U ^ y_prot ; } }
