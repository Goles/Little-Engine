//
// ChainReactionconstants.h
//  ChainReaction
//
//  Created by Mr.Gando on 6/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

// How many times a second to refresh the screen
#define kRenderingFrequency 60.0

// For setting up perspective, define near, far, and angle of view
#define kZNear			0.01
#define kZFar			1000.0
#define kFieldOfView	45.0

// Macros
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

/// returns a random float between 0 and 1
#define CCRANDOM_0_1() ((random() / (float)0x7fffffff ))

//Game Screen size

#define SCREEN_HEIGHT 480.0
#define SCREEN_WIDTH  320.0

