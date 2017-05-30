#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#include <WebKit/WebKit.h>

#import "Xword.h"
#import "XwordSquare.h"

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize);
void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

/* -----------------------------------------------------------------------------
    Generate a thumbnail for file

   This function's job is to create thumbnail for designated file as fast as possible
   ----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
	NSURL *QL_url = (__bridge NSURL *)url;

	@autoreleasepool
	{
		Xword* xword;
		NSData *filedata = nil;

		filedata = [NSData dataWithContentsOfURL:QL_url];

		if (filedata != nil)
		{
			xword = [[Xword alloc] init];
			xword.url = [QL_url absoluteString];
			xword.data = filedata;
			
			NSString *path = [[NSBundle bundleForClass:[Xword class]] pathForResource:@"xword" ofType:@"css"];
			NSString *css = [[NSString alloc] initWithContentsOfFile:path encoding:NSISOLatin1StringEncoding error:NULL];
				
			NSMutableString *html = [[NSMutableString alloc] init];

			if ((![xword.magic isEqualToString:@"ACROSS&DOWN"]) || (xword.board == nil))
			{
				@try
				{
					[html appendString:@"<!DOCTYPE html>\r\n"];
					[html appendString:@"<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">\r\n"];
					[html appendString:@"<head>\r\n"];
					[html appendString:@"<meta charset=\"ISO-8859-1\">\r\n"];
				
					[html appendString:@"<style>\r\n"];
					[html appendString:css];
					[html appendString:@"</style>\r\n"];

					[html appendString:@"</head>\r\n"];
					[html appendString:@"<body>\r\n"];

					[html appendString:@"<div id=\"error\"><div id=\"nosymbol\"><div class=\"circle\">\r\n"];
					[html appendString:@"<table id=\"boarderror\" class=\"board\">\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td class=\"black\"></td><td class=\"black\"></td><td class=\"black\"></td><td></td><td></td><td></td><td class=\"black\"></td><td class=\"black\"></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td class=\"black\"></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td class=\"black\"></td><td class=\"black\"></td><td></td><td></td><td></td><td class=\"black\"></td><td class=\"black\"></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td class=\"black\"></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td class=\"black\"></td><td class=\"black\"></td><td></td><td></td><td></td><td class=\"black\"></td><td class=\"black\"></td><td class=\"black\"></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"<tr><td></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td><td class=\"black\"></td><td></td><td></td><td></td><td></td></tr>\r\n"];
					[html appendString:@"</table>\r\n"];
					[html appendString:@"<div class=\"slash\"></div></div><div>Not a valid puz file</div></div></div>\r\n"];

					[html appendString:@"</body>\r\n"];
					[html appendString:@"</html>\r\n"];
				}
				@catch (NSException *exception)
				{
					//NSLog(@"%@", exception.reason);
					return noErr;
				}
			}
			else
			{
				//NSLog(@"magic, width, height, number of clues, scrambled: %@, %d, %d, %d, %d", xword.magic, xword.width, xword.height, xword.numclues, xword.scrambled);
				//NSLog(@"%@", xword.title);
				//NSLog(@"%@", xword.author);
				//NSLog(@"%@", xword.copyright);
				//NSLog(@"%f, %f", maxSize.width, maxSize.height);

				@try
				{
					[html appendString:@"<!DOCTYPE html>\r\n"];
					[html appendString:@"<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">\r\n"];
					[html appendString:@"<head>\r\n"];
					[html appendString:@"<meta charset=\"ISO-8859-1\">\r\n"];
					[html appendFormat:@"<title>%@</title>\r\n", xword.title];
					
					[html appendString:@"<style>\r\n"];
					[html appendString:css];
					[html appendString:@"</style>\r\n"];
					
					[html appendString:@"</head>\r\n"];
					[html appendString:@"<body>\r\n"];
					
					[html appendString:@"<div>\r\n"];
					[html appendFormat:@"<table class=\"board board%@\">\r\n", [NSString stringWithFormat:@"%d", xword.width]];
					
					for (int i = 0; i < xword.height; i++)
					{
						[html appendString:@"<tr>\r\n"];
					
						for (int j = 0; j < xword.width; j++)
						{
							int index = xword.width * i + j;
							
							if ([xword.board objectAtIndex:index].black)
								[html appendString:@"<td class=\"black\"></td>\r\n"];
							else
								[html appendFormat:@"<td><div class=\"%@\"><span class=\"number\">%@</span><span class=\"answers\">%@</span></div></td>\r\n",
									([xword.board objectAtIndex:index].circled) ? @"circle" : @"",
									([xword.board objectAtIndex:index].number != 0) ? [NSString stringWithFormat:@"%d", [xword.board objectAtIndex:index].number] : @"",
										[NSString stringWithFormat:@"%c", [xword.board objectAtIndex:index].answer]];
						}

						[html appendString:@"</tr>\r\n"];
					}
					
					[html appendString:@"</table>\r\n"];
					[html appendString:@"</div>\r\n"];

					[html appendString:@"</body>\r\n"];
					[html appendString:@"</html>\r\n"];
				}
				@catch (NSException *exception)
				{
					//NSLog(@"%@", exception.reason);
					return noErr;
				}
			}

			
			@try
			{
				NSData *_data = [html dataUsingEncoding:NSISOLatin1StringEncoding];
				float width, height;
				
				switch (xword.width)
				{
					case 21:
						width = 401.0;
						height = 401.0;
						break;
						
					case 22:
						width = 398.0;
						height = 359.0;
						break;
						
					case 31:
						width = 400.0;
						height = 290.0;
						break;
						
					default:
						width = 407.0;
						height = 407.0;
						break;
				}
				
				WebView *_webView = [[WebView alloc] initWithFrame:NSMakeRect(0.0, 0.0, width, height)];
				[_webView scaleUnitSquareToSize:NSMakeSize(height / width, 1.0)];
				[_webView.mainFrame.frameView setAllowsScrolling:NO];
				[_webView.mainFrame loadData:_data MIMEType:@"text/html" textEncodingName:@"NSISOLatin1StringEncoding" baseURL:nil];
        
				while([_webView isLoading]) CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true);
				[_webView display];

				CGContextRef _context = QLThumbnailRequestCreateContext(thumbnail, NSSizeToCGSize((CGSize) { width, height }), false, NULL);

				if (_context)
				{
					NSGraphicsContext* _graphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:(void *)_context flipped:_webView.isFlipped];
					[_webView displayRectIgnoringOpacity:_webView.bounds inContext:_graphicsContext];
					QLThumbnailRequestFlushContext(thumbnail, _context);
					CFRelease(_context);
				}
			}
			@catch (NSException *exception)
			{
				//NSLog(@"%@", exception.reason);
			}
		}
	}
	
	return noErr;
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Implement only if supported
}
