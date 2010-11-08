//
//  FileUtils.h
//
//  Created by Nicolas Goles on 11/08/10.
//  Copyright 2010 GandoGames. All rights reserved.
//

#ifndef _FILE_UTILS_H_
#define _FILE_UTILS_H_

#import <Foundation/Foundation.h>

/** Helper class to handle file operations */
namespace FileUtils
{
    static const NSString * fullPathFromRelativePath(NSString *relPath)
    {
        // do not convert an absolute path (starting with '/')
        if(([relPath length] > 0) && ([relPath characterAtIndex:0] == '/'))
        {
            return relPath;
        }
        
        NSMutableArray *imagePathComponents = [NSMutableArray arrayWithArray:[relPath pathComponents]];
        NSString *file = [imagePathComponents lastObject];
        
        [imagePathComponents removeLastObject];
        NSString *imageDirectory = [NSString pathWithComponents:imagePathComponents];
        
        NSString *fullpath = [[NSBundle mainBundle] pathForResource:file
                                                             ofType:NULL
                                                        inDirectory:imageDirectory];
        if (fullpath == NULL)
            fullpath = relPath;
        
        return fullpath;	
    }
    
    static const char * relativeCPathForFile(const char *fileName)
    {        
        NSString *relPath = [[NSString alloc] initWithCString:fileName encoding:NSUTF8StringEncoding];        
        NSString *path = FileUtils::fullPathFromRelativePath(relPath);
        const char *c_path = [[path stringByDeletingLastPathComponent] UTF8String];
        
        return c_path;
    }
    
    static const char * fullCPathFromRelativePath(const char *cPath)
    {
        NSString *relPath = [[NSString alloc] initWithCString:cPath encoding:NSUTF8StringEncoding];
        
        NSString *path = FileUtils::fullPathFromRelativePath(relPath);
        
        const char *c_path = [path UTF8String];
        
        return c_path;
    }
}

#endif