//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Ajay Sohmshetty on 4/23/14.
//  Copyright (c) 2014 Ajay Sohmshetty. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyText;
@property (strong, nonatomic) NSArray *history;
@end

@implementation HistoryViewController

- (void) setArray:(NSArray *)array
{
    self.history = [[NSArray alloc] initWithArray:array];
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    [self updateUI];
}

- (void) updateUI
{
    NSMutableAttributedString *table = [[NSMutableAttributedString alloc] init];
        
    for(int i=0; i<[self.history count]; i++)
    {
        [table appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d. ", i+1]
                                                                      attributes:nil]];
        [table appendAttributedString:self.history[i]];
        [table appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    NSRange range = NSMakeRange(0, [table length]);
    [table addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:range];

    self.historyText.attributedText = table;
}

@end
