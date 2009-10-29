//
//  SingletonParticleSystemManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticleSystemManagerFunctions.h"

/* This class contains a Singleton instance of a Global Particle System manager
 * the idea is to make this class to manage all the game particle systems. (allocs, releases, etc)
 * the manager should give a reference to each particle system in order to deallocate them/deactivate them in the future.
 *
 * For some specific inline functions, one should look at "ParticleSystemManagerFunctions.h".
 *
 * _NG October 11 - 2009
 */

@class ParticleSystem;

@interface SingletonParticleSystemManager : NSObject 
{
	/*This is going to be the List containing all the Particle Systems declared here for performance reasons only.*/
	SystemEntity *_systemsList;
}

- (SystemEntity *) createParticleFX:(int) inParticleFX 
					atStartPosition:(CGPoint) inPosition;
- (SystemEntity *) insertEntity:(ParticleSystem *)inSystem;
- (BOOL) deleteEntity:(int) inPosition;
- (BOOL) removeEntityAtPosition:(int)inPosition;
- (void) printListDebug;
- (void) drawSystems;

+ (SingletonParticleSystemManager *) sharedParticleSystemManager;

/*Declared as static inline due to overhead of Obj-C messaging, this draws the particles system*/


@end
