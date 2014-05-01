//
//  Card.h
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/4/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

////asdfa sdf asdfa sdfa sdfas dfasd

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) match:(NSArray *) otherCards;

@end
