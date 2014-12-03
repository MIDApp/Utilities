//
//  MarkdownAttributedLabel.m
//
//  Created by Andrea Cremaschi on 20/03/14.
//  Copyright (c) 2014 midapp. All rights reserved.
//

#import "MarkdownAttributedLabel.h"
#import <XNGMarkdownParser/XNGMarkdownParser.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@implementation MarkdownAttributedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.dataDetectorTypes = 0;
    }
    return self;
}

-(void)setMarkdownText: (NSString*)markdown {
    NSError *error;
    if (markdown == nil) {
        [self setText:nil];
        return;
    }
    
    XNGMarkdownParser *parser = [[XNGMarkdownParser alloc] init];
    NSAttributedString *attributedString = [parser attributedStringFromMarkdownString:markdown];
    
    TTTAttributedLabel *attributedLabel = (TTTAttributedLabel*) self;
    [attributedLabel setText:attributedString];
        
}


@end