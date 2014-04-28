//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/4/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
