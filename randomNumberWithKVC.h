//
//  randomNumberWithKVC.h
//  KVCODemo
//
//  Created by Susan Elias on 2/6/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import "randomNumber.h"
#import "KVCMutableArray.h"

@interface randomNumberWithKVC : randomNumber

@property (nonatomic, strong) KVCMutableArray *KVCnumbers;

@end
