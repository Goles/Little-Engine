/*
 * Constants and Macros
 */
 
#ifndef _CONSTANT_MACROS_H_
#define _CONSTANT_MACROS_H_

#include <math.h>

//Matrix Multiplication for 4x4 Matrixes.
//typedef float mat4f_t[16];
static void matmul4_c(float m0[16], float m1[16], float d[16])
{
	d[0]  = m0[0]*m1[0] + m0[4]*m1[1] + m0[8]*m1[2] + m0[12]*m1[3];
	d[1]  = m0[1]*m1[0] + m0[5]*m1[1] + m0[9]*m1[2] + m0[13]*m1[3];
	d[2]  = m0[2]*m1[0] + m0[6]*m1[1] + m0[10]*m1[2] + m0[14]*m1[3];
	d[3]  = m0[3]*m1[0] + m0[7]*m1[1] + m0[11]*m1[2] + m0[15]*m1[3];
	d[4]  = m0[0]*m1[4] + m0[4]*m1[5] + m0[8]*m1[6] + m0[12]*m1[7];
	d[5]  = m0[1]*m1[4] + m0[5]*m1[5] + m0[9]*m1[6] + m0[13]*m1[7];
	d[6]  = m0[2]*m1[4] + m0[6]*m1[5] + m0[10]*m1[6] + m0[14]*m1[7];
	d[7]  = m0[3]*m1[4] + m0[7]*m1[5] + m0[11]*m1[6] + m0[15]*m1[7];
	d[8]  = m0[0]*m1[8] + m0[4]*m1[9] + m0[8]*m1[10] + m0[12]*m1[11];
	d[9]  = m0[1]*m1[8] + m0[5]*m1[9] + m0[9]*m1[10] + m0[13]*m1[11];
	d[10] = m0[2]*m1[8] + m0[6]*m1[9] + m0[10]*m1[10] + m0[14]*m1[11];
	d[11] = m0[3]*m1[8] + m0[7]*m1[9] + m0[11]*m1[10] + m0[15]*m1[11];
	d[12] = m0[0]*m1[12] + m0[4]*m1[13] + m0[8]*m1[14] + m0[12]*m1[15];
	d[13] = m0[1]*m1[12] + m0[5]*m1[13] + m0[9]*m1[14] + m0[13]*m1[15];
	d[14] = m0[2]*m1[12] + m0[6]*m1[13] + m0[10]*m1[14] + m0[14]*m1[15];
	d[15] = m0[3]*m1[12] + m0[7]*m1[13] + m0[11]*m1[14] + m0[15]*m1[15];
}

// Fast calculation for InvSqrt 1/sqrt(x)
static float InvSqrt (float x)
{
	float xhalf = 0.5f * x;
	int i = * (int *) &x;
	i = 0x5f3759df - (i >> 1); 
	x = * (float *) &i;
	x = x * (1.5f - xhalf * x * x);
	return x;
}

//Screen definitions
#define SCREEN_HEIGHT 480
#define SCREEN_WIDTH  320

//definitions
#define GGPoint CGPoint

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