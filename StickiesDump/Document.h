/* ************************************************************************************************************
This class provides an interface to the ~/Library/StickiesDatabase file as of
OS X v10.3.8, Stickies v4.2, and is the same code used in StYNCies--a neat little utility that synchronizes 
your Stickies to your iPod and/or iDisk. See the "Inside StYNCies" articles on http://www.macdevcenter.com
for more details and example usage.

This class uses an NSAttributedString category addition for transforming RTF to HTML released by
Grayson Hansard and is maintained at http://www.fromconcentratesoftware.com See the attachments
or visit the site for licensing info.


Copyright (C) 2004 Matthew Russell - http://russotle.com/

This program is free software; you can redistribute it and/or modify it under the terms of the 
GNU General Public License as published by the Free Software Foundation; either version 2 of the License, 
or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, 
write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
***********************************************************************************************************/
#import <Cocoa/Cocoa.h>

//window flags
extern int ST_CLOSED;
extern int ST_OPEN;

//window colors	
extern int ST_YELLOW;
extern int ST_BLUE;
extern int ST_GREEN;
extern int ST_PINK;
extern int ST_PURPLE;
extern int ST_GREY;

//versioning
extern int ST_VERSION_4_2;

struct CGPoint_f {
    float x;
    float y;
};
typedef struct CGPoint_f CGPoint_f;
struct CGSize_f {
    float width;
    float height;
};
typedef struct CGSize_f CGSize_f;
struct CGRect_f {
    CGPoint_f origin;
    CGSize_f size;
};
typedef struct CGRect_f CGRect_f;


@interface Document : NSObject <NSCoding>
{
    int mWindowColor;
    int mWindowFlags;
    struct CGRect_f mWindowFrame;
    NSData *mRTFDData;
    NSDate *mCreationDate;
    NSDate *mModificationDate;
}

/**********************************************************
Methods not from class-dump: conveniences
**********************************************************/

//for ease of writing a note when the rtf
//details aren't relevant
- (id)initWithString:(NSString*)s;

//the first "length" characters of the document,
//breaking early if control chars are reached.
- (NSString*)documentTitleOfLength:(int)length;

//just the plain text on the note
- (NSString*)stringValue;

//the rtf text converted to html, with images
-(NSString*)convertToHTMLsavingImagesToPath:(NSString *)imgPath;

/**********************************************************
Methods from the interface generated from class-dump 
**********************************************************/

- (void)scale:(double)arg1;
- (void)setWindowFrame:(struct CGRect_f)arg1;
- (struct CGRect_f)windowFrame;
- (void)setWindowFlags:(int)arg1;
- (int)windowFlags;
- (void)setWindowColor:(int)arg1;
- (int)windowColor;
- (void)setRTFDData:(id)arg1;
- (id)RTFDData;
- (void)setModificationDate:(id)arg1;
- (id)modificationDate;
- (void)setCreationDate:(id)arg1;
- (id)creationDate;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithData:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (void)dealloc;
- (id)init;

@end
