//
//  KVCMutableArray.m
//  KVCODemo
//
//  Created by Susan Elias on 2/5/15.
//  Copyright (c) 2015 GriffTech. All rights reserved.
//

#import "KVCMutableArray.h"

@implementation KVCMutableArray

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.array = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSUInteger)countOfArray{
    return self.array.count;
}


-(id)objectInArrayAtIndex:(NSUInteger)index
{
    return [self.array objectAtIndex:index];
}


-(void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index
{
    [self.array insertObject:object atIndex:index];
}


-(void)removeObjectFromArrayAtIndex:(NSUInteger)index
{
    [self.array removeObjectAtIndex:index];
}

-(void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object
{
    [self.array replaceObjectAtIndex:index withObject:object];
}

@end
