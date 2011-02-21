/*
 *  GandoBox2D.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/4/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _GANDO_BOX_2D_H_
#define _GANDO_BOX_2D_H_

/** Definition to abreviate the getInstance() call.
 @remarks
	- eg: You just need to say GBOX_2D->update()
 */
#define GBOX_2D GandoBox2D::getInstance()

/** Definition to abreviate the getWorld() call. (This will be deprecated.)
 @remarks:
	- eg: You just need to say GBOX_2D_WORLD.
 */
#define GBOX_2D_WORLD GandoBox2D::getInstance()->getWorld()

/** Pixel to metres ratio.
 @remarks 
	Box2D uses metres as the unit for measurement.
	This ratio defines how many pixels correspond to 1 Box2D "metre"
	Box2D is optimized for objects of 1x1 metre therefore it makes sense
	to define the ratio so that your most common object type is 1x1 metre.
 */
#define PTM_RATIO 32

#include <vector>

#include "Box2D.h"
#include "GandoBox2DDebug.h"
#include "GContactListener.h"

#include "GEComponent.h"

class GLESDebugDraw; /** < Forward declaration for GLESDebugDraw */

/** Singleton Class to Integrate Box2D to the GGEngine
 @remarks
	The main purpose of this class is to synchronize the Box2D world with the 
	GGEngine world. The class is a singleton.
 */
class GandoBox2D
{
public:
	~GandoBox2D();
	
	/** Method to return the singleton instance.
	 @remarks
		When this is called and the singleton instance has not been created, the
		protected constructor will be called  to instanciate the singleton instance.
	 @returns GandoBox2D reference.
	 */
	static GandoBox2D*	getInstance();
//------------------------------------------------------------------------------	
	/** Updates the Box2D world.
	 @remarks
		This method is responsible for synchronizing all the entities that *should*
		be sync to the Box2D world. Usually this can be either when you want to
		use Box2D physics or even when you just want to use the collision detection
		algorithms of Box2D.
	 @param delta is the interval of time since the last update was called, usually 1/60 (60 fps)	 
	 */
	void				update(const float delta);
	
	/** Returns the constant b2World (box2d world) for you to access some of it's elements
		in a more direct way. 
	 */
	b2World*			getWorld() const;
//------------------------------------------------------------------------------	
	/** Init's a default Box2D world. */
	void				initBaseWorld();
	
	/** Inits a custom Box2D world.
	 @remarks
		You can only allow sleeping entities if you are fully embracing Box2D world
		with physics, moving entities trough vectors, etc. You can't allow sleeping
		entities if you are only using the Collision detection facilities of Box2D.
	 @param gravity represents the gravity for the world.
	 @param doSleep represents if this world will allow "sleeping" entities to reduce overhead.
	 */
	void				initWorld(const b2Vec2 &gravity, bool doSleep);
//------------------------------------------------------------------------------
public:	
	/** Toggles Box2D Debug Draw 
	 @remarks
		This will enable boxes to be drawn over box2d bodies and 
		color them to represent collisions.
	 */
	void				initDebugDraw();
	
	/** Draws Box2D debug boxes
	 @remarks
		OpenGL ES 1.1 implementation
	 */
	void				debugRender();
	
	/** Adds a debug sprite to the Box2D world. */
	void				addDebugSpriteWithCoords(float x, float y);
	
	/** Updates the state of the Debug Box2D bodies and entities */
	void				debugUpdate(float delta); 

//------------------------------------------------------------------------------
protected:
	/** Protected constructor to respect the singleton pattern. */
	GandoBox2D();
	
	void notifyCollisionEntity(const GameEntity * const in_entity);
//------------------------------------------------------------------------------	
private:
	b2World*			world; /** < Instance of the Box2D world*/
	GContactListener*	contactListener; /** < Listens for collision between in-world Box2D bodies*/
	
	static GandoBox2D*	instance; /** < Singleton Instance of GandoBox2D*/
	GLESDebugDraw*		debugDraw; /** < Instance of the Box2D debug draw*/
	
	std::vector<Gbox *> boxes; /** < Vector of boxes used for debug */
};

#endif