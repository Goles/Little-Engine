//
//  GameElement.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

/*
 *	This is the GameEntity Abstract Class, should be used to create new kinds of GameEntities
 *	If a game element is declared a "GameEntity", the engine will asume it implements all the "GameEntity"
 *	methods in a correct/suitable way.	
 *	_NG
 */

#ifndef _GAMEENTITY_H_
#define _GAMEENTITY_H_

#include <iostream>
#include <map>
#include <vector>

class GEComponent;

class GameEntity
{
public:
	float	x,
			y,
			height,	//Limits (height and width) of our Entity.
			width;
	float speed;
	bool	isActive;
	
	//Constructors
	GameEntity();
	GameEntity(float x, float y);
	GameEntity(float inX, float inY, int inWidth, int inHeight);
	virtual ~GameEntity(){ components.clear(); }
	
	//Virtual Methods.
	virtual void update(float delta);
	
	//Getters & Setters
	const bool		getIsActive() const { return isActive; }
	const void		setIsActive(bool inActive) { isActive = inActive; }
	const float		getSpeed() const { return speed; }
	const void		setSpeed(float s) { speed = s; }
	void				setGEC( GEComponent *newGEC );
	GEComponent*	getGEC( const std::string &familyID );
	void				clearGECs();
	
	//Functors	
public:
	/*Functor to compare by X*/
	friend class compareByX;
    class compareByX 
	{
	public:
	bool operator()(GameEntity const *a, GameEntity const *b) { 
            return (a->x < b->x);
        }
    };
	
	/*Functor to compare by Y*/
	friend class compareByY;
    class compareByY 
	{
	public:
        bool operator()(GameEntity const *a, GameEntity const *b) 
		{ 
            return ((a->y + (a->height/2)) > (b->y + (b->height/2)) );
        }
    };

	//Debug Interface
public:
	void debugPrintComponents();
	
private:	
	typedef std::map<const std::string, GEComponent *>		ComponentMap;
	typedef std::pair<const std::string, GEComponent *>	ComponentMapPair;
	typedef std::vector<GEComponent *>							ComponentVector;	
	
	ComponentMap			components;
	ComponentVector		rendereableComponents;
};

#endif