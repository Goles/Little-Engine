//
//  Range.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/10/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "ConstantsAndMacros.h"

namespace gg { namespace utils {
  
    struct Range {
        float min;
        float max;
    };
    
    static inline float randomBetweenRange(const Range &a_range)
    {
        return (CCRANDOM_MINUS1_1() * (a_range.min + (CCRANDOM_0_1() * a_range.max)));
    }
    
}}