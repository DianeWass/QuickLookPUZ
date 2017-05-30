//
//  XwordSquare.h
//  QuickLookPUZ
//
//  Created by Diane on 1/11/17.
//  Copyright © 2017 Oslo's Paradise. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef XwordSquare_h
	#define XwordSquare_h
#endif

@interface XwordSquare:NSObject;

@property NSString *acrossclue;
@property NSString *downclue;
@property BOOL across;
@property BOOL down;
@property BOOL black;
@property BOOL circled;
@property char answer;
@property char solution;
@property int number;

@end
