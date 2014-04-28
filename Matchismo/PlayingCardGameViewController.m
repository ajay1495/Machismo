//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/10/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *) titleForCard:(Card *) card
{
    if([card isKindOfClass:[PlayingCard class]])
    {
        NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]  initWithString:card.contents attributes:nil];
        UIColor *fontColor = [UIColor blackColor];
        
        if([card.contents hasSuffix:@"♥︎"] || [card.contents hasSuffix:@"♦︎"])
            fontColor = [UIColor redColor];
        
        [contents addAttribute:NSForegroundColorAttributeName
                         value:fontColor
                         range:NSMakeRange(0, [contents length])];
        
        return card.isChosen ? contents : [[NSAttributedString alloc]  initWithString:@"" attributes:nil];
    }
    
    return nil;
}

- (int) numCardsToMatch
{
    return 2;
}


@end
