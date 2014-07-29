//
//  MarkdownAttributedLabel.m
//
//  Created by Andrea Cremaschi on 20/03/14.
//  Copyright (c) 2014 midapp. All rights reserved.
//

#import "MarkdownAttributedLabel.h"
#import <MMMarkDown/MMMarkdown.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@implementation MarkdownAttributedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setMarkdownText: (NSString*)markdown {
    NSError *error;
    if (markdown == nil) {
        [self setText:nil];
        return;
    }
    
    NSString *html = [MMMarkdown HTMLStringWithMarkdown:markdown error:nil];

    NSString *fontName = self.font.fontName;
    NSString *fontSize = [[NSNumber numberWithFloat:self.font.pointSize] stringValue];
    NSString *lineHeight = [[NSNumber numberWithFloat:self.font.pointSize * self.lineHeightMultiple] stringValue];
    NSString *textAlignment;
    switch (self.textAlignment) {
        case NSTextAlignmentCenter: textAlignment = @"center"; break;
        case NSTextAlignmentLeft: textAlignment = @"left"; break;
        case NSTextAlignmentRight: textAlignment = @"right"; break;
        case NSTextAlignmentJustified: textAlignment = @"justify"; break;
        default: textAlignment = @"left";break;
    };
    
    NSString *fontFamilyName = [self.font.familyName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *strongFontSuffixes = @[@"Bold", @"-Bold", @"Medium", @"-Medium"];
    NSMutableArray *mArray = [NSMutableArray array];
    [mArray addObject: [NSString stringWithFormat:@"\"%@ Bold\"", fontFamilyName]];
    [mArray addObject: [NSString stringWithFormat:@"\"%@ Medium\"", fontFamilyName]];
    for (NSString *suffix in strongFontSuffixes) {
        [mArray addObject: [NSString stringWithFormat:@"%@%@", fontFamilyName, suffix]];
    }
    NSString *strongFontNames = [mArray componentsJoinedByString:@","];
    
    html = [NSString stringWithFormat:@"<head><style> p {font-family:%@;font-size:%@px;line-height:%@px;text-%@} strong {font-family:%@}</style></head><body>%@</body>", fontName, fontSize, lineHeight, textAlignment, strongFontNames, html];
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF16StringEncoding]
                                                                            options:options
                                                                 documentAttributes:nil
                                                                              error:&error];
    
    TTTAttributedLabel *attributedLabel = (TTTAttributedLabel*) self;
    [attributedLabel setText:attributedString];
        
}


@end
