//
//  XwordSquare.m
//  QuickLookTest
//
//  Created by Diane on 1/11/17.
//  Copyright © 2017 Oslo's Paradise. All rights reserved.
//

#import "XwordSquare.h"

@implementation XwordSquare;

- (id)init
{
	self = [super init];

	_across = false;
	_down = false;
	_black = true;
	_number = 0;
	_circled = false;

	return self;
}

@end
