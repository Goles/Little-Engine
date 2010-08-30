//
//  ESRenderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright GandoGames 2009. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

@protocol ESRenderer <NSObject>

- (void) update:(float) delta;
- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end