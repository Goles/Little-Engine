/*
 *  ParticleSystems.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 11/5/09.
 *  Copyright 2009 Gando-Games All rights reserved.
 *
 *	This Class will be the Main "ParticleSystem" Class, it's a "GameEntity" inherited class, 
 *	so it has the "draw()" and "update()" virtual methods inherited. This is all to be able to manage
 *	all our "GameElements" in a more easier way.
 *
 *	_NG
 */

#import <Foundation/Foundation.h>
#import "GameEntity.h"
#import "Particle.h"
#import "ParticleEmitter.h"
#import "ParticleController.h"
#import "ParticleRenderer.h"

class ParticleSystem: public GameEntity
{
public:
	//Constructor
	ParticleSystem(int number, BOOL isContinuous, int kRenderingMode);
	
	//Destructor
	~ParticleSystem();
	
	//Getters
	unsigned int 		getParticleNumber();
	Particle			**getParticlesArray();
	ParticleEmitter		*getParticleEmitter();
	ParticleController	*getParticleController();
	ParticleRenderer	*getParticleRenderer();
	
	//Setters
	void	setIsActive(bool isActive);	
	void	setX(float X);
	void	setY(float Y);
	float	getX();
	float	getY();
	
	//Inherited overloaded
	void draw();
	void update();
	
private:
	unsigned int		particleNumber;		//Total number of particles in the system
	Particle			**array;
	ParticleEmitter		*systemEmitter;
	ParticleController	*systemController;
	ParticleRenderer	*systemRenderer;
};