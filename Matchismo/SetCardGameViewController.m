//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/20/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *) createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSAttributedString *) titleForCard:(Card *) card
{
    if([card isKindOfClass:[SetCard class]])
    {
        SetCard *setCard = (SetCard *) card;
        
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]  initWithString:setCard.symbol attributes:nil];
        
        for(NSInteger i=0; i<setCard.number-1; i++)
        {
            NSAttributedString *charsToAdd = [[NSAttributedString alloc]
                                              initWithString:[NSString stringWithFormat:@"%@", setCard.symbol]
                                              ];
            
            [contents appendAttributedString:charsToAdd];
        }
        
        NSRange range = NSMakeRange(0, [contents length]);
        
        // Now adjust for shading and color
        CGFloat alpha = 1;
        CGFloat red, blue, green;
        
        if([setCard.color isEqualToString:@"red"])
        {
            red = 1;
            blue = 0;
            green = 0;
        }
        else if([setCard.color isEqualToString:@"purple"])
        {
            red = 0;
            blue = 1;
            green = 0;
        }
        else if([setCard.color isEqualToString:@"green"])
        {
            red = 0;
            blue = 0;
            green = 1;
        }
        
        if([setCard.shading isEqualToString:@"open"])
            alpha = 0.3;
        else if([setCard.shading isEqualToString:@"striped"])
            [contents addAttribute:NSStrokeWidthAttributeName value:@5 range:range];
        
        [contents addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]
                         range:range];
        
        return contents;
    }
    
    return nil;
}

- (UIImage *) backgroundImageForCard:(Card *) card
{
    return [UIImage imageNamed: card.isChosen? @"cardfront" : @"setCardNotSelected"];
}

- (int) numCardsToMatch
{
    return 3;
}

@end
