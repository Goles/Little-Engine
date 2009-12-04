//
//  SharedTextureManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/12/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

/* This class contains a Singleton instance of a Global Textures manager
 * the idea is to make this class to manage all the game loaded textures. (allocs, releases, etc)
 * This manager will store the textures inside a Map, which gives a worst direct access time of O(logn) to a texture
 * when searching by it's key. ( Which is the texture file name)
 *  
 * In the engine, every entity that would want to instantiate a Texture, would have to ask this Manager to do it, and 
 * not try to instanciate a Texture2D directly. The manager in return should give a Texture2D pointer. In the engine   
 * however, remember that Texture2D lives encapsulated in the Image Class.
 * 
 * _NG November 12 - 2009
 */

#import <Foundation/Foundation.h>
#import "Texture2D.h"
#include <map>
#include <string>
#include <iostream>

#define TEXTURE_MANAGER SharedTextureManager::getInstance()

class SharedTextureManager
{
public:
	//Action Methods
	static		SharedTextureManager* getInstance();
	Texture2D*	createTexture(const std::string &textureName);
	void		bindTexture(const std::string &textureName);
	
	//Destructor
	~SharedTextureManager();
	
	//Debug Methods
	void printTextureMap();
	
	//getters & setters
	GLuint getBoundTexture();
	void   setBoundTexture(GLuint glTextureName);
	
protected:
	SharedTextureManager();
	
private:
	typedef std::map<std::string, Texture2D*> TextureMap;
	typedef std::pair<std::string, Texture2D*> TextureMapPair;
	static SharedTextureManager *instance;
	TextureMap texturesMap;
	std::string boundTextureName;
};