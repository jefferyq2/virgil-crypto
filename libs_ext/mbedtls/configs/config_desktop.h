#ifndef VIRGIL_MBEDTLS_CONFIG_DESKTOP_H
#define VIRGIL_MBEDTLS_CONFIG_DESKTOP_H

#define MBEDTLS_PLATFORM_C
#define MBEDTLS_HAVE_ASM
#define MBEDTLS_PADLOCK_C
#define MBEDTLS_HAVE_TIME
#define MBEDTLS_HAVE_TIME_DATE
#define MBEDTLS_AESNI_C
#define MBEDTLS_TIMING_C
#define MBEDTLS_HAVEGE_C
#cmakedefine MBEDTLS_ENTROPY_NV_SEED
#cmakedefine MBEDTLS_PLATFORM_NV_SEED_ALT

#endif // VIRGIL_MBEDTLS_CONFIG_DESKTOP_H
