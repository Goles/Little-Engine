/*
 *  ParticleSystems.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 11/5/09.
 *  Copyright 2009 Gando-Games All rights reserved.
 *
 *	This Class will be the Main "ParticleSystem" Class, it's a "GameElement" inherited class, 
 *	so it has the "draw()" and "update()" virtual methods inherited. This is all to be able to manage
 *	all our "GameElements" in a more easier way.
 *
 *	_NG
 */

#import <Foundation/Foundation.h>
#import "GameElement.h"
#import "Particle.h"
#import "ParticleEmitter.h"
#import "ParticleController.h"
#import "ParticleRenderer.h"

class ParticleSystem: public GameElement
{
public:
	//Constructor
	ParticleSystem(int number, BOOL isContinuous, int kRenderingMode);
	
	//Destructor
	~ParticleSystem();
	
	//Getters
	unsigned int 		getParticleNumber();
	BOOL				getIsActive();
	Particle			**getParticlesArray();
	ParticleEmitter		*getParticleEmitter();
	ParticleController	*getParticleController();
	ParticleRenderer	*getParticleRenderer();
	
	//Setters
	void				setIsActive(BOOL inIsActive);
	
	//Inherited overloaded
	void draw();
	void update();

	
private:
	unsigned int		particleNumber;		//Total number of particles in the system
	BOOL				textureBound;
	BOOL				isActive;
	
	Particle			**array;
	ParticleEmitter		*systemEmitter;
	ParticleController	*systemController;
	ParticleRenderer	*systemRenderer;
};