//
//  SetCard.h
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/20/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

+ (NSArray *) validSymbols;
+ (NSArray *) validShadings;
+ (NSArray *) validColors;
+ (int) maxNumber;


@end
