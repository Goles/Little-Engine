//
//  SharedTextureManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/12/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "SharedTextureManager.h"
#include "FileUtils.h"

SharedTextureManager* SharedTextureManager::instance = NULL;

#pragma mark initializers
SharedTextureManager::SharedTextureManager() : boundTexture_id(-1)
{
	/*Should construct something*/
}

SharedTextureManager* SharedTextureManager::getInstance()
{
	if(instance == NULL)
		instance = new SharedTextureManager();
	
	return instance;
}

//TODO: check this if(it != texturesMap.end()) with STL MAP
#pragma mark action_methods
Texture2D* SharedTextureManager::createTexture(const std::string &textureName)
{
	//Should check if he has it, if it doesn't then create it.
	TextureMap::iterator it = texturesMap.find(textureName);
		
	/*If the key is already in the map*/
	if(it != texturesMap.end())
		return(it->second);
	
	/*If the key is NOT in the map*/
	Texture2D *imTexture;	
	NSString *textureFileName = [NSString stringWithUTF8String:textureName.c_str()];

    const NSString *fullPath = gg::utils::fullPathFromRelativePath(textureFileName);
    
	if([textureFileName hasSuffix:@".pvr"])
	{
		imTexture = [[Texture2D alloc] initWithPVRTCFile:(NSString *)fullPath];
	}else{
		imTexture = [[Texture2D alloc] initWithImagePath:[[NSBundle mainBundle] pathForResource:textureFileName ofType:nil] filter:GL_LINEAR];
	}
	
	return((texturesMap.insert(TextureMapPair(textureName, imTexture))).first->second);
}

void SharedTextureManager::bindTexture(const std::string &textureName)
{	
	if(boundTextureName.compare(textureName) != 0)
	{
		TextureMap::iterator it = texturesMap.find(textureName);
		
		if (it != texturesMap.end()) 
		{            
			glBindTexture(GL_TEXTURE_2D, [it->second name]);
			boundTextureName = textureName;
            boundTexture_id = [it->second name];
		}
		else {
			std::cout << "The texture " << textureName << " is not in the texturesMap!" << std::endl;
		}
	}
}

//This method is useful when using middleware that doesn't allow us to easily use our manager.
void SharedTextureManager::rebindPreviousTexture()
{
    if(boundTexture_id != -1)
        glBindTexture(GL_TEXTURE_2D, boundTexture_id);
}

#pragma mark getters_setters
void setBoundTexture(GLuint glTextureName)
{
	
}

#pragma mark DEBUG
void SharedTextureManager::printTextureMap()
{
	TextureMap::iterator it;
	
	for (it = texturesMap.begin(); it != texturesMap.end(); ++it)
		std::cout << (*it).first << " => " << (*it).second << std::endl;
}

#pragma mark destructor
SharedTextureManager::~SharedTextureManager()
{
	TextureMap::iterator it;
	
	for (it = texturesMap.begin(); it != texturesMap.end(); ++it)
		[(*it).second release]; //Release the Texture2D asociated with it.
	
	delete instance;
}


