//
//  AppDelegate.m
//  StickiesDump
//
//  Created by John Thywissen on 2016/05/31.
//  Copyright © 2016 John Thywissen. All rights reserved.
//

#import "AppDelegate.h"
#import "Document.h"
#import "NSAttributedString+FCSAdditions.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString * path1 = [@"~/Desktop/cocoa/" stringByExpandingTildeInPath];
    NSString * path2 = [@"~/Desktop/our/" stringByExpandingTildeInPath];

    NSDateFormatter *internetDateFormatter = [[NSDateFormatter alloc] init];
    internetDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
    internetDateFormatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";

    NSLog(@"Loading");
    //load the stickies
    NSMutableArray *array =
    [[NSMutableArray alloc] initWithArray:
     [NSUnarchiver unarchiveObjectWithFile:
      [@"~/Desktop/StickiesDatabase"
       stringByExpandingTildeInPath]]];
    
    NSLog(@"Writing");
    //write each sticky to the path using its title
    NSEnumerator *enumerator = [array objectEnumerator];
    Document *d;
    while (d = [enumerator nextObject]) {
        NSString * title = [d documentTitleOfLength:255];
        long imapInternalDate = [d.creationDate timeIntervalSince1970];
        NSString * filename = [NSString stringWithFormat: @"%ld", imapInternalDate];
        
        NSLog(@"Writing %@: %@", filename, title);
        NSDictionary *docAttributes;
        NSAttributedString *attrString = [[NSAttributedString alloc]
                                           initWithRTFD: d.RTFDData documentAttributes: &docAttributes];

        NSString * header = [NSString stringWithFormat:@"From: john@thywissen.org\nX-Uniform-Type-Identifier: com.apple.mail-note\nContent-Type: text/html; charset=utf-8\nContent-Transfer-Encoding: binary\nMime-Version: 1.0 (StickiesDump)\nDate: %@\nX-Mail-Created-Date: %@\nSubject: %@\nX-Universally-Unique-Identifier: %@\n\n", [internetDateFormatter stringFromDate:d.modificationDate], [internetDateFormatter stringFromDate:d.creationDate], title, [[NSUUID UUID] UUIDString]];

        // Cocoa HTML Writer
        NSData * htmlData1 = [attrString dataFromRange: NSMakeRange(0, [attrString length]) documentAttributes: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} error: NULL];
        NSString * htmlString1 = [[NSString alloc] initWithData:htmlData1 encoding:NSUTF8StringEncoding];
        NSString * fileContent1 = [[header stringByAppendingString:htmlString1] stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n"];
        [fileContent1 writeToFile:[path1 stringByAppendingPathComponent: filename] atomically: NO encoding: NSUTF8StringEncoding error:NULL];

        // Our HTML Converter
        NSString *htmlString2 = [attrString convertToHTMLWithTitle:title];
        NSString * fileContent2 = [[header stringByAppendingString:htmlString2] stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n"];
        [fileContent2 writeToFile:[path2 stringByAppendingPathComponent: filename] atomically: NO encoding: NSUTF8StringEncoding error:NULL];
    }

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
