#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#import "Xword.h"
#import "XwordSquare.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
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
			
			NSMutableString *html = [[NSMutableString alloc] init];

			NSString *path = [[NSBundle bundleForClass:[Xword class]] pathForResource:@"xword" ofType:@"css"];
			NSString *css = [[NSString alloc] initWithContentsOfFile:path encoding:NSISOLatin1StringEncoding error:NULL];

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
				//NSLog(@"url, magic, width, height, # of clues, # of xword squares, scrambled: %@, %@, %d, %d, %d, %d, %d", [QL_url absoluteString], xword.magic, xword.width, xword.height, xword.numclues, xword.board.count, xword.scrambled);
				//NSLog(@"%@", xword.title);
				//NSLog(@"%@", xword.author);
				//NSLog(@"%@", xword.copyright);
				//NSLog(@"%@", xword.notes);
				
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

					[html appendString:@"<style id='style1'>\r\n"];
					[html appendString:@".hidesolution { display: none; }\r\n"];
					[html appendString:@"</style>\r\n"];
					
					[html appendString:@"</head>\r\n"];
			
					[html appendString:@"<body>\r\n"];
					
					[html appendString:@"<div id=\"header\">\r\n"];
					[html appendFormat:@"<p id=\"title\">%@</p>\r\n", xword.title];
					[html appendString:@"<p id=\"copyright\"></p>\r\n"];
					[html appendFormat:@"<p id=\"author\">%@</p>\r\n", xword.author];
					[html appendString:@"<hr>\r\n"];
					[html appendString:@"</div>\r\n"];

					[html appendString:@"<div id=\"puzzle\">\r\n"];
					
					[html appendString:@"<div id=\"section1\">\r\n"];

					if ([xword.notes length] != 0)
						[html appendFormat:@"<div id=\"notes\">%@</div>\r\n", xword.notes];

					[html appendString:@"<div class=\"clues\">\r\n"];
					[html appendString:@"<div class=\"cluesheader\">ACROSS</div>\r\n"];
					[html appendString:@"<table>\r\n"];

					for (int i = 0; i < xword.width * xword.height; i++)
						if ([xword.board objectAtIndex:i].across)
							[html appendFormat:@"<tr><td class=\"cluenumber\">%@</td><td class=\"clue\">%@</td></tr>\r\n",
								([xword.board objectAtIndex:i].across) ? [NSString stringWithFormat:@"%d", [xword.board objectAtIndex:i].number] : @"",
									[xword.board objectAtIndex:i].acrossclue];
					
					[html appendString:@"</table>\r\n"];

					[html appendString:@"<div class=\"cluesheader\">DOWN</div>\r\n"];
					[html appendString:@"<table>\r\n"];

					for (int i = 0; i < 15; i++)
						if ([xword.board objectAtIndex:i].down)
							[html appendFormat:@"<tr><td class=\"cluenumber\">%@</td><td class=\"clue\">%@</td></tr>\r\n",
								([xword.board objectAtIndex:i].down) ? [NSString stringWithFormat:@"%d", [xword.board objectAtIndex:i].number] : @"",
									[xword.board objectAtIndex:i].downclue];
					
					[html appendString:@"</table>\r\n"];

					[html appendString:@"</div>\r\n"];
					[html appendString:@"</div>\r\n"];

					[html appendString:@"<div id=\"section2\">\r\n"];
					[html appendString:@"<div id=\"board\">\r\n"];
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
								[html appendFormat:@"<td><div class=\"%@\"><span class=\"number\">%@</span><span class=\"answers hideanswers\">%@</span><span class=\"solution hidesolution\">%@</span></div></td>\r\n",
									([xword.board objectAtIndex:index].circled) ? @"circle" : @"",
									([xword.board objectAtIndex:index].number != 0) ? [NSString stringWithFormat:@"%d", [xword.board objectAtIndex:index].number] : @"",
									[NSString stringWithFormat:@"%c", [xword.board objectAtIndex:index].answer],
									[NSString stringWithFormat:@"%c", [xword.board objectAtIndex:index].solution]];
						}

						[html appendString:@"</tr>\r\n"];
					}
					
					[html appendString:@"</table>\r\n"];

					[html appendString:@"<div id=\"input\">\r\n"];
					[html appendString:@"<input type=\"radio\" name=\"values\" onclick=\"var s = document.getElementById('style1'); if (s != null) s.parentNode.removeChild(s); s = document.createElement('style'); s.id = 'style1'; s.innerHTML = '.hideanswers { display: none; }'; document.body.appendChild(s);\">solution"];
					[html appendString:@"<input type=\"radio\" name=\"values\" checked=\"checked\" onclick=\"var s = document.getElementById('style1'); if (s != null) s.parentNode.removeChild(s); s = document.createElement('style'); s.id = 'style1'; s.innerHTML = '.hidesolution { display: none; }'; document.body.appendChild(s);\">answers"];
					[html appendString:@"</div>\r\n"];

					[html appendString:@"</div>\r\n"];
					[html appendString:@"</div>\r\n"];

					[html appendString:@"<div id=\"section3\">\r\n"];
					[html appendString:@"<div class=\"clues\">\r\n"];

					[html appendString:@"<table>\r\n"];

					for (int i = 15; i < xword.width * xword.height; i++)
						if ([xword.board objectAtIndex:i].down)
							[html appendFormat:@"<tr><td class=\"cluenumber\">%@</td><td class=\"clue\">%@</td></tr>\r\n",
								([xword.board objectAtIndex:i].down) ? [NSString stringWithFormat:@"%d", [xword.board objectAtIndex:i].number] : @"",
									[xword.board objectAtIndex:i].downclue];
					
					[html appendString:@"</table>\r\n"];

					[html appendString:@"</div>\r\n"];
					[html appendString:@"</div>\r\n"];

					[html appendString:@"</div>\r\n"];
					[html appendString:@"</div>\r\n"];
					[html appendString:@"</div>\r\n"];

					[html appendString:@"</body>\r\n"];
					[html appendString:@"</html>\r\n"];
					
					//[html writeToFile:@"/Users/Diane/Documents/Xcode/QuickLookTest/xword_debug.html" atomically:false encoding:NSISOLatin1StringEncoding error:nil];
				}
				@catch (NSException *exception)
				{
					//NSLog(@"%@", exception.reason);
					return noErr;
				}
			}
		
			CFDictionaryRef properties = (__bridge CFDictionaryRef)@{};
			QLPreviewRequestSetDataRepresentation(preview, (__bridge CFDataRef)[html dataUsingEncoding:NSISOLatin1StringEncoding], kUTTypeHTML, properties);
		}
	}
	
	return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
