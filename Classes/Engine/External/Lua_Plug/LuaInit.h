/*
 *  LuaInit.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/17/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */
#ifndef __LUA_BASE_TYPES_H__
#define __LUA_BASE_TYPES_H__

#include <vector>

#include "LuaManager.h"

#include "FileUtils.h"
#include "ConstantsAndMacros.h"
#include "OpenGLCommon.h"

#include "Particle.h"
#include "GameEntity.h"
#include "Scene.h"
#include "Image.h"
#include "Frame.h"
#include "Animation.h"
#include "SpriteSheet.h"

#include "ITextRenderer.h"

#include "GEComponent.h"
#include "gecAnimatedSprite.h"
#include "gecFollowingCamera.h"
#include "gecFSM.h"
#include "gecJoystick.h"
#include "gecButton.h"
#include "gecBoxCollisionable.h"
#include "gecParticleSystem.h"

#include "SceneManager.h"
#include "FontManager.h"
#include "ParticleManager.h"

namespace gg
{
	namespace lua 
	{
		static inline void enableSettings(void)
		{
			lua_gc(LR_MANAGER_STATE, LUA_GCSTOP, 0);
		}
		
        static inline void bindBasicFunctions(void)
        {
            luabind::module(LR_MANAGER_STATE) 
            [
				luabind::def("fileRelativePath", &FileUtils::relativeCPathForFile),
				luabind::def("filePath", &FileUtils::fullCPathFromRelativePath),
				luabind::def("ggr", &CGRectMake),
				luabind::def("ggs", &CGSizeMake),
                luabind::def("ggp", &CGPointMake),
				luabind::def("gluLookAt", &gluLookAt),
                luabind::def("makeParticle", &gg::particle::utils::makeParticle)
			 ];
        }
        
		static inline void bindBasicTypes(void)
		{			
			luabind::module(LR_MANAGER_STATE)
			[
				luabind::class_<std::vector<float> >("float_vector")
				.def(luabind::constructor<>())
				.def("push_back", &std::vector<float>::push_back)
			];
			
			luabind::module(LR_MANAGER_STATE)
			[				
				luabind::class_<GGPoint>("GGPoint")
				.def(luabind::constructor<>())
				.def_readwrite("x", &GGPoint::x)
				.def_readwrite("y", &GGPoint::y)
			 ];
			
			luabind::module(LR_MANAGER_STATE)
			[
				luabind::class_<GGSize>("GGSize")
				.def_readwrite("width", &GGSize::width)
				.def_readwrite("height", &GGSize::height)
			];
			
			luabind::module(LR_MANAGER_STATE)
			[
				luabind::class_<CGRect>("GGRect")
				.def(luabind::constructor<>())
				.def_readwrite("origin", &GGRect::origin)
				.def_readwrite("size", &GGRect::size)
			];
            
            luabind::module(LR_MANAGER_STATE)
            [
                 luabind::class_<Particle>("Particle")
                 .def(luabind::constructor<>())
                 .def_readwrite("position", &Particle::position)
                 .def_readwrite("speed", &Particle::speed)
                 .def_readwrite("life", &Particle::life)
                 .def_readwrite("decay", &Particle::decay)
                 .def_readwrite("color_R", &Particle::color_R)
                 .def_readwrite("color_G", &Particle::color_G)
                 .def_readwrite("color_B", &Particle::color_B)
                 .def_readwrite("color_A", &Particle::color_A)             
                 .def_readwrite("rotation", &Particle::rotation)
             ];
		}
		 
		static inline void bindAbstractInterfaces(void)
		{
			luabind::module(LR_MANAGER_STATE) 
			[
				 luabind::class_<ITextRenderer>("ITextRenderer")
				 .def("setText", &ITextRenderer::setText)
				 .def("setFont", &ITextRenderer::setFont)
				 .def("setPosition", &ITextRenderer::setPosition)
			 ];
		}
		
		static inline void bindClasses(void)
		{
            /* Bind the Image Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<Image>("Image")
             .def(luabind::constructor<>())
             .def("initWithTextureFile", (void(Image::*)(const std::string &))&Image::initWithTextureFile)
             .property("scale", &Image::getScale, &Image::setScale)
             ];

            /* Bind the Frame Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<Frame>("Frame")	/** < Binds the GameEntity class */
             .def(luabind::constructor<>())		/** < Binds the GameEntity constructor */
             .property("image", &Frame::getFrameImage, &Frame::setFrameImage)
             .property("delay", &Frame::getFrameDelay, &Frame::setFrameDelay)
             ];
            
