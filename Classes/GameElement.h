//
//  GameElement.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


class GameElement
{
	
public:
	GameElement();
	virtual void draw();
	virtual void update();
	~GameElement();
};
