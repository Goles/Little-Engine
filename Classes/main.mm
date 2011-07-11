//
//  main.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright Nicolas Goles 2009. All rights reserved.
//
//
#import <UIKit/UIKit.h>

#ifdef UNIT_TEST
    #include "unittestpp.h"
#endif

int main(int argc, char *argv[]) 
{

#ifdef UNIT_TEST
    printf("**** UNIT TESTS ****\n");
    int failNum = UnitTest::RunAllTests();
    printf("********************\n");

    if (failNum > 0)
        return 1;
#endif
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"Particles_2AppDelegate");
    [pool release];
    return retVal; 
}

