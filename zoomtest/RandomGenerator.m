//
//  RandomGenerator.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-03.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "RandomGenerator.h"

@implementation RandomGenerator

+( double ) double
{
    return ((double)rand() / RAND_MAX);
}

+( int ) int
{
    return rand();
}

@end
