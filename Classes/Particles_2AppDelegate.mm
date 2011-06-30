//
//  Particles_2AppDelegate.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright Nicolas Goles 2009. All rights reserved.
//

#import "Particles_2AppDelegate.h"
#import "EAGLView.h"
#include "AngelCodeFont.h"
#include "FileUtils.h"

@implementation Particles_2AppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
	[glView startAnimation];
    AngelCodeFont *fnt = new AngelCodeFont();
    fnt->openFont(gg::utils::fullCPathFromRelativePath("font1.fnt"), 0);
}

- (void) applicationWillResignActive:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
	[glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) dealloc
{
	[window release];
	[glView release];	
	[super dealloc];
}

@end
