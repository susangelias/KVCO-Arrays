//
//  randomNumbers.m
//  KVCODemo
//
//  Created by Susan Elias on 2/4/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import "randomNumber.h"


@implementation randomNumber

-(randomNumber *)initWithQuantity:(NSUInteger)quantity
{
    self = [super init];
    if (self) {
        for (int i = 0; i < quantity; i++) {
            NSNumber *random = [NSNumber numberWithInt:[randomNumber generateNewNumber]];
            // add object to list of numbers
            [self.numbers insertObject:random inArrayAtIndex:i];
        }
  
    }
    return self;

}


-(KVCMutableArray *)numbers
{
    if (!_numbers) {
        self.numbers = [[KVCMutableArray alloc] init];
     }
    return _numbers;
}


+(int )generateNewNumber
{
    uint8_t randomBytes[1];
    NSNumber *returnValue;
    int result = SecRandomCopyBytes(kSecRandomDefault, 1, (uint8_t*)&randomBytes);
    
    if (result == 0) {
        returnValue = [NSNumber numberWithChar:randomBytes[0]];
    }
    return [returnValue intValue];
    
}


@end
