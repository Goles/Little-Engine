//
//  ParticleEmitter.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParticleEmitter : NSObject 
{
	id delegate;
	
	CGPoint emitionSource;
}

@property (nonatomic, retain) id delegate;
@property (readwrite) CGPoint emitionSource;

- (void) setEmitionSource:(CGPoint)source;

@end
