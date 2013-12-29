//
//  RECGMath.h
//  RECoreGraphics
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.09.17.
//  Copyright (c) 2012 Roman Oliichuk. All rights reserved.
//

/*
 Copyright (C) 2012 Roman Oliichuk. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors
 may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// Importing the system headers.
#import <CoreGraphics/CGBase.h>

// Importing the system headers.
#import <math.h>

/******************************************************************************
 *                                                                            *
 *                              Inquiry macros                                *
 *                                                                            *
 *  fpclassify      Returns one of the FP_* values.                           *
 *  isnormal        Non-zero if and only if the argument x is normalized.     *
 *  isfinite        Non-zero if and only if the argument x is finite.         *
 *  isnan           Non-zero if and only if the argument x is a NaN.          *
 *  signbit         Non-zero if and only if the sign of the argument x is     *
 *                  negative.  This includes, NaNs, infinities and zeros.     *
 *                                                                            *
 ******************************************************************************/

#define cg_isnormal(x) isnormal(x)
#define cg_isfinite(x) isfinite(x)
#define cg_isinf(x) isinf(x)
#define cg_isnan(x) isnan(x)
#define cg_signbit(x) signbit(x)

/******************************************************************************
 *                                                                            *
 *                              Math Functions                                *
 *                                                                            *
 ******************************************************************************/

#if CGFLOAT_IS_DOUBLE

#define cg_acos(a) acos(a)
#define cg_asin(a) asin(a)
#define cg_atan(a) atan(a)
#define cg_atan2(a) atan2(a)
#define cg_cos(a) cos(a)
#define cg_sin(a) sin(a)
#define cg_tan(a) tan(a)
#define cg_acosh(a) acosh(a)
#define cg_asinh(a) asinh(a)
#define cg_atanh(a) atanh(a)
#define cg_cosh(a) cosh(a)
#define cg_sinh(a) sinh(a)
#define cg_tanh(a) tanh(a)
#define cg_exp(a) exp(a)
#define cg_exp2(a) exp2(a)
#define cg_expm1(a) expm1(a)
#define cg_log(a) log(a)
#define cg_log10(a) log10(a)
#define cg_log2(a) log2(a)
#define cg_log1p(a) log1p(a)
#define cg_logb(a) logb(a)
#define cg_modf(a, b) modf(a, b)
#define cg_ldexp(a, b) ldexp(a, b)
#define cg_frexp(a, b) frexp(a, b)
#define cg_ilogb(a) ilogb(a)
#define cg_scalbn(a, b) scalbn(a, b)
#define cg_scalbln(a, b) scalbln(a, b)
#define cg_fabs(a) fabs(a)
#define cg_cbrt(a) cbrt(a)
#define cg_hypot(a) hypot(a)
#define cg_powf(a, b) powf(a, b)
#define cg_sqrt(a) sqrt(a)
#define cg_erf(a) erf(a)
#define cg_erfc(a) erfc(a)
/*	lgammaf, lgamma, and lgammal are not thread-safe. The thread-safe
 variants lgammaf_r, lgamma_r, and lgammal_r are made available if
 you define the _REENTRANT symbol before including <math.h>                */
#define cg_lgamma(a) lgamma(a)
#define cg_tgamma(a) tgamma(a)
#define cg_ceil(a) ceil(a)
#define cg_floor(a) floor(a)
#define cg_nearbyint(a) nearbyint(a)
#define cg_rint(a) rint(a)
#define cg_lrint(a) lrint(a)
#define cg_round(a) round(a)
#define cg_lround(a) lround(a)

/*  long long is not part of C90. Make sure you are passing -std=c99 or
 -std=gnu99 or higher if you need these functions returning long longs     */
#if !(__DARWIN_NO_LONG_LONG)
#define cg_llrint(a) llrint(a)
#define cg_llround(a) llround(a)
#endif /* !(__DARWIN_NO_LONG_LONG) */

#define cg_trunc(a) trunc(a)
#define cg_fmod(a, b) fmod(a, b)
#define cg_remainder(a, b) remainder(a, b)
#define cg_remquo(a, b, c) remquo(a, b, c)
#define cg_copysign(a, b) copysign(a, b)
#define cg_nan(a) nan(a)
#define cg_nextafter(a, b) nextafter(a, b)
#define cg_nexttoward(a, b) nexttoward(a, b)
#define cg_fdim(a, b) fdim(a, b)
#define cg_fmax(a, b) fmax(a, b)
#define cg_fmin(a, b) fmin(a, b)
#define cg_fma(a, b, c) fma(a, b, c)

