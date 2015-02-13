//
//  ViewController.m
//  KVCODemo
//
//  Created by Susan Elias on 2/3/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import "KVOViewController.h"
#import "randomNumberWithKVC.h"

static void * randomValue1Context = (void *)&randomValue1Context;

@interface KVOViewController ()

// VIEW PROPERTIES
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *randomButtons;

// USER INPUT PROPERTIES
@property (weak, nonatomic) IBOutlet UIButton *regenerateButton;

// MODEL PROPERTIES
@property (nonatomic, strong) randomNumberWithKVC *randomModel;

@end

@implementation KVOViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];

    self.randomModel = [[randomNumberWithKVC alloc] initWithQuantity:[self.randomButtons count]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // SET UP KVO
    [self.randomModel addObserver:self
                       forKeyPath:@"KVCnumbers.array"
                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                          context:randomValue1Context];
    
}

-(void)viewWillDisappear:(BOOL)animated
{

    // Remove the observer of the array in randomNumber
    [self.randomModel removeObserver:self forKeyPath:@"KVCnumbers.array"];
    [super viewWillDisappear:animated];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == randomValue1Context) {
        if ([keyPath isEqualToString:@"KVCnumbers.array"])   {
             NSUInteger index = 0;
            for (id newValue in [change valueForKey:NSKeyValueChangeNewKey]) {
                NSIndexSet *indexesToUpdate = [change valueForKeyPath:NSKeyValueChangeIndexesKey];
                NSUInteger indexOfObjectToUpdate;
                if (indexesToUpdate) {
                    indexOfObjectToUpdate = [indexesToUpdate firstIndex];
                }
                else  {
                    indexOfObjectToUpdate = index++;
                }
                if ([newValue respondsToSelector:@selector(intValue)]) {
                    NSString *newString = [NSString stringWithFormat:@"%d", [(NSNumber *)newValue intValue]];
                    [self.randomButtons[indexOfObjectToUpdate] setTitle:newString forState:UIControlStateNormal];
                }
            }
        }
    }
}

- (IBAction)handleRegenerateButton:(UIButton *)sender {
    // CHANGE THE MODEL DATA WITH NEW SET OF RANDOM NUMBERS
    for (int i = 0; i <  [self.randomModel.KVCnumbers countOfArray]; i++) {
        NSNumber *numberToInsert = [NSNumber numberWithInt:[randomNumber generateNewNumber]];
        [self.randomModel.KVCnumbers replaceObjectInArrayAtIndex:i withObject:numberToInsert];
    }

}
@end
