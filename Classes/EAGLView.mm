//
//  EAGLView.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "EAGLView.h"
#import "ES1Renderer.h"
#import "SharedInputManager.h"


@implementation EAGLView

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this method
+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id) initWithCoder:(NSCoder*)coder
{    
    if ((self = [super initWithCoder:coder]))
	{
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat, nil];
		
		//renderer = [[ES2Renderer alloc] init];
		
		if (!renderer)
		{
			renderer = [[ES1Renderer alloc] init];
			
			if (!renderer)
			{
				[self release];
				return nil;
			}
		}
        [self setMultipleTouchEnabled:YES];
		animating = FALSE;
		displayLinkSupported = FALSE;
		animationFrameInterval = 1;
		displayLink = nil;
		animationTimer = nil;
		
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
	float				delta;
	
	time	= CFAbsoluteTimeGetCurrent();
	delta	= (time - lastTime);
	
	/* update */
	[(ES1Renderer *)renderer update:delta];

	
	/* render */
	[renderer render];
	
	lastTime = time;
}

- (void) layoutSubviews
{
	[renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
//    [self drawView:nil];
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
		if (displayLinkSupported)
		{
			// CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
			// if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
			// not be called in system versions earlier than 3.1.

			displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(mainGameLoop:)];
			[displayLink setFrameInterval:animationFrameInterval];
			[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		}
		else
			animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(mainGameLoop:) userInfo:nil repeats:TRUE];
		
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
			displayLink = nil;
		}
		else
		{
			[animationTimer invalidate];
			animationTimer = nil;
		}
		
		animating = FALSE;
	}
}

#pragma mark touches

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{	
	UITouch *touch1,
			*touch2;
	
	CGPoint loc1,
			loc2;

	NSSet *allTouches = [event allTouches];
	
	switch ([allTouches count]) {
		case 1:
			touch1 = [touches anyObject];
			loc1   = [touch1 locationInView:self];
			INPUT_MANAGER->touchesBegan(loc1.x, loc1.y);
			break;
		case 2:
			touch1	= [[allTouches allObjects] objectAtIndex:0];
			touch2	= [[allTouches allObjects] objectAtIndex:1];
			
			//Get the touches ID's
			touch1ID = &touch1;
			touch2ID = &touch2;
			
			NSLog(@"ID1: %p\n ID2: %p\n",touch1ID, touch2ID);
			
			loc1	= [touch1 locationInView:self];
			loc2	= [touch2 locationInView:self];
			
			INPUT_MANAGER->touchesBegan(loc1.x, loc1.y);
			INPUT_MANAGER->touchesBegan(loc2.x, loc2.y);
		default:
			break;
	}

}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch1,
			*touch2;

	CGPoint loc1,
			loc2;
	
	NSSet *allTouches = [event allTouches];
	
	switch ([allTouches count]) {
		case 1:
			touch1 = [touches anyObject];
			loc1   = [touch1 locationInView:self];
			INPUT_MANAGER->touchesMoved(loc1.x, loc1.y);
			break;
			
		case 2:
			touch1	= [[allTouches allObjects] objectAtIndex:0];
			touch2	= [[allTouches allObjects] objectAtIndex:1];
			loc1	= [touch1 locationInView:self];
			loc2	= [touch2 locationInView:self];
			
			INPUT_MANAGER->touchesBegan(loc1.x, loc1.y);
			INPUT_MANAGER->touchesBegan(loc2.x, loc2.y);
			
		default:
			break;
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch1,
			*touch2;
	
	CGPoint loc1,
			loc2;
	
	NSSet *allTouches = [event allTouches];
	
	switch ([allTouches count]) {
		case 1:
			touch1 = [touches anyObject];
			loc1   = [touch1 locationInView:self];
			INPUT_MANAGER->touchesEnded(loc1.x, loc1.y);
			break;
			
		case 2:
			touch1	= [[allTouches allObjects] objectAtIndex:0];
			touch2	= [[allTouches allObjects] objectAtIndex:1];
			loc1	= [touch1 locationInView:self];
			loc2	= [touch2 locationInView:self];
			
			INPUT_MANAGER->touchesBegan(loc1.x, loc1.y);
			INPUT_MANAGER->touchesBegan(loc2.x, loc2.y);
			
		default:
			break;
	}
}

@end
