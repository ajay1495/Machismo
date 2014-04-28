//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/4/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// At least 2 of the three cards must match!
// Ex two clubs and a diamond = MATCH!
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    /* Goes through all other cards and adds to score */
    for(id card in otherCards)
    {
        // Use introspection here to ensure otherCard is actually a PlayingCard
        if([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *otherCard = card;
            if([self.suit isEqualToString:otherCard.suit])
                score += 1;
            else if(self.rank == otherCard.rank)
                score += 4;
        }
        // Otherwise, you cannot calculate the match score.
        else
            return 0;
    }
    
    
    return score;
}

- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // to provide setter AND getter

+ (NSArray *) validSuits
{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

- (void) setSuit:(NSString *) suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}


+ (NSArray *) rankStrings
{
    return @[@"?", @"A", @"2", @"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank
{
    return [[self rankStrings] count] -1;
}

- (void) setRank:(NSUInteger) rank
{
    if( rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}


@end
