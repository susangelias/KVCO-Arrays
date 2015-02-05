//
//  ViewController.m
//  KVCODemo
//
//  Created by Susan Elias on 2/3/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import "ViewController.h"
#import "randomNumber.h"

static void * randomValue1Context = (void *)&randomValue1Context;

@interface ViewController ()

// VIEW PROPERTIES
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *randomButtons;
@property (nonatomic, strong) NSMutableArray *changeableButtons;
@property (nonatomic, strong) NSMutableArray *fixedButtons;

// USER INPUT PROPERTIES
@property (weak, nonatomic) IBOutlet UIButton *regenerateButton;

// MODEL PROPERTIES
@property (nonatomic, strong) randomNumber *randomModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.randomModel = [[randomNumber alloc] initWithQuantity:[self.randomButtons count]];
   
    // SET UP KVO
    [self.randomModel addObserver:self
                       forKeyPath:@"numbers.array"
                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                          context:randomValue1Context];

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

-(void)viewWillDisappear:(BOOL)animated
{

    // Remove the observer of the array in randomNumber
    [self.randomModel removeObserver:self forKeyPath:@"numbers.array"];
    [super viewWillDisappear:animated];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == randomValue1Context) {
        int kind = [[change valueForKey:NSKeyValueChangeKindKey] intValue];
        if (([keyPath isEqualToString:@"numbers.array"]) && (kind == 2) ) {
            NSUInteger indexToUpdate = [[change valueForKey:NSKeyValueChangeIndexesKey] firstIndex];
            id newValue = [[change valueForKey:NSKeyValueChangeNewKey] firstObject];
            if ([newValue respondsToSelector:@selector(intValue)]) {
                NSString *newString = [NSString stringWithFormat:@"%d", [(NSNumber *)newValue intValue]];
                [self.randomButtons[indexToUpdate] setTitle:newString forState:UIControlStateNormal];
            }

        }
    }
}

- (IBAction)handleRegenerateButton:(UIButton *)sender {
    // CHANGE THE MODEL DATA AT RANDOM
    for (int i = 0; i <  [self.randomModel.numbers countOfArray]; i++) {
        [self.randomModel.numbers removeObjectFromArrayAtIndex:i];
        NSNumber *numberToInsert = [NSNumber numberWithInt:[randomNumber generateNewNumber]];
        [self.randomModel.numbers insertObject:numberToInsert inArrayAtIndex:i];
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
