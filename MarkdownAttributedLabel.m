//
//  MarkdownAttributedLabel.m
//
//  Created by Andrea Cremaschi on 20/03/14.
//  Copyright (c) 2014 midapp. All rights reserved.
//

#import "MarkdownAttributedLabel.h"
#import <XNGMarkdownParser/XNGMarkdownParser.h>
#import <XNGMarkdownParser/XNGMarkdownTokens.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface XNGMarkdownParser ()

- (void)consumeToken:(XNGMarkdownParserCode)token text:(char *)text;

@end

@interface MidaMarkdownParser : XNGMarkdownParser

@end

@interface NSAttributedString (FontSize)

- (NSAttributedString*) attributedStringWithFontSize:(CGFloat) fontSize;

@end

@implementation MarkdownAttributedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInitLocal];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInitLocal];
    }
    return self;
}

- (void)commonInitLocal
{// Initialization code
    self.enabledTextCheckingTypes = 0;
    self.dataDetectorTypes = 0;
    
    NSMutableDictionary *linkAttributes = [self.linkAttributes mutableCopy];
    [linkAttributes removeObjectForKey:NSParagraphStyleAttributeName];
    self.linkAttributes = [linkAttributes copy];
    linkAttributes = [self.activeLinkAttributes mutableCopy];
    [linkAttributes removeObjectForKey:NSParagraphStyleAttributeName];
    self.activeLinkAttributes = [linkAttributes copy];
    linkAttributes = [self.inactiveLinkAttributes mutableCopy];
    [linkAttributes removeObjectForKey:NSParagraphStyleAttributeName];
    self.inactiveLinkAttributes = [linkAttributes copy];
}

- (void)setFont:(UIFont *)font
{
    BOOL sizeMatters = self.font.pointSize != font.pointSize;
    [super setFont:font];
    if (sizeMatters)
    {
        self.attributedText = [self.attributedText attributedStringWithFontSize:font.pointSize];
    }
}

- (NSParagraphStyle *)currentParagraphStyle
{
    TTTAttributedLabel *label = (TTTAttributedLabel*) self;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = label.textAlignment;
    paragraphStyle.lineSpacing = label.lineSpacing;
    paragraphStyle.minimumLineHeight = label.minimumLineHeight > 0 ? label.minimumLineHeight : label.font.lineHeight * label.lineHeightMultiple;
    paragraphStyle.maximumLineHeight = label.maximumLineHeight > 0 ? label.maximumLineHeight : label.font.lineHeight * label.lineHeightMultiple;
    paragraphStyle.lineHeightMultiple = label.lineHeightMultiple;
    paragraphStyle.firstLineHeadIndent = label.firstLineIndent;
    
    return paragraphStyle;
}


-(void)setMarkdownText: (NSString*)markdown {
    NSError *error;
    if (markdown == nil) {
        [self setText:nil];
        return;
    }
    
    XNGMarkdownParser *parser = [[MidaMarkdownParser alloc] init];
    NSAttributedString *attributedString = [parser attributedStringFromMarkdownString:markdown];
    
    
    TTTAttributedLabel *label = (TTTAttributedLabel*) self;
    
    NSParagraphStyle *paragraphStyle = [self currentParagraphStyle];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    [mutableAttributedString addAttributes:@{ NSParagraphStyleAttributeName : paragraphStyle } range:NSMakeRange(0, [mutableAttributedString length])];
    [label setText:[mutableAttributedString attributedStringWithFontSize:self.font.pointSize]];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    // If this is a multiline label, need to make sure
    // preferredMaxLayoutWidth always matches the frame width
    // (i.e. orientation change can mess this up)
    
    if (self.numberOfLines == 0 && bounds.size.width != self.preferredMaxLayoutWidth)
    {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
        [self setNeedsUpdateConstraints];
    }
}

@end

@implementation MidaMarkdownParser

- (void)consumeToken:(XNGMarkdownParserCode)token text:(char *)text
{
    if (token == MARKDOWN_URL)
    {
        token = MARKDOWN_UNKNOWN;
    }
    [super consumeToken:token text:text];
}

@end

@implementation NSAttributedString (FontSize)

- (NSAttributedString*) attributedStringWithFontSize:(CGFloat) fontSize
{
    NSMutableAttributedString* attributedString = [self mutableCopy];
    
    {
        [attributedString beginEditing];
        
        [attributedString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedString.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop)
         {
             
             UIFont* font = value;
             font = [font fontWithSize:fontSize];
             
             [attributedString removeAttribute:NSFontAttributeName range:range];
             [attributedString addAttribute:NSFontAttributeName value:font range:range];
         }];
        
        [attributedString endEditing];
    }
    
    return [attributedString copy];
}

@end