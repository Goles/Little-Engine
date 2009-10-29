//
//  ParticleContainer.h
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

#import <Foundation/Foundation.h>

@class Particle;
@class Texture2D;

@interface ParticleController : NSObject 
{
	id			delegate;	//this delegate should be the particle system.
	Particle	**array;	//should hold reference only.
}

@property (nonatomic, retain) id delegate;

- (id) initWithDelegate:(id)inDelegate;

@end
