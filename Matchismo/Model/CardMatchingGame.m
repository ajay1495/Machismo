//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/6/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
- (int) getMatchScoreWithCards:(NSMutableArray *)chosenCards withCurCard:(Card *)card;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 6;
static const int COST_TO_CHOOSE = 1;

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self) {
        for(int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];

            if(card)
                [self.cards addObject:card];
            else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (instancetype) init
{
    return nil;
}

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (void)recentlyMatchedCards:(NSMutableArray *)recentlyMatchedCards
{
    
    
}

- (NSMutableArray *) recentlyMatchedCards
{
    if(!_recentlyMatchedCards) _recentlyMatchedCards = [[NSMutableArray alloc] init];
    
    return _recentlyMatchedCards;
}


- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    // Set by default the last score to 0.
    self.lastScore = 0;
    
    // If card isn't already matched, then check to see if it can be matched.
    if(!card.isMatched)
    {
        NSMutableArray *chosenCards = [[NSMutableArray alloc] init]; //of Card
        
        for(Card *otherCard in self.cards)
            if(otherCard.isChosen && !otherCard.isMatched)
                [chosenCards addObject:otherCard];
        
        // Check if we should flip over...
        if(card.isChosen)
        {
            card.chosen = NO;
            self.recentlyMatchedCards = nil;
        }
        // Or choose more cards
        else if([chosenCards count] +1 < self.cardsToMatch) // Add one to count the current chosen card
        {
            card.chosen = YES;
            self.recentlyMatchedCards =  [[NSMutableArray alloc] initWithObjects:card, nil];
        }
        // Or evaluate to see if there's a match
        else
        {
            int matchScore = [self getMatchScoreWithCards:chosenCards withCurCard:card];
            
            // Now either flip them all over OR mark them as matched!
            if(matchScore)
            {
                matchScore *= MATCH_BONUS; // Give user a bonus for matching!
                
                for(Card *otherCard in chosenCards)
                    otherCard.matched = YES;

                card.chosen = YES;
                card.matched = YES;
                self.score += matchScore;
                self.lastScore = matchScore - COST_TO_CHOOSE;
            }
            else
            {
                for(Card *otherCard in chosenCards)
                    otherCard.chosen = NO;

                card.chosen = YES;
                self.score -= MISMATCH_PENALTY;
                self.lastScore = -MISMATCH_PENALTY - COST_TO_CHOOSE;
            }
            
            self.recentlyMatchedCards =  [[NSMutableArray alloc] initWithArray:chosenCards];
            [self.recentlyMatchedCards addObject:card];
        }
        
        // Every flip costs a couple of points
        self.score -= COST_TO_CHOOSE;
    }
}


// Simply gets the match score given the cards chosenCards and the curCard
- (int) getMatchScoreWithCards:(NSMutableArray *)chosenCards withCurCard:(Card *)card
{
    // Need to calculate matchScore for each card, and then add to running total
    int matchScore = 0;

    NSMutableArray *chosenCardsDup = [NSMutableArray arrayWithArray:chosenCards];
    [chosenCardsDup addObject:card]; // Add the curCard as well
    
    // Tries every single permutation of cards.  No duplicate scores will be added by removing after calculating the score.
    while([chosenCardsDup count] > 1)
    {
        Card *curCard = [chosenCardsDup lastObject];
        [chosenCardsDup removeLastObject];
        
        matchScore += [curCard match:chosenCardsDup];
    }
    
    return matchScore;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
