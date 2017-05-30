//
//  Xword.h
//  QuickLookPUZ
//
//  Created by Diane on 1/11/17.
//  Copyright © 2017 Oslo's Paradise. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XwordSquare.h"

#ifndef Xword_h
	#define Xword_h
#endif

@interface Xword:NSObject;

@property (nonatomic) NSString *url;
@property (nonatomic) NSData *data;
@property (readonly) NSString *magic;
@property (readonly) int width;
@property (readonly) int height;
@property (readonly) int numclues;
@property (readonly) int scrambled;
@property (readonly) NSString *title;
@property (readonly) NSString *author;
@property (readonly) NSString *copyright;
@property (readonly) NSString *notes;
@property (readonly) NSMutableArray<XwordSquare *> *board;

@end


