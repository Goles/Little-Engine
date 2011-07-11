//
//  EAGLView.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright Nicolas Goles 2009. All rights reserved.
//

#import "EAGLView.h"
#import "ES1Renderer.h"
#import "TouchableManager.h"
#import "GandoBox2D.h"
#include "ActionManager.h"

@implementation EAGLView

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this method
+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id) initWithFrame:(CGRect) bounds
{    
    if ((self = [super initWithFrame:bounds]))
	{
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:false], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat, NULL];

		if (!renderer)
		{
			renderer = [[ES1Renderer alloc] init];
			
			if (!renderer)
			{
				[self release];
				return NULL;
			}
		}
		
        [self setMultipleTouchEnabled:YES];
		animating = FALSE;
		displayLinkSupported = FALSE;
		animationFrameInterval = 1;
		displayLink = NULL;
        
		// A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
		// class is used as fallback when it isn't available.
		NSString *reqSysVer = @"3.1";
		NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
		if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
			displayLinkSupported = TRUE;
    }
    return self;
}

- (void) mainGameLoop:(id)sender
{
	CFTimeInterval		time;
	static float		delta = 0;
	
	time	= CFAbsoluteTimeGetCurrent();
	delta	= (time - lastTime);
	
    /* Update & Clean ActionManager */
    ACTION_MANAGER->update(delta);
    ACTION_MANAGER->cleanup();
    
	/* Update Renderer */
	[renderer update:delta];

    /* Update Box2d World */
    GBOX_2D->update(delta);
    
	/* render */
	[renderer render];
    
	lastTime = time;
}

- (void) layoutSubviews
{
	[renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
}

- (NSInteger) animationFrameInterval
{
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startAnimation
{
	if (!animating)
	{
		lastTime = CFAbsoluteTimeGetCurrent();
		if (displayLinkSupported)
		{
			// CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
			// if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
			// not be called in system versions earlier than 3.1.

			displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(mainGameLoop:)];
			[displayLink setFrameInterval:animationFrameInterval];
			[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		}
		animating = TRUE;
	}
}

- (void)stopAnimation
{
	if (animating)
	{
		if (displayLinkSupported)
		{
			[displayLink invalidate];
			displayLink = NULL;
		}
		animating = FALSE;
	}
}

#pragma mark -
#pragma mark touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint loc;
	
	for ( UITouch* aTouch in touches )
	{
		loc = [aTouch locationInView:self];
		TOUCHABLE_MANAGER->touchesBegan(loc.x, loc.y, (int)aTouch);		
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  
	CGPoint loc;
	
	for ( UITouch* aTouch in touches )
	{
		loc = [aTouch locationInView:self];
		TOUCHABLE_MANAGER->touchesMoved(loc.x, loc.y, (int)aTouch);		
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint loc;
	
	for ( UITouch* aTouch in touches )
	{
		loc = [aTouch locationInView:self];
		TOUCHABLE_MANAGER->touchesEnded(loc.x, loc.y, (int)aTouch);		
	}
}

@end
