//
//  randomNumbers.h
//  KVCODemo
//
//  Created by Susan Elias on 2/4/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface randomNumber : NSObject

@property (nonatomic, strong) NSMutableArray *numbers;

+(int )generateNewNumber;

-(randomNumber *)initWithQuantity:(NSUInteger)quantity;

@end
