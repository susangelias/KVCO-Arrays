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
@property (nonatomic, strong) NSMutableArray *changeableButtons;
@property (nonatomic, strong) NSMutableArray *fixedButtons;

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
 
    // Buttons in the top view can change their value
    // buttons in the bottom view can't - so sort them initially by
    // where they are in the view
    
    for (UIButton *button in self.randomButtons) {
        if ([button.superview isEqual: self.topView]) {
            [self.changeableButtons addObject:button];
        }
        else {
            [self.fixedButtons addObject:button];
        }
    }
    
}


- (IBAction)handleRegenerateButton:(UIButton *)sender {
    // CHANGE THE MODEL DATA WITH NEW SET OF RANDOM NUMBERS
    NSUInteger arrayMaxCount = [self.randomModel.KVCnumbers countOfArray];
    for (int i = 0; i <  arrayMaxCount; i++) {
        NSNumber *numberToInsert = [NSNumber numberWithInt:[randomNumber generateNewNumber]];
        [self.randomModel.KVCnumbers replaceObjectInArrayAtIndex:i withObject:numberToInsert];
    }


}

-(NSMutableArray *)fixedButtons
{
    if (!_fixedButtons) {
        self.fixedButtons = [[NSMutableArray alloc] init];
    }
    return _fixedButtons;
}

-(NSMutableArray *)changeableButtons
{
    if (!_changeableButtons) {
        self.changeableButtons = [[NSMutableArray alloc] init];
    }
    return _changeableButtons;
}
@end


