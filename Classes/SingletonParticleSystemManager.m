//
//  SingletonParticleSystemManager.m
//  Particles_2
//
//  Created by Nicolas Goles on 10/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingletonParticleSystemManager.h"
#import "ParticleSystem.h"

@implementation SingletonParticleSystemManager

- (id) init
{
	if((self = [super init]))
	{
		_systemsArray = NULL;
	}
	
	return self;
}

/*Inserts an entity System at the beggining of the Linked List*/
- (BOOL) insertEntity:(ParticleSystem *)inSystem
{
	SystemEntity *newElement;
	SystemEntity *currentElement;
	
	newElement = malloc(sizeof(SystemEntity));
	
	newElement->system = inSystem;
	newElement->nextSystem = NULL;
	
	currentElement = _systemsArray;
	
	/*We insert at the beginning*/
	if(currentElement == NULL) //The list is empty
	{
		currentElement = newElement;
		_systemsArray = currentElement;
		
		return YES;
	}else{	//The list is non nil
		newElement->nextSystem = currentElement;
		_systemsArray = newElement;
		
		return YES;
	}
	
	return NO;
}


/*Inserts an entity System at some specified position in the list from 0 to m-1*/
- (BOOL) removeEntityAtPosition:(int)inPosition
{
	int counter = 0;
	SystemEntity *currentElement	= _systemsArray;
	SystemEntity *previousElement	= _systemsArray;
	
	while (currentElement != NULL && counter <= inPosition) 
	{
		if(counter == inPosition)
		{
			previousElement->nextSystem = currentElement->nextSystem;
			/* We check if we are freeing the head, if we are, the new head is == previousElement*/
			if(_systemsArray == currentElement)
			{
				previousElement = currentElement->nextSystem;
				_systemsArray = previousElement;
			}
			
			/*Now free the current element*/
			[(ParticleSystem *)currentElement->system release];
			free(currentElement);
			
			return(YES);
		}		
		previousElement = currentElement;
		currentElement = currentElement->nextSystem;
		
		counter++;
	}
	
	return NO;
}

- (void) printListDebug
{
	SystemEntity *currentElement = _systemsArray;
	
	while (currentElement != NULL) 
	{
		printf("Number Of Particles: %d\n",[(ParticleSystem *)currentElement->system particleNumber]);
		
		currentElement = currentElement->nextSystem;
	}
}


- (BOOL) deleteEntity:(int) inPosition
{
	return NO;
}

- (void) dealloc
{
	/*Release the whole list here.*/
	
	[super dealloc];
}

@end
