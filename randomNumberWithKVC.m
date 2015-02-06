//
//  randomNumberWithKVC.m
//  KVCODemo
//
//  Created by Susan Elias on 2/6/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import "randomNumberWithKVC.h"

@implementation randomNumberWithKVC



-(randomNumber *)initWithQuantity:(NSUInteger)quantity
{
    self = [super init];
    if (self) {
        for (int i = 0; i < quantity; i++) {
            NSNumber *random = [NSNumber numberWithInt:[randomNumber generateNewNumber]];
            // add object to list of numbers
            [self.KVCnumbers insertObject:random inArrayAtIndex:i];
        }
        
    }
    return self;
    
}


-(KVCMutableArray *)KVCnumbers
{
    if (!_KVCnumbers) {
        self.KVCnumbers = [[KVCMutableArray alloc] init];
    }
    return _KVCnumbers;
}

@end
