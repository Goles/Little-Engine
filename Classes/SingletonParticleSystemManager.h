//
//  SingletonParticleSystemManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ParticleSystem;
@class SystemEntity;

/*This is to make a Particle System list that the manager will hande and reduce the overhead*/
typedef struct _entity
{
	ParticleSystem	*system;
	struct _entity	*nextSystem;
} SystemEntity;

@interface SingletonParticleSystemManager : NSObject 
{
	SystemEntity *_systemsArray;
}

- (BOOL) insertEntity:(ParticleSystem *)inSystem;
- (BOOL) deleteEntity:(int) inPosition;
- (BOOL) removeEntityAtPosition:(int)inPosition;
- (void) printListDebug;
   
//+ (SingletonParticleSystemManager *) sharedParticleSystemManager;

@end
