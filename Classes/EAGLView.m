//
//  EAGLView.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "EAGLView.h"

#import "ES1Renderer.h"
#import "ES2Renderer.h"
#import "ConstantsAndMacros.h"
#import "EmitterFunctions.h"
#import "ParticleSystem.h"
#import "ParticleEmitter.h"

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
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
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

- (void) drawView:(id)sender
{
    [renderer render];
}

- (void) layoutSubviews
{
	[renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
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

			displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView:)];
			[displayLink setFrameInterval:animationFrameInterval];
			[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		}
		else
			animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawView:) userInfo:nil repeats:TRUE];
		
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
	/*
	*/
	UITouch *touch1,
			*touch2;
	
	CGPoint loc1,
			loc2,
			locAux;
	
	
	NSSet *allTouches = [event allTouches];
	
	switch ([allTouches count]) 
	{
		case 1:
			touch1	= [touches anyObject];
			loc1	= [touch1 locationInView:self];
			loc1.y	= SCREEN_HEIGHT - loc1.y + 20;
			loc1.x	+= 20;
			[[[renderer aSystem] systemEmitter] setCurrentFX:kEmmiterFX_none withSource:loc1 andEnd:loc1];
			//NSLog(@"(loc1X:%f | loc1Y:%f)",loc1.x,loc1.y);
//			[[[renderer aSystem] systemEmitter] setEmitionSource:loc1];
			break;
		case 2:
			touch1	= [[allTouches allObjects] objectAtIndex:0];
			touch2	= [[allTouches allObjects] objectAtIndex:1];
			loc1	= [touch1 locationInView:self];
			loc2	= [touch2 locationInView:self];
			
			loc1.y	= SCREEN_HEIGHT - loc1.y;
			loc2.y	= SCREEN_HEIGHT - loc2.y;
			
			if(loc1.y > loc2.y)
			{
				locAux	= loc2;
				loc2	= loc1;
				loc1	= locAux;
			}
			
			NSLog(@"(loc1X:%f | loc1Y:%f)",loc1.x,loc1.y);
			NSLog(@"(loc2X:%f | loc2Y:%f)",loc2.x, loc2.y);
			NSLog(@"-----");
			
			[[[renderer aSystem] systemEmitter] setCurrentFX:kEmmiterFX_linear withSource:loc1 andEnd:loc2];
			break;
		default:
			break;
	}
	
	
	//[[[renderer aSystem] systemEmitter] setEmitionSource:loc];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch * touch = [touches anyObject];
	CGPoint loc = [touch locationInView:self];
	loc.y = SCREEN_HEIGHT - loc.y + 20;
	loc.x += 20;
	
	[[[renderer aSystem] systemEmitter] setCurrentFX:kEmmiterFX_none withSource:loc andEnd:loc];
}

@end
