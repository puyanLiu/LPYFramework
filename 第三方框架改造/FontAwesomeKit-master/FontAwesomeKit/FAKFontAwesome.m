#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FAKFontAwesome.h"

@implementation FAKFontAwesome

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
#ifndef DISABLE_FONTAWESOME_AUTO_REGISTRATION
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [self registerIconFontWithURL:[[NSBundle bundleForClass:[FAKFontAwesome class]] URLForResource:@"FontAwesome" withExtension:@"otf"]];
         [self registerIconFontWithURL:[[NSBundle bundleForClass:[FAKFontAwesome class]] URLForResource:@"Queqianme" withExtension:@"ttf"]];
    });
#endif
    
//    UIFont *font = [UIFont fontWithName:@"FontAwesome" size:size];
     UIFont *font = [UIFont fontWithName:@"Queqianme" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

+ (instancetype)fivehundredpxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\ue901" size:size]; }

+ (NSDictionary *)allIcons {
    return @{
              @"address" : @"\ue901",
             };
}

@end
