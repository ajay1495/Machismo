//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/4/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (nonatomic, strong) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoringExplanationLabel;
@property (nonatomic) BOOL gameHasStarted;
@property (strong, nonatomic) NSMutableArray *history;
@end

@implementation CardGameViewController


/*****  Lazy instantiate our card matching game model  *****/

- (CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[self createDeck]];
    }
    
    return _game;
}

- (Deck *)createDeck
{
    return nil;
    //return [[PlayingCardDeck alloc] init];
}

- (void)setGameHasStarted:(BOOL)gameHasStarted
{
    _gameHasStarted = gameHasStarted;
}

- (NSMutableArray *)history
{
    if(!_history) _history = [[NSMutableArray alloc] init];
    
    return _history;
}


/*****  Event handlers here  *****/

- (IBAction)touchCardButton:(UIButton *)sender
{
    // Game is starting... so set the settings
    if(!self.gameHasStarted)
    {
        
        self.game.cardsToMatch = [self numCardsToMatch];
        
        self.gameHasStarted = YES;
    }
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)resetGameButton:(UIButton *)sender
{
    self.game = nil;
    self.history = nil;
    self.gameHasStarted = NO;
    
    [self updateUI];
}

/*****  UI updating methods (and helpers) follow  *****/

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setAttributedTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self setExplanationLabelInUI];
}


- (void) setExplanationLabelInUI
{
    // Given self.game.lastChosenCards, and the fact that we can get the titles for all the cards, simply build an attributed string
    
    //Check to see if anything was chosen in the first place
    if([self.game.recentlyMatchedCards count] == 0)
    {
        self.scoringExplanationLabel.attributedText = nil;
        return;
    }
    
    // Get everything
    NSMutableAttributedString *explanation = [[NSMutableAttributedString alloc] initWithString:@"You chose "];
    
    for(id card in self.game.recentlyMatchedCards)
    {
        // Use introspection here to ensure otherCard is actually a PlayingCard
        if([card isKindOfClass:[Card class]])
        {
            [explanation appendAttributedString:[self titleForCard:card]];
        }
    }
    
    // If there's a score, then add the score!
    if(self.game.lastScore != 0)
    {
        [explanation appendAttributedString:[[NSAttributedString alloc] initWithString:
                                             [NSString stringWithFormat:@" for %d points", self.game.lastScore]
                                             ]];
    }
    
    self.scoringExplanationLabel.attributedText = explanation;
    
    [self.history addObject:explanation];
    
    return;
}

// Prepare for segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toHistory"])
    {
        HistoryViewController *hvc = [segue destinationViewController];
        [hvc setArray:self.history];
    }
}

// Abstract methods follow:
// MUST BE IMPLEMENTED BY SUBCLASSES
- (NSAttributedString *)titleForCard:(Card *)card
{
    return nil;
}


- (UIImage *) backgroundImageForCard:(Card *) card
{
    return [UIImage imageNamed: card.isChosen? @"cardfront" : @"cardback"];
}

- (int) numCardsToMatch
{
    return 0;
}

@end
