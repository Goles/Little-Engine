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

class GameEntity
{	
public:
	float x,y;
	Boolean	isActive;
	
	//Virtual Methods.
	virtual void draw()=0;
	virtual void update()=0;
	virtual void setIsActive(bool isActive)=0;

	//Getters & Setters
	Boolean getIsActive();
	void setIsActive(Boolean inActive);
	
	//Functors
	
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
};
