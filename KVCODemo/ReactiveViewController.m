//
//  ReactiveViewController.m
//  KVCODemo
//
//  Created by Susan Elias on 2/8/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import "ReactiveViewController.h"
#import "randomNumberWithKVC.h"


@interface ReactiveViewController ()

// VIEW PROPERTIES
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *randomButtons;

// USER INPUT PROPERTIES
@property (weak, nonatomic) IBOutlet UIButton *regenerateButton;

// MODEL PROPERTIES
@property (nonatomic, strong) randomNumberWithKVC *randomModel;

@end

@implementation ReactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.randomModel = [[randomNumberWithKVC alloc] initWithQuantity:[self.randomButtons count]];
        
    [RACObserve(self, randomModel.KVCnumbers.array) subscribeNext:^(NSMutableArray * x) {
        for (int i = 0; i < [x count]; i++) {
            NSString *newString = [NSString stringWithFormat:@"%d", [[x objectAtIndex:i] intValue]];
            [self.randomButtons[i] setTitle:newString forState:UIControlStateNormal];
        };
    }];
    
}


- (IBAction)handleRegenerateButton:(UIButton *)sender {
    // CHANGE THE MODEL DATA WITH NEW SET OF RANDOM NUMBERS
    NSUInteger arrayMaxCount = [self.randomModel.KVCnumbers countOfArray];
    for (int i = 0; i <  arrayMaxCount; i++) {
        NSNumber *numberToInsert = [NSNumber numberWithInt:[randomNumber generateNewNumber]];
        [self.randomModel.KVCnumbers replaceObjectInArrayAtIndex:i withObject:numberToInsert];
    }


}


@end