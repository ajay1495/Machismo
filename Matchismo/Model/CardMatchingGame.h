//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/6/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// Designated initializer 
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) NSInteger score;
@property(nonatomic) int cardsToMatch;

/* Scoring explanation is in the model and stores the status of the last card that was chosen.  The controller will fetch this data for the UI to display when it requires it.  */
@property(nonatomic, strong) NSMutableArray *recentlyMatchedCards; // of Card
@property(nonatomic) int lastScore;

@end
