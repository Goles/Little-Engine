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

extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
}

#include "LuaBridge.h"

#include "ggEngine.h"

#include "FileUtils.h"
#include "ConstantsAndMacros.h"
#include "OpenGLCommon.h"
#include "HardwareClock.h"

#include "Action.h"
#include "FiniteTimeAction.h"
#include "UnisonAction.h"
#include "FadeInAction.h"
#include "FadeOutAction.h"
#include "MoveByAction.h"
#include "MoveToAction.h"
#include "ScaleToAction.h"

#include "AngelCodeTextRenderer.h"
#include "AngelCodeFont.h"
#include "Particle.h"
#include "GameEntity.h"
#include "Scene.h"
#include "Image.h"
#include "Frame.h"
#include "Animation.h"
#include "SpriteSheet.h"
#include "ScheduledEvent.h"
#include "EventBroadcaster.h"
#include "IFont.h"
#include "ITextRenderer.h"
#include "IAction.h"

#include "GEComponent.h"
#include "CompEventScheduler.h"
#include "gecAnimatedSprite.h"
#include "gecFollowingCamera.h"
#include "gecFSM.h"
#include "gecJoystick.h"
#include "gecButton.h"
#include "gecBoxCollisionable.h"
#include "gecParticleSystem.h"
#include "gecImage.h"
#include "gecTinyEventScheduler.h"

#include "SceneManager.h"
#include "ParticleManager.h"
#include "SimpleAudioEngine.h"
#include "CocosDenshion.h"
#include "CDAudioManager.h"
#include "ActionManager.h"
#include "FontManager.h"

#include "EventBroadcaster.h"

using namespace gg::action;
using namespace gg::event;

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
            lua_State *L = LR_MANAGER_STATE;
            
            luabridge::getGlobalNamespace (L)
                .addFunction("fileRelativePath", &gg::util::relativeCPathForFile)
                .addFunction("filePath", &gg::util::fullCPathFromRelativePath)
                .addFunction("ggr", &CGRectMake)
                .addFunction("ggs", &CGSizeMake)
                .addFunction("ggp", &CGPointMake)
                .addFunction("eventBroadcaster", &gg::event::EventBroadcaster::sharedManager);
