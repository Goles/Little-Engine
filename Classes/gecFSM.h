/*
 *  gecFSM.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _GEC_FSM_H_
#define _GEC_FSM_H_

#define MAX_STATES 8
#define MAX_ACTION 8

#include "gecBehaviour.h"
#include <map>

class gecFSM : public gecBehaviour 
{
	//GEComponent Interface
public:
	virtual const gec_id_type&	componentID() const { return mComponentID; }
	virtual void update(float delta);
	
public:
	//Constructors
	gecFSM();
	gecFSM(kBehaviourState s) { state = s; }
	
	//Interface
	void setRule(kBehaviourState initialState, 
				 int inputAction, 
				 kBehaviourState resultingState, const				
				 std::string &resultingStateName);
	void performAction(kBehaviourAction action);
	void animationFinishedDelegate();
	
protected:
	const std::string getNameForAction(kBehaviourState action) const;
	
private:
	typedef std::map<int, const std::string> actionMap;
	typedef std::pair<int, const std::string> actionMapPair;
	kBehaviourState fsmTable[MAX_STATES][MAX_ACTION];
	static gec_id_type mComponentID;
	actionMap actionNameMap;
};

#endif 