#define cg_isgreater(x, y) isgreater(x, y)
#define cg_isgreaterequal(x, y) isgreaterequal(x, y)
#define cg_isless(x, y) isless(x, y)
#define cg_islessequal(x, y) islessequal(x, y)
#define cg_islessgreater(x, y) islessgreater(x, y)
#define cg_isunordered(x, y) isunordered(x, y)

#else

#define cg_acos(a) acosf(a)
#define cg_asin(a) asinf(a)
#define cg_atan(a) atanf(a)
#define cg_atan2(a) atan2f(a)
#define cg_cos(a) cosf(a)
#define cg_sin(a) sinf(a)
#define cg_tan(a) tanf(a)
#define cg_acosh(a) acoshf(a)
#define cg_asinh(a) asinhf(a)
#define cg_atanh(a) atanhf(a)
#define cg_cosh(a) coshf(a)
#define cg_sinh(a) sinhf(a)
#define cg_tanh(a) tanhf(a)
#define cg_exp(a) expf(a)
#define cg_exp2(a) exp2f(a)
#define cg_expm1(a) expm1f(a)
#define cg_log(a) logf(a)
#define cg_log10(a) log10f(a)
#define cg_log2(a) log2f(a)
#define cg_log1p(a) log1pf(a)
#define cg_logb(a) logbf(a)
#define cg_modf(a, b) modff(a, b)
#define cg_ldexp(a, b) ldexpf(a, b)
#define cg_frexp(a, b) frexpf(a, b)
#define cg_ilogb(a) ilogbf(a)
#define cg_scalbn(a, b) scalbnf(a, b)
#define cg_scalbln(a, b) scalblnf(a, b)
#define cg_fabs(a) fabsf(a)
#define cg_cbrt(a) cbrtf(a)
#define cg_hypot(a) hypotf(a)
#define cg_powf(a, b) powff(a, b)
#define cg_sqrt(a) sqrtf(a)
#define cg_erf(a) erff(a)
#define cg_erfc(a) erfcf(a)
/*	lgammaf, lgamma, and lgammal are not thread-safe. The thread-safe
 variants lgammaf_r, lgamma_r, and lgammal_r are made available if
 you define the _REENTRANT symbol before including <math.h>                */
#define cg_lgamma(a) lgammaf(a)
#define cg_tgamma(a) tgammaf(a)
#define cg_ceil(a) ceilf(a)
#define cg_floor(a) floorf(a)
#define cg_nearbyint(a) nearbyintf(a)
#define cg_rint(a) rintf(a)
#define cg_lrint(a) lrintf(a)
#define cg_round(a) roundf(a)
#define cg_lround(a) lroundf(a)

/*  long long is not part of C90. Make sure you are passing -std=c99 or
 -std=gnu99 or higher if you need these functions returning long longs     */
#if !(__DARWIN_NO_LONG_LONG)
#define cg_llrint(a) llrintf(a)
#define cg_llround(a) llroundf(a)
#endif /* !(__DARWIN_NO_LONG_LONG) */

#define cg_trunc(a) truncf(a)
#define cg_fmod(a, b) fmodf(a, b)
#define cg_remainder(a, b) remainderf(a, b)
#define cg_remquo(a, b, c) remquof(a, b, c)
#define cg_copysign(a, b) copysignf(a, b)
#define cg_nan(a) nanf(a)
#define cg_nextafter(a, b) nextafterf(a, b)
#define cg_nexttoward(a, b) nexttowardf(a, b)
#define cg_fdim(a, b) fdimf(a, b)
#define cg_fmax(a, b) fmaxf(a, b)
#define cg_fmin(a, b) fminf(a, b)
#define cg_fma(a, b, c) fmaf(a, b, c)

#define cg_isgreater(x, y) isgreaterf(x, y)
#define cg_isgreaterequal(x, y) isgreaterequalf(x, y)
#define cg_isless(x, y) islessf(x, y)
#define cg_islessequal(x, y) islessequalf(x, y)
#define cg_islessgreater(x, y) islessgreaterf(x, y)
#define cg_isunordered(x, y) isunorderedf(x, y)

#endif

/******************************************************************************
 *  Reentrant variants of lgamma[fl]                                          *
 ******************************************************************************/

#if CGFLOAT_IS_DOUBLE

#ifdef _REENTRANT
/*  Reentrant variants of the lgamma[fl] functions.                           */
#define cg_lgamma_r(a) lgamma_r(a)
#endif /* _REENTRANT */

#else

#ifdef _REENTRANT
/*  Reentrant variants of the lgamma[fl] functions.                           */
#define cg_lgamma_r(a) lgamma_r(a)
#endif /* _REENTRANT */

#endif