            /* Bind the Animation Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<Animation>("Animation")	/** < Binds the GameEntity class*/
             .def(luabind::constructor<>())				/** < Binds the GameEntity constructor  */
             .def("addFrame", &Animation::addFrame)
             .property("running", &Animation::getIsRunning, &Animation::setIsRunning)
             .property("repeating", &Animation::getIsRepeating, &Animation::setIsRepeating)
             .property("pingpong", &Animation::getIsPingPong, &Animation::setIsPingPong)
             .property("animation_label", &Animation::getAnimationLabel, &Animation::setAnimationLabel)
             ];
            
            /* Bind the SpriteSheet Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<SpriteSheet>("SpriteSheet")
             .def(luabind::constructor<>())
             .def("initWithImageNamed", &SpriteSheet::initWithImageNamed)
             .def("getSpriteAtCoordinate", &SpriteSheet::getSpriteAt)
             ];
            
            /* Bind the GEComponent Class */            
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<GEComponent>("GEComponent"),
             luabind::class_<gecAnimatedSprite, GEComponent>("gecAnimatedSprite")
             .def(luabind::constructor<>())
             .def("addAnimation", (void(gecAnimatedSprite::*)(const std::string &, Animation *)) &gecAnimatedSprite::addAnimation)
             .def("addCustomAnimation", (void(gecAnimatedSprite::*)(const std::string &,
                                                                    const std::vector<int> &, 
                                                                    const std::vector<float> &, 
                                                                    SpriteSheet *)) 
                  &gecAnimatedSprite::addAnimation)
             .def("setCurrentAnimation", &gecAnimatedSprite::setCurrentAnimation)
             .def("setCurrentRunning", &gecAnimatedSprite::setCurrentRunning)
             .def("setCurrentRepeating", &gecAnimatedSprite::setCurrentRepeating)
             .def("setCurrentPingPong", &gecAnimatedSprite::setCurrentPingPong)		 
             .def("setOwnerGE", &GEComponent::setOwnerGE)
             ];
            
            /* Bind the gecFollowingCamera Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<gecFollowingCamera, GEComponent>("gecFollowingCamera")
             .def(luabind::constructor<>())		
             .property("follow_x", &gecFollowingCamera::getFollowX, &gecFollowingCamera::setFollowX)
             .property("follow_y", &gecFollowingCamera::getFollowY, &gecFollowingCamera::setFollowY)
             .property("death_zone_x", &gecFollowingCamera::getDeathZoneX, &gecFollowingCamera::setDeathZoneX)
             .property("death_zone_y", &gecFollowingCamera::getDeathZoneY, &gecFollowingCamera::setDeathZoneY)
             .property("active", &gecFollowingCamera::getActive, &gecFollowingCamera::setActive)
             ];
            
            /* Bind the gecFSM Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<gecFSM, GEComponent>("gecFSM")	/** < Binds the gecFSM class*/
             .def(luabind::constructor<>())
             .def("setOwnerGE", &GEComponent::setOwnerGE)
             ];
            
            /* Bind the gecJoystick Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<gecJoystick, GEComponent>("gecJoystick")
             .def(luabind::constructor<>())
             .def("handle_touch", &gecJoystick::handle_touch)
             .def("setShape", &gecJoystick::setShape)
             .def("setCenter", &gecJoystick::setCenter)
             .def("setInRadius", &gecJoystick::setInRadius)
             .def("setOutRadius", &gecJoystick::setOutRadius)
             ];
            
            /* Bind the gecButton Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<gecButton, GEComponent>("gecButton")
             .def(luabind::constructor<>())
             .def("handle_touch", &gecButton::handle_touch)
             .def("setShape", &gecButton::setShape)
             .def("setParentSharedShape", &gecButton::setParentSharedShape)
             ];
            
            /* Bind the gecBoxCollisionable Class */
            luabind::module(LR_MANAGER_STATE)
            [
             luabind::class_<gecBoxCollisionable, GEComponent>("gecBoxCollisionable")
             .def(luabind::constructor<>())
             .def("setSize", &gecBoxCollisionable::setSize)
             .property("solid", &CompCollisionable::getSolid, &CompCollisionable::setSolid)
             ];
            
            /* Bind the gecParticleSystem Class */
            luabind::module(LR_MANAGER_STATE)
            [
                 luabind::class_<gecParticleSystem, GEComponent>("gecParticleSystem")
                 .enum_("RenderMode")
                 [
                      luabind::value("POINT_SPRITES", gg::particle::render::kRenderingMode_PointSprites),
                      luabind::value("QUADS", gg::particle::render::kRenderingMode_2xTriangles)
                  ]
                 .def(luabind::constructor<>())
                 .def("emit", &gecParticleSystem::setEmit)
                 .def("setDefaultParticle", &gecParticleSystem::setDefaultParticle)
                 .property("texture", &gecParticleSystem::texture, &gecParticleSystem::setTexture)
                 .property("emissionRate", &gecParticleSystem::emissionRate, &gecParticleSystem::setEmissionRate)
                 .property("emissionRateVariance", &gecParticleSystem::emissionRateVariance, &gecParticleSystem::setEmissionRateVariance)
                 .property("originVariance", &gecParticleSystem::originVariance, &gecParticleSystem::setOriginVariance)
                 .property("lifeVariance", &gecParticleSystem::lifeVariance, &gecParticleSystem::setLifeVariance)
                 .property("speedVariance", &gecParticleSystem::speedVariance, &gecParticleSystem::setSpeedVariance)
                 .property("decayVariance", &gecParticleSystem::decayVariance, &gecParticleSystem::setDecayVariance)
                 .property("emissionDuration", &gecParticleSystem::emissionDuration, &gecParticleSystem::setEmissionDuration)
                 .property("size", &gecParticleSystem::size, &gecParticleSystem::setSize)

            ];
            
            /* Bind the Game Entity Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<GameEntity>("GameEntity")		/** < Binds the GameEntity class */
             .def(luabind::constructor<>())					/** < Binds the GameEntity constructor  */
             .def("setGEC", &GameEntity::setGEC)			/** < Binds the GameEntity setGEC method  */
             .def("setPosition", &GameEntity::setPosition)	/** < Binds the GameEntity setPositon method */
             .def("getId", &GameEntity::getId)
             .def("debugPrintComponents", &GameEntity::debugPrintComponents)
             .property("active", &GameEntity::getIsActive, &GameEntity::setIsActive)
             .property("flipHorizontally", &GameEntity::getFlipHorizontally, &GameEntity::setFlipHorizontally)
             .property("label", &GameEntity::getLabel, &GameEntity::setLabel)
             .def_readwrite("x", &GameEntity::x)
             .def_readwrite("y", &GameEntity::y)
             .def_readwrite("speed", &GameEntity::speed)
             ];
            
            /* Bind the Scene Class */
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<Scene>("Scene")
             .def(luabind::constructor<>())
             .def("addEntity", &Scene::addGameEntity)
             .def("addChild", &Scene::addChild)
             .property("z_order", &Scene::getZOrder, &Scene::setZOrder)
             .property("position", &Scene::getPosition, &Scene::setPosition)
             .property("label", &Scene::getSceneLabel, &Scene::setSceneLabel)
             ];
		}
		
		static inline void bindManagers(void)
		{
            /* Bind Scene Manager */ 
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::class_<SceneManager>("SceneManager")
             .def("addScene", &SceneManager::addScene)
             .def("getScene", &SceneManager::getScene)
             .def("setActiveScene", &SceneManager::setActiveScene)
             .property("window", &SceneManager::getWindow, &SceneManager::setWindow)
             .scope
             [
                luabind::def("getInstance", &SceneManager::getInstance)
              ]
             ];
            
            /* Bind Font Manager*/
            luabind::module(LR_MANAGER_STATE) 
            [
			 luabind::class_<FontManager>("FontManager")
			 .def("getTextRenderer", &FontManager::getTextRenderer)
			 .scope
			 [
              luabind::def("getInstance", &FontManager::getInstance)
              ]
             ];
            
            /* Bind Particle Manager */
            luabind::module(LR_MANAGER_STATE)
            [
             luabind::class_<gg::particle::ParticleManager>("ParticleManager")
             .def("setMaxParticles", &gg::particle::ParticleManager::setMaxParticles)
             .scope
             [
              luabind::def("getInstance", &gg::particle::ParticleManager::getInstance)
             ]
            ];
		}

		static inline void bindAll(void)
		{			
			bindBasicTypes();
            bindBasicFunctions();
			bindAbstractInterfaces();
			bindClasses();
			bindManagers();
		}
	}
}
#endif