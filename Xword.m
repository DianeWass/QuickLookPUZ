//
//  Xword.m
//  QuickLookPUZ
//
//  Created by Diane on 1/11/17.
//  Copyright © 2017 Oslo's Paradise. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Xword.h"
#import "XwordSquare.h"

@implementation Xword;

- (id)init
{
	self = [super init];
	
	_width = 0;
	_height = 0;
	_numclues = 0;
	_scrambled = 0;
	
	return self;
}

- (void)setData:(NSData *)data
{
	_data = data;
	
	if ((self.data != nil) && (self.data.length > 52) && ([self.magic isEqualToString:@"ACROSS&DOWN"]))
	{
		_width = ((const unsigned char *)[self.data bytes])[44];
		_height = ((const unsigned char *)[self.data bytes])[45];
		_numclues = ((const unsigned char *)[self.data bytes])[46] + 255 * ((const unsigned char *)[self.data bytes])[47];
		_scrambled = ((const unsigned char *)[self.data bytes])[50] + 255 * ((const unsigned char *)[self.data bytes])[51];

		_board = [self getBoard];
	}
}

- (NSString *)magic
{
	return ((self.data != nil) && (self.data.length > 14)) ? [[NSString alloc] initWithBytes:((const char *)[self.data bytes] + 2) length:11 encoding:NSISOLatin1StringEncoding] : nil;
}

- (NSMutableArray<XwordSquare *> *)getBoard
{
	NSMutableArray<XwordSquare *> *board = [[NSMutableArray<XwordSquare *> alloc] init];

	@try
	{
		NSMutableArray *clues = [[NSMutableArray alloc] init];
		int offset = 52 + (self.height * self.width);
		NSString *solution = [[NSString alloc] initWithBytes:((const char *)[self.data bytes] + 52) length:(self.height * self.width) encoding:NSISOLatin1StringEncoding];
		NSString *squares = [[NSString alloc] initWithBytes:((const char *)[self.data bytes] + offset) length:(self.height * self.width) encoding:NSISOLatin1StringEncoding];

		offset += (self.height * self.width);

		_title = [[NSString alloc] initWithCString:((const char *)[self.data bytes] + offset) encoding:NSISOLatin1StringEncoding];
		_author = [[NSString alloc] initWithCString:((const char *)[self.data bytes] + (offset + _title.length + 1)) encoding:NSISOLatin1StringEncoding];
		_copyright = [[NSString alloc] initWithCString:((const char *)[self.data bytes] + (offset + _title.length + _author.length + 2)) encoding:NSISOLatin1StringEncoding];

		offset += _title.length + _author.length + _copyright.length + 3;

		NSString *temp = [[NSString alloc] initWithCString:((const char *)[self.data bytes] + offset) encoding:NSISOLatin1StringEncoding];
		
		while (([temp length] != 0) && (offset < self.data.length) && (clues.count < self.numclues))
		{
			temp = [[NSString alloc] initWithCString:((const char *)[self.data bytes] + offset) encoding:NSISOLatin1StringEncoding];

			if ([temp length] != 0)
			{
				[clues addObject:temp];
				offset += [clues.lastObject length] + 1;
			}
		}
		
		_notes = [[NSString alloc] initWithCString:((const char *)[self.data bytes] + offset) encoding:NSISOLatin1StringEncoding];
		offset += _notes.length;

		NSString *ltim;
		NSData *gext;
		NSData *grbs;
		//NSData *rtbl;
		//NSData *rusr;

		BOOL flag = false;
		
		while (((offset + 4) < self.data.length) && (!flag))
		{
			NSString *section = [[NSString alloc] initWithData:[[NSData alloc] initWithBytes:((const char *)[self.data bytes] + offset + 1) length:4] encoding:NSISOLatin1StringEncoding];

			if ([section isEqual: @"LTIM"])
			{
				ltim = [[NSString alloc] initWithCString:((const char *)[self.data bytes] + offset + 8) encoding:NSISOLatin1StringEncoding];
				offset += [ltim length] + 9;
			}
			else if ([section isEqual: @"GEXT"])
			{
				gext = [[NSData alloc] initWithBytes:((const char *)[self.data bytes] + offset + 1) length:8 + (self.width * self.height)];
				offset += [gext length] + 1;
			}
			else if ([section isEqual: @"GRBS"])
			{
				grbs = [[NSData alloc] initWithBytes:((const char *)[self.data bytes] + offset + 1) length:8 + (self.width * self.height)];
				offset += [grbs length] + 1;
			}
			//else if ([section  isEqual: @"RTBL"])
			//else if ([section isEqual: @"RUSR"])
			else
				flag = true;
			
			//NSLog(@"%d", offset);
			//NSLog(@"%@", section);
		}

		for (int index = 0, clue = 0, i = 0; i < squares.length; i++)
		{
			XwordSquare *xwordsquare = [[XwordSquare alloc] init];

			xwordsquare.solution = [solution characterAtIndex:i];
			xwordsquare.answer = [squares characterAtIndex:i] != '-' ? [squares characterAtIndex:i] : ' ';

			if (gext != nil)
				xwordsquare.circled = (((const unsigned char *)[gext bytes])[i + 8] == 128);

			if ([squares characterAtIndex:i] != '.')
			{
				xwordsquare.black = false;

				if ((i % self.width == 0) || ([squares characterAtIndex:i - 1] == '.'))
				{
					xwordsquare.across = true;
					
					if (((i + 1) % self.width == 0) || ([squares characterAtIndex:i + 1] == '.'))
						xwordsquare.across = false;
				}

				if ((i < self.width) || ([squares characterAtIndex:i - self.width] == '.'))
				{
					xwordsquare.down = true;
					
					if ((i + self.width > squares.length) || ([squares characterAtIndex:i + self.width] == '.'))
						xwordsquare.down = false;
				}
				
				if (xwordsquare.across || xwordsquare.down)
				{
					xwordsquare.number = ++clue;

					if (xwordsquare.across)
						xwordsquare.acrossclue = [clues objectAtIndex:index++];
					
					if (xwordsquare.down)
						xwordsquare.downclue = [clues objectAtIndex:index++];
				}
			}
			
			[board addObject:xwordsquare];
		}
	}
	@catch (NSException *exception)
	{
		board = nil;
		
		//NSLog(@"getBoard Error: %@ %@", _url, exception.reason);
	}

	return board;
}


@end
