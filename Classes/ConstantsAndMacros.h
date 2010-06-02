/*
 * Constants and Macros
 */
 
#ifndef _CONSTANT_MACROS_H_
#define _CONSTANT_MACROS_H_

#include <math.h>

//Screen definitions
#define SCREEN_HEIGHT 480
#define SCREEN_WIDTH  320

//simple macro that swaps 2 variables
#define CC_SWAP( x, y )			\
({ __typeof__(x) temp  = (x);		\
		x = y; y = temp;		\
})

/// returns a random float between -1 and 1
#define CCRANDOM_MINUS1_1() ((random() / (float)0x3fffffff )-1.0f)

/// returns a random float between 0 and 1
#define CCRANDOM_0_1() ((random() / (float)0x7fffffff ))

/// converts degrees to radians
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0f * (float)M_PI)

/// converts radians to degrees
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) / (float)M_PI * 180.0f)

///Macro that allows you to "clamp a value within the defined bounds
#define	 CLAMP(X, A, B) ((X < A) ? A : ((X > B) ? B : X))

/// default gl blend src function
//#define CC_BLEND_SRC GL_SRC_ALPHA
#define CC_BLEND_SRC GL_ONE
/// default gl blend dst function
#define CC_BLEND_DST GL_ONE_MINUS_SRC_ALPHA

#endif