//                .addFunction("makeParticle", gg::particle::utils::makeParticle)
        }
       
		static inline void bindBasicTypes(void)
		{
            lua_State *L = LR_MANAGER_STATE;
//			luabind::module(LR_MANAGER_STATE)
//			[
//				luabind::class_<std::vector<float> > ("float_vector")
//				.def(luabind::constructor<>())
//				.def("push_back", &std::vector<float>::push_back)
//			];
//            
//            luabind::module(LR_MANAGER_STATE)
//            [
//                luabind::class_<TouchTypes> ("TouchTypes")
//                .enum_("constants")
//                [
//                    luabind::value("BEGAN", TouchTypes::BEGAN),
//                    luabind::value("MOVED", TouchTypes::MOVED),
//                    luabind::value("ENDED", TouchTypes::ENDED)
//                ]
//            ];
//			
//			luabind::module(LR_MANAGER_STATE)
//			[				
//				luabind::class_<GGPoint> ("GGPoint")
//				.def(luabind::constructor<>())
//				.def_readwrite("x", &GGPoint::x)
//				.def_readwrite("y", &GGPoint::y)
//			 ];
//			
//			luabind::module(LR_MANAGER_STATE)
//			[
//				luabind::class_<GGSize> ("GGSize")
//				.def_readwrite("width", &GGSize::width)
//				.def_readwrite("height", &GGSize::height)
//			];
            
            luabridge::getGlobalNamespace (L)
                .beginClass<GGPoint> ("GGPoint")
                    .addData("x", &GGPoint::x)
                    .addData("y", &GGPoint::y)
                .endClass()
                .beginClass<GGSize> ("GGSize")
                    .addData("width", &GGSize::width)
                    .addData("height", &GGSize::height)
                .endClass()
                .beginClass<CGRect> ("GGRect")
                    .addData("origin", &GGRect::origin)
                    .addData("size", &GGRect::size)
                .endClass();
            
//			
//			luabind::module(LR_MANAGER_STATE)
//			[
//				luabind::class_<CGRect> ("GGRect")
//				.def(luabind::constructor<>())
//				.def_readwrite("origin", &GGRect::origin)
//				.def_readwrite("size", &GGRect::size)
//			];
//            
//            luabind::module(LR_MANAGER_STATE)
//            [
//                 luabind::class_<Particle> ("Particle")
//                 .def(luabind::constructor<>())
//                 .def_readwrite("position", &Particle::position)
//                 .def_readwrite("speed", &Particle::speed)
//                 .def_readwrite("life", &Particle::life)
//                 .def_readwrite("decay", &Particle::decay)
//                 .def_readwrite("color_R", &Particle::color_R)
//                 .def_readwrite("color_G", &Particle::color_G)
//                 .def_readwrite("color_B", &Particle::color_B)
//                 .def_readwrite("color_A", &Particle::color_A)
//                 .def_readwrite("rotation", &Particle::rotation)
//             ];
//            
//            /* Actions */
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<IAction> ("IAction")
//             .def("isDone", &IAction::isDone)
//             .def("setTarget", &IAction::setTarget)
//             .def("stop", &IAction::stop),
//             
//             luabind::class_<Action, IAction> ("Action")
//             .def("setRepeatTimes", &Action::setRepeatTimes),
//             
//             luabind::class_<FiniteTimeAction, Action> ("FiniteTimeAction")
//             .def("setDuration", &FiniteTimeAction::setDuration),
//             
//             luabind::class_<FadeInAction, FiniteTimeAction> ("FadeInAction")
//             .def(luabind::constructor<>()),
//             
//             luabind::class_<FadeOutAction, FiniteTimeAction> ("FadeOutAction")
//             .def(luabind::constructor<>()),
//             
//             luabind::class_<MoveToAction, FiniteTimeAction> ("MoveToAction")
//             .def(luabind::constructor<>())
//             .def("setEndPoint", &MoveToAction::setEndPoint),
//             
//             luabind::class_<MoveByAction, FiniteTimeAction> ("MoveByAction")
//             .def(luabind::constructor<>())
//             .def("setMovementOffset", &MoveByAction::setMovementOffset),
//             
//             luabind::class_<UnisonAction, FiniteTimeAction> ("UnisonAction")
//             .def(luabind::constructor<>())
//             .def("addChildAction", &UnisonAction::addChildAction),
//             
//             luabind::class_<ScaleToAction, FiniteTimeAction> ("ScaleToAction")
//             .def(luabind::constructor<>())
//             .def("setEndScale", &ScaleToAction::setEndScale)
//             ];
//            
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<gg::event::ScheduledEvent> ("ScheduledEvent")
//             .def(luabind::constructor<>())
//             .def_readwrite("type", &gg::event::ScheduledEvent::type)
//             .def_readwrite("trigerTime", &gg::event::ScheduledEvent::triggerTime)
//             .def_readwrite("elapsedTime", &gg::event::ScheduledEvent::elapsedTime)
//             .def_readwrite("handle", &gg::event::ScheduledEvent::handle)
//             .def_readwrite("isPaused", &gg::event::ScheduledEvent::isPaused)
//             .def_readwrite("isRepeating", &gg::event::ScheduledEvent::isRepeating)
//             ];
            
        } //END bindBasicTypes
        
		static inline void bindAbstractInterfaces(void)
		{            
//			luabind::module(LR_MANAGER_STATE) 
//			[
//				 luabind::class_<ITextRenderer> ("ITextRenderer")
//				 .def("setText", &ITextRenderer::setText)
//				 .def("setFont", &ITextRenderer::setFont)
//				 .def("setPosition", &ITextRenderer::setPosition),
//                 luabind::class_<AngelCodeTextRenderer, ITextRenderer> ("AngelCodeTextRenderer")
//                 .def(luabind::constructor<>())             
//            ];
//            
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<gg::event::IEventBroadcaster> ("IEventBroadcaster")
//            ];
//		}
//		
//        static inline void bindComponents(void)
//        {
//            /* Bind the GEComponent Class */            
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<GEComponent> ("GEComponent"),
//             luabind::class_<gecAnimatedSprite, GEComponent> ("gecAnimatedSprite")
//             .def(luabind::constructor<>())
//             .def("addAnimation", (void(gecAnimatedSprite::*)(const std::string &, Animation *)) &gecAnimatedSprite::addAnimation)
//             .def("addCustomAnimation", (void(gecAnimatedSprite::*)(const std::string &,
//                                                                    const std::vector<int> &, 
//                                                                    const std::vector<float> &, 
//                                                                    SpriteSheet *)) 
//                  &gecAnimatedSprite::addAnimation)
//             .def("setCurrentAnimation", &gecAnimatedSprite::setCurrentAnimation)
//             .def("setCurrentRunning", &gecAnimatedSprite::setCurrentRunning)
//             .def("setCurrentRepeating", &gecAnimatedSprite::setCurrentRepeating)
//             .def("setCurrentPingPong", &gecAnimatedSprite::setCurrentPingPong)		 
//             .def("setOwnerGE", &GEComponent::setOwnerGE)
//             ];
//            
//            /* Bind the gecFollowingCamera Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<gecFollowingCamera, GEComponent> ("gecFollowingCamera")
//             .def(luabind::constructor<>())		
//             .property("follow_x", &gecFollowingCamera::getFollowX, &gecFollowingCamera::setFollowX)
//             .property("follow_y", &gecFollowingCamera::getFollowY, &gecFollowingCamera::setFollowY)
//             .property("death_zone_x", &gecFollowingCamera::getDeathZoneX, &gecFollowingCamera::setDeathZoneX)
//             .property("death_zone_y", &gecFollowingCamera::getDeathZoneY, &gecFollowingCamera::setDeathZoneY)
//             .property("active", &gecFollowingCamera::getActive, &gecFollowingCamera::setActive)
//             ];
//            
//            /* Bind the gecFSM Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<gecFSM, GEComponent> ("gecFSM")	/** < Binds the gecFSM class*/
//             .def(luabind::constructor<>())
//             .def("setOwnerGE", &GEComponent::setOwnerGE)
//             ];
//            
//            /* Bind the gecJoystick Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<gecJoystick, GEComponent> ("gecJoystick")
//             .def(luabind::constructor<gg::event::IEventBroadcaster *>())
//             .def("handle_touch", &gecJoystick::handle_touch)
//             .def("setShape", &gecJoystick::setShape)
//             .def("setCenter", &gecJoystick::setCenter)
//             .def("setInRadius", &gecJoystick::setInRadius)
//             .def("setOutRadius", &gecJoystick::setOutRadius)
//             ];
//            
//            /* Bind the gecButton Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<gecButton, GEComponent> ("gecButton")
//             .def(luabind::constructor<gg::event::IEventBroadcaster *>())
//             .def("handle_touch", &gecButton::handle_touch)
//             .def("setShape", &gecButton::setShape)
//             .def("setParentSharedShape", &gecButton::setParentSharedShape)
//             ];
//            
//            /* Bind the gecBoxCollisionable Class */
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<gecBoxCollisionable, GEComponent> ("gecBoxCollisionable")
//             .def(luabind::constructor<>())
//             .def("setSize", &gecBoxCollisionable::setSize)
//             .property("solid", &CompCollisionable::getSolid, &CompCollisionable::setSolid)
//             ];
//            
//            /* Bind the gecVisual Components */
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<gecVisual, GEComponent> ("gecVisual")
//             .def("setColor", &gecVisual::setColor)
//             .def("setScale", &gecVisual::setScale)
//             .def("setAlpha", &gecVisual::setAlpha),
//             
//             luabind::class_<gecImage, gecVisual> ("gecImage")
//             .def(luabind::constructor<>())
//             .def("setImage", &gecImage::setImage),
//             
//             luabind::class_<gecParticleSystem, gecVisual> ("gecParticleSystem")
//             .enum_("RenderMode")
//             [
//              luabind::value("POINT_SPRITES", gg::particle::render::kRenderingMode_PointSprites),
//              luabind::value("QUADS", gg::particle::render::kRenderingMode_2xTriangles)
//              ]
//             .def(luabind::constructor<>())
//             .def("emit", &gecParticleSystem::setEmit)
//             .def("setDefaultParticle", &gecParticleSystem::setDefaultParticle)
//             .property("texture", &gecParticleSystem::texture, &gecParticleSystem::setTexture)
//             .property("emissionRate", &gecParticleSystem::emissionRate, &gecParticleSystem::setEmissionRate)
//             .property("emissionRateVariance", &gecParticleSystem::emissionRateVariance, &gecParticleSystem::setEmissionRateVariance)
//             .property("originVariance", &gecParticleSystem::originVariance, &gecParticleSystem::setOriginVariance)
//             .property("lifeVariance", &gecParticleSystem::lifeVariance, &gecParticleSystem::setLifeVariance)
//             .property("speedVariance", &gecParticleSystem::speedVariance, &gecParticleSystem::setSpeedVariance)
//             .property("decayVariance", &gecParticleSystem::decayVariance, &gecParticleSystem::setDecayVariance)
//             .property("emissionDuration", &gecParticleSystem::emissionDuration, &gecParticleSystem::setEmissionDuration)
//             .property("size", &gecParticleSystem::size, &gecParticleSystem::setSize)             
//
//            ];
//            
//            /* Bind the event scheduler components */
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<CompEventScheduler, GEComponent> ("CompEventScheduler")
//             .def("scheduleEvent", &CompEventScheduler::scheduleEvent)
//             .def("unscheduleEvent", &CompEventScheduler::unscheduleEvent)
//             .def("pauseScheduledEvent", &CompEventScheduler::pauseScheduledEvent)
//             .def("resetScheduledEvent", &CompEventScheduler::resetScheduledEvent),
//             luabind::class_<gecTinyEventScheduler, CompEventScheduler> ("gecTinyEventScheduler")
//             .def(luabind::constructor< gg::event::EventScheduler * >())
//             ];

        } //END bindComponents
        
		static inline void bindClasses(void)
		{
            lua_State *L = LR_MANAGER_STATE;
            luabridge::getGlobalNamespace(L)
                .beginClass<Scene> ("Scene")
                    .addFunction ("addEntity", &Scene::addGameEntity)
                    .addFunction ("addChild", &Scene::addChild)
                    .addProperty ("position", &Scene::getPosition, &Scene::setPosition)
                    .addProperty ("z_order", &Scene::getZOrder, &Scene::setZOrder)
                    .addProperty ("label", &Scene::getSceneLabel, &Scene::setSceneLabel)
                .endClass();
            
            
            //            /* Bind the Scene Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<Scene> ("Scene")
//             .def(luabind::constructor<>())
//             .def("addEntity", &Scene::addGameEntity)
//             .def("addChild", &Scene::addChild)
//             .property("z_order", &Scene::getZOrder, &Scene::setZOrder)
//             .property("position", &Scene::getPosition, &Scene::setPosition)
//             .property("label", &Scene::getSceneLabel, &Scene::setSceneLabel)
//                         ];
            
            
//            /* Bind the Image Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<Image> ("Image")
//             .def(luabind::constructor<>())
//             .def("initWithTextureFile", (void(Image::*)(const std::string &))&Image::initWithTextureFile)
//             .property("scale", &Image::getScale, &Image::setScale)
//             ];
//
//            /* Bind the Frame Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<Frame> ("Frame")	/** < Binds the GameEntity class */
//             .def(luabind::constructor<>())		/** < Binds the GameEntity constructor */
//             .property("image", &Frame::getFrameImage, &Frame::setFrameImage)
//             .property("delay", &Frame::getFrameDelay, &Frame::setFrameDelay)
//             ];
//            
//            /* Bind the Animation Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<Animation> ("Animation")	/** < Binds the GameEntity class*/
//             .def(luabind::constructor<>())				/** < Binds the GameEntity constructor  */
//             .def("addFrame", &Animation::addFrame)
//             .property("running", &Animation::getIsRunning, &Animation::setIsRunning)
//             .property("repeating", &Animation::getIsRepeating, &Animation::setIsRepeating)
//             .property("pingpong", &Animation::getIsPingPong, &Animation::setIsPingPong)
//             .property("animation_label", &Animation::getAnimationLabel, &Animation::setAnimationLabel)
//             ];
//            
//            /* Bind the SpriteSheet Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<SpriteSheet> ("SpriteSheet")
//             .def(luabind::constructor<>())
//             .def("initWithImageNamed", &SpriteSheet::initWithImageNamed)
//             .def("getSpriteAtCoordinate", &SpriteSheet::getSpriteAt)
//             ];
//            
//                        
//            /* Bind the Game Entity Class */
//            luabind::module(LR_MANAGER_STATE) 
//            [
//             luabind::class_<GameEntity> ("GameEntity")		/** < Binds the GameEntity class */
//             .def(luabind::constructor<>())					/** < Binds the GameEntity constructor  */
//             .def("setGEC", &GameEntity::setGEC)			/** < Binds the GameEntity setGEC method  */
//             .def("setPosition", &GameEntity::setPosition)	/** < Binds the GameEntity setPositon method */
//             .def("getId", &GameEntity::getId)
//             .def("debugPrintComponents", &GameEntity::debugPrintComponents)
//             .property("active", &GameEntity::getIsActive, &GameEntity::setIsActive)
//             .property("flipped", &GameEntity::getFlipHorizontally, &GameEntity::setFlipHorizontally)
//             .property("label", &GameEntity::getLabel, &GameEntity::setLabel)
//             .property("x", &GameEntity::getPositionX, &GameEntity::setPositionX)
//             .property("y", &GameEntity::getPositionY, &GameEntity::setPositionY)
//             .def_readwrite("speed", &GameEntity::speed)
//             ];
//            

//           
//            /* Bind the Class Hardware Clock */
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<gg::utils::HardwareClock> ("HardwareClock")
//             .def(luabind::constructor<>())
//             .def("reset", &gg::utils::HardwareClock::Reset)
//             .def("getTime", &gg::utils::HardwareClock::GetTime)
//             .def("getDeltaTime", &gg::utils::HardwareClock::GetDeltaTime)
//             .def("Update", &gg::utils::HardwareClock::Update)
//            ];
//            
//            /* Fonts */
//            luabind::module(LR_MANAGER_STATE)
//            [
//             luabind::class_<IFont> ("IFont")
//             .def("openFont", &IFont::openFont),
//             
//             luabind::class_<AngelCodeFont, IFont> ("AngelCodeFont")
//             .def(luabind::constructor<>())
//             
//            ];
		} //END bindClasses
		
		static inline void bindManagers(void)
		{
            /* Bind Scene Manager */
            lua_State *L = LR_MANAGER_STATE;
            
            luabridge::getGlobalNamespace (L)
                .beginClass<SceneManager> ("SceneManager")
                    .addFunction("addScene", &SceneManager::addScene)
                    .addFunction("getScene", &SceneManager::getScene)
                    .addStaticFunction("getInstance", &SceneManager::getInstance)
                .endClass()
                .beginClass<gg::particle::ParticleManager> ("ParticleManager")
                    .addFunction("setMaxParticles", &gg::particle::ParticleManager::setMaxParticles)
                    .addStaticFunction("getInstance", &gg::particle::ParticleManager::getInstance)
                .endClass()
                .beginClass<CocosDenshion::SimpleAudioEngine>("SimpleAudioEngine")
                    .addFunction("_preloadBackgroundMusic", &CocosDenshion::SimpleAudioEngine::preloadBackgroundMusic)
                    .addFunction("_stopBackgroundMusic", &CocosDenshion::SimpleAudioEngine::stopBackgroundMusic)
                    .addFunction("_playBackgroundMusic", &CocosDenshion::SimpleAudioEngine::playBackgroundMusic)
                    .addFunction("_pauseBackgroundMusic", &CocosDenshion::SimpleAudioEngine::pauseBackgroundMusic)
                    .addFunction("_resumeBackgroundMusic", &CocosDenshion::SimpleAudioEngine::resumeBackgroundMusic)
                    .addFunction("_setBackgroundMusicVolume", &CocosDenshion::SimpleAudioEngine::setBackgroundMusicVolume)
                    .addFunction("_setEffectsVolume", &CocosDenshion::SimpleAudioEngine::setEffectsVolume)
                    .addFunction("_playEffect", &CocosDenshion::SimpleAudioEngine::playEffect)
                    .addFunction("_stopEffect", &CocosDenshion::SimpleAudioEngine::stopEffect)
                    .addFunction("_preloadEffect", &CocosDenshion::SimpleAudioEngine::preloadEffect)
                    .addFunction("_unloadEffect", &CocosDenshion::SimpleAudioEngine::unloadEffect)
                .endClass()
                .beginClass<ActionManager> ("ActionManager")
                    .addFunction("addAction", &ActionManager::addAction)
                    .addStaticFunction("getInstance", &ActionManager::getInstance)
                .endClass()
                .beginClass<FontManager> ("FontManager")
                    .addFunction("textRenderer", &FontManager::textRenderer)
                    .addStaticFunction("getInstance", &FontManager::getInstance)
                .endClass();
		}

		static inline void bindAll(void)
		{			
			bindBasicTypes();
            bindBasicFunctions();
//			bindAbstractInterfaces();
//			bindClasses();
//            bindComponents();
			bindManagers();
		}
	}
}
#endif