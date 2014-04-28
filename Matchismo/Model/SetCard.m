//
//  SetCard.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/20/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // For each attribute check to see if there is either all are same, or all are different

    // Must have 3 cards total.
    if([otherCards count] != 2)
        return 0;
    
    SetCard *secondCard = otherCards[0];
    SetCard *thirdCard = otherCards[1];
    
    // All must be same
    if(self.number == secondCard.number)
    {
        if(self.number != thirdCard.number)
            return 0;
        else
            score+=2;
    }
    // All must be different
    else
    {
        if(self.number == thirdCard.number || secondCard.number == thirdCard.number)
            return 0;
        else
            score++;
    }
    
    
    
    // Now for symbol 
    // All must be same
    if([self.symbol isEqualToString:secondCard.symbol])
    {
        if([self.symbol isEqualToString:thirdCard.symbol])
            score+=2;
        else
            return 0;
        
    }
    // All must be different
    else
    {
        if([self.symbol isEqualToString: thirdCard.symbol] ||
           [secondCard.symbol isEqualToString:thirdCard.symbol])
            return 0;
        else
            score++;
    }

    // For shading //
    // All must be same
    if([self.shading isEqualToString:secondCard.shading])
    {
        if([self.shading isEqualToString:thirdCard.shading])
            score+=2;
        else
            return 0;
        
    }
    // All must be different
    else
    {
        if([self.shading isEqualToString: thirdCard.shading] ||
           [secondCard.shading isEqualToString:thirdCard.shading])
            return 0;
        else
            score++;
    }
    
    /// For color ///
    // All must be same
    if([self.color isEqualToString:secondCard.color])
    {
        if([self.color isEqualToString:thirdCard.color])
            score+=2;
        else
            return 0;
        
    }
    // All must be different
    else
    {
        if([self.color isEqualToString: thirdCard.color] ||
           [secondCard.color isEqualToString:thirdCard.color])
            return 0;
        else
            score++;
    }
    
    return score;
}

- (NSString *) contents
{
    return nil;
}

/******** Begin class methods here ********/

const int highestNumber = 3;
+ (int) maxNumber
{
    return highestNumber;
}

+ (NSArray *) validSymbols
{
    return @[@"▲", @"⚫︎", @"■"];
}

+ (NSArray *) validShadings
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *) validColors
{
    return @[@"red", @"green", @"purple"];
}

@end
