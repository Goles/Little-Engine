//
//  EAGLView.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright GandoGames 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ESRenderer.h"

/** Wrapper class, sets the context in which an OpenGL scene will be rendered.
@remarks
    Setting the view non-opaque will only work if the EAGL surface has an alpha channel.
*/

@interface EAGLView : UIView
{    
@private
	id <ESRenderer> renderer;
	
	BOOL animating;
	BOOL displayLinkSupported;
	BOOL viewSetup;
	NSInteger animationFrameInterval;
	// Use of the CADisplayLink class is the preferred method for controlling your animation timing.
	// CADisplayLink will link to the main display and fire every vsync when added to a given run-loop.
	// The NSTimer class is used only as fallback when running on a pre 3.1 device where CADisplayLink
	// isn't available.
	id displayLink;
    NSTimer *animationTimer;
	
	/*Other Stuff*/
	CFTimeInterval lastTime;
	
	void *touch1ID;
	void *touch2ID;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

/**Animation state toggles*/
- (void) startAnimation;
- (void) stopAnimation;

@end
