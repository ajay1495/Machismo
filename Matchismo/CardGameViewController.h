//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/4/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// Abstract 
- (Deck *)createDeck;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *) backgroundImageForCard:(Card *) card;
//- (int) numCardsToMatch;

@end
