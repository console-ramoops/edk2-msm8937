#ifndef __MIN_STDBOOL_H__
#define __MIN_STDBOOL_H__

#include <Library/BaseLib.h>

#if (!defined(__STDC_VERSION__) || __STDC_VERSION__ < 202311L) && !defined(__bool_true_false_are_defined) && !defined(__cplusplus)
#ifndef bool
typedef BOOLEAN bool;
#endif
#ifndef true
#define true TRUE
#endif
#ifndef false
#define false FALSE
#endif
#endif

#endif
