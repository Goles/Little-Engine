//
//  GameElement.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

/*
 *	This is the GameEntity Abstract Class, should be used to create new kinds of GameEntities
 *	If a game element is declared a "GameEntity", the engine will asume it implements all the "GameEntity"
 *	methods in a correct/suitable way.
 *	
 *	_NG
 */

#include <iostream>
#include <map>
#include <vector>

class GEComponent;

class GameEntity
{
public:
	float x,y;
	Boolean	isActive;
	
	//Virtual Methods.
	GameEntity(){}
	virtual void draw(){}
	virtual void update(float delta);
	virtual ~GameEntity(){}
	
	//Getters & Setters
	const Boolean getIsActive() const { return isActive; }
	const void setIsActive(Boolean inActive) { isActive = inActive; }
	
	GEComponent *getGEC( const std::string &familyID );
	void setGEC( GEComponent *newGEC );
	void clearGECs();
	
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
            return (a->y < b->y);
        }
    };

	//Debug Interface
public:
	void debugPrintComponents();
	
private:	
	typedef std::map<const std::string, GEComponent *> ComponentMap;
	typedef std::pair<const std::string, GEComponent *> ComponentMapPair;
	typedef std::vector<GEComponent *> ComponentVector;
	
	ComponentMap components;
	ComponentVector rendereableComponents;
};
