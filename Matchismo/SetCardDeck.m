//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/20/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        for (int number = 1; number <= [SetCard maxNumber]; number++)
        {
            for (NSString *symbol in [SetCard validSymbols])
            {
                for (NSString *shading in [SetCard validShadings])
                {
                    for (NSString *color in [SetCard validColors])
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        
                        [self addCard:card];
                        
                        NSLog(@"Contents: %@", card.contents);
                    }
                }
            }
        }
    }
    
    return self;
}

@end
