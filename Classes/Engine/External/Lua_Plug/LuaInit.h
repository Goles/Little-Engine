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
            

        }
        
        static inline void bindComponents(void)
        {
            lua_State *L = LR_MANAGER_STATE;
            
            luabridge::getGlobalNamespace (L)
            .beginClass <GEComponent> ("GEComponent")
                .addFunction("setOwnerGE", &GEComponent::setOwnerGE)
            .endClass()
            .deriveClass <gecAnimatedSprite, GEComponent> ("gecAnimatedSprite")
                .addConstructor <void (*) (void)> ()
                .addFunction("addAnimation", &gecAnimatedSprite::addAnimation)
                .addFunction("setCurrentAnimation", &gecAnimatedSprite::setCurrentAnimation)
                .addFunction("setCurrentRunning", &gecAnimatedSprite::setCurrentRunning)
                .addFunction("setCurrentRepeating", &gecAnimatedSprite::setCurrentRepeating)
                .addFunction("setCurrentPingPong", &gecAnimatedSprite::setCurrentPingPong)
            .endClass()
            .deriveClass <gecFollowingCamera, GEComponent> ("gecFollowingCamera")
                .addConstructor <void (*) (void)> ()
                .addProperty("follow_x", &gecFollowingCamera::getFollowX, &gecFollowingCamera::setFollowX)
                .addProperty("follow_y", &gecFollowingCamera::getFollowY, &gecFollowingCamera::setFollowY)
                .addProperty("death_zone_x", &gecFollowingCamera::getDeathZoneX, &gecFollowingCamera::setDeathZoneX)
                .addProperty("death_zone_y", &gecFollowingCamera::getDeathZoneY, &gecFollowingCamera::setDeathZoneY)
                .addProperty("active", &gecFollowingCamera::getActive, &gecFollowingCamera::setActive)
            .endClass()
            .deriveClass <gecFSM, GEComponent> ("gecFSM")
                .addConstructor <void (*) (void)> ()
            .endClass()
            .deriveClass <gecJoystick, GEComponent> ("gecJoystick")
                .addConstructor <void (*) (gg::event::IEventBroadcaster *)> ()
                .addFunction("handle_touch", &gecJoystick::handle_touch)
                .addFunction("setShape", &gecJoystick::setShape)
                .addFunction("setCenter", &gecJoystick::setCenter)
                .addFunction("setInRadius", &gecJoystick::setInRadius)
                .addFunction("setOutRadius", &gecJoystick::setOutRadius)
            .endClass()
            .deriveClass <gecButton, GEComponent> ("gecButton")
                .addConstructor <void (*) (gg::event::IEventBroadcaster *)> ()
                .addFunction("handle_touch", &gecButton::handle_touch)
                .addFunction("setShape", &gecButton::setShape)
                .addFunction("setParentSharedShape", &gecButton::setParentSharedShape)
            .endClass()
            .deriveClass <gecBoxCollisionable, GEComponent> ("gecBoxCollisionable")
                .addConstructor <void (*) (void)> ()
                .addFunction("setSize", &gecBoxCollisionable::setSize)
                .addProperty("solid", &gecBoxCollisionable::getSolid, &gecBoxCollisionable::setSolid)
            .endClass()
            .deriveClass <gecVisual, GEComponent> ("gecVisual")
                .addFunction("setColor", &gecVisual::setColor)
                .addFunction("setScale", &gecVisual::setScale)
                .addFunction("setAlpha", &gecVisual::setAlpha)
            .endClass()
            .deriveClass <gecImage, gecVisual> ("gecImage")
                .addConstructor <void (*) (void)> ()
                .addFunction("setImage", &gecImage::setImage)
            .endClass()
            .deriveClass <gecParticleSystem, gecVisual> ("gecParticleSystem")
                .addConstructor <void (*) (void)> ()
                .addFunction("setEmit", &gecParticleSystem::setEmit)
                .addFunction("setDefaultParticle", &gecParticleSystem::setDefaultParticle)
                .addProperty("texture", &gecParticleSystem::texture, &gecParticleSystem::setTexture)
                .addProperty("emissionRate", &gecParticleSystem::emissionRate, &gecParticleSystem::setEmissionRate)
                .addProperty("emissionRateVariance", &gecParticleSystem::emissionRateVariance, &gecParticleSystem::setEmissionRateVariance)
                .addProperty("originVariance", &gecParticleSystem::originVariance, &gecParticleSystem::setOriginVariance)
                .addProperty("lifeVariance", &gecParticleSystem::lifeVariance, &gecParticleSystem::setLifeVariance)
                .addProperty("speedVariance", &gecParticleSystem::speedVariance, &gecParticleSystem::setSpeedVariance)
                .addProperty("decayVariance", &gecParticleSystem::decayVariance, &gecParticleSystem::setDecayVariance)
                .addProperty("emissionDuration", &gecParticleSystem::emissionDuration, &gecParticleSystem::setEmissionDuration)
                .addProperty("size", &gecParticleSystem::size, &gecParticleSystem::setSize)
            .endClass()
            .deriveClass <CompEventScheduler, GEComponent> ("CompEventScheduler")
                .addFunction("scheduleEvent", &CompEventScheduler::scheduleEvent)
                .addFunction("unscheduleEvent", &CompEventScheduler::unscheduleEvent)
                .addFunction("pauseScheduledEvent", &CompEventScheduler::pauseScheduledEvent)
                .addFunction("resetScheduledEvent", &CompEventScheduler::resetScheduledEvent)
            .endClass()
            .deriveClass <gecTinyEventScheduler, CompEventScheduler> ("gecTinyEventScheduler")
                .addConstructor <void (*) (gg::event::EventScheduler *)> ()
            .endClass();
            
        } // END Bind Components
        
		static inline void bindClasses(void)
		{
            lua_State *L = LR_MANAGER_STATE;
            
            luabridge::getGlobalNamespace (L)
                .beginClass<Scene> ("Scene")
                    .addConstructor <void (*) (void)> ()
                    .addFunction ("addEntity", &Scene::addGameEntity)
                    .addFunction ("addChild", &Scene::addChild)
                    .addProperty ("position", &Scene::getPosition, &Scene::setPosition)
                    .addProperty ("z_order", &Scene::getZOrder, &Scene::setZOrder)
                    .addProperty ("label", &Scene::getSceneLabel, &Scene::setSceneLabel)
                .endClass()
                .beginClass<GameEntity> ("GameEntity")
                    .addConstructor<void (*) (void)> ()
                    .addFunction("setGEC", &GameEntity::setGEC)
                    .addFunction("getGEC", &GameEntity::getGEC)
                    .addFunction("setPosition", &GameEntity::setPosition)
                    .addFunction("debugPrintComponents", &GameEntity::debugPrintComponents)
                    .addProperty("id", &GameEntity::getId)
                    .addProperty("active", &GameEntity::getIsActive, &GameEntity::setIsActive)
                    .addProperty("flipped", &GameEntity::getFlipHorizontally, &GameEntity::setFlipHorizontally)
                    .addProperty("x", &GameEntity::getPositionX, &GameEntity::setPositionX)
                    .addProperty("y", &GameEntity::getPositionY, &GameEntity::setPositionY)
                    .addProperty("speed", &GameEntity::getSpeed, &GameEntity::setSpeed)
                .endClass()
                .beginClass<SpriteSheet> ("SpriteSheet")
                    .addConstructor<void (*) (void)> ()
                    .addFunction("initWithImageNamed", &SpriteSheet::initWithImageNamed)
                    .addFunction("getSpriteAtCoordinate", &SpriteSheet::getSpriteAt)
                .endClass()
                .beginClass<Image> ("Image")
                    .addConstructor<void (*) (void)> ()
                    .addFunction("initWithTextureFile", &Image::initWithTextureFile)
                    .addProperty("scale", &Image::getScale, &Image::setScale)
                .endClass()
                .beginClass<Frame> ("Frame")
                    .addConstructor<void (*) (void)> ()
                    .addProperty("image", &Frame::getFrameImage, &Frame::setFrameImage)
                    .addProperty("delay", &Frame::getFrameDelay, &Frame::setFrameDelay)
                .endClass()
                .beginClass<Animation> ("Animation")
                    .addConstructor<void (*) (void)> ()
                    .addFunction("addFrame", &Animation::addFrame)
                    .addProperty("running", &Animation::getIsRunning, &Animation::setIsRunning)
                    .addProperty("repeating", &Animation::getIsRepeating, &Animation::setIsRepeating)
                    .addProperty("pingpong", &Animation::getIsPingPong, &Animation::setIsPingPong)
                    .addProperty("animation_label", &Animation::getAnimationLabel, &Animation::setAnimationLabel)
                .endClass()
                .beginClass<gg::utils::HardwareClock> ("HardwareClock")
                    .addConstructor<void (*) (void)> ()
                    .addFunction("reset", &gg::utils::HardwareClock::Reset)
                    .addFunction("getTime", &gg::utils::HardwareClock::GetTime)
                    .addFunction("getDeltaTime", &gg::utils::HardwareClock::GetDeltaTime)
                    .addFunction("Update", &gg::utils::HardwareClock::GetDeltaTime)
                .endClass()
                .beginClass <IFont> ("IFont")
                    .addFunction("openFont", &IFont::openFont)
                .endClass()
                .deriveClass<AngelCodeFont, IFont> ("AngelCodeFont")
                    .addConstructor<void (*) (void)> ()
                .endClass()
                .beginClass <ITextRenderer> ("ITextRenderer")
                    .addFunction("setText", &ITextRenderer::setText)
                    .addFunction("setFont", &ITextRenderer::setFont)
                    .addFunction("setPosition", &ITextRenderer::setPosition)
                .endClass()
                .deriveClass<AngelCodeTextRenderer, ITextRenderer> ("AngelCodeTextRenderer")
                    .addConstructor<void (*) (void)> ()
                .endClass();
            
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
			bindClasses();
            bindComponents();
			bindManagers();
		}
	}
}
#endif