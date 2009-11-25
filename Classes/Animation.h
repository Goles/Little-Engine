//
//  Animation.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameEntity.h"
#import "Frame.h"
#import "vector"

enum {
	kDirection_Forward = 1,
	kDirection_Backwards = -1
};

typedef std::vector<Frame *> FRAMES_VECTOR;

class Animation
{
public:
	//constructors & destructor
	Animation();
	Animation(CGPoint startPoint);
	~Animation();
	
	//Action methods
	void	addFrameWithImage(Image *inImage, float delay);
	void	update(float delta);
	void	renderAtPoint(CGPoint inPoint);
	
	//Getters
	Image*	getCurrentFrameImage();
	Frame*	getFrame(GLuint frameNumber);
	GLuint	getCurrentFrameNumber();
	GLuint	getAnimationFrameCount();
	
	//Setters
	void	setIsRunning(BOOL inIsRunning);
	void	setIsRepeating(BOOL inIsRepeating);
	
	//inherited stuff.
	void draw();
	void update();
	
private:
	CGPoint			currentPoint;
	FRAMES_VECTOR	spriteFrames;
	float			frameTimer;
	BOOL			isRunning;
	BOOL			isRepeating;
	BOOL			isPingPong;
	int				direction;
	int				currentFrame;
};
