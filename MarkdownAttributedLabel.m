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

    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF16StringEncoding]
                                                                            options:options
                                                                 documentAttributes:nil
                                                                              error:&error];
    
    TTTAttributedLabel *attributedLabel = (TTTAttributedLabel*) self;
    [attributedLabel setText:attributedString afterInheritingLabelAttributesAndConfiguringWithBlock:nil];
        
}

@end
