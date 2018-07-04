//
//  MarkdownAttributedLabel.h
//
//  Created by Andrea Cremaschi on 20/03/14.
//  Copyright (c) 2014 midapp. All rights reserved.
//

#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface MarkdownAttributedLabel : TTTAttributedLabel

- (void)setMarkdownText: (NSString*)markdown;

@end

@interface NSAttributedString (FontSize)

- (NSAttributedString*) attributedStringWithFontSize:(CGFloat) fontSize;

@end
