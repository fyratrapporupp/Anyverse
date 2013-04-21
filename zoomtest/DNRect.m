//
//  DNRect.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-20.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "DNRect.h"

@implementation DNRect

+( DNRect * ) DNRectMakeWithX: ( NSDecimalNumber * ) x Y: ( NSDecimalNumber * ) y width: ( NSDecimalNumber * ) width height: ( NSDecimalNumber * ) height
{
    DNRect *rect = [[ DNRect alloc ] init ];
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = width;
    rect.size.height = height;
    return rect;
}

-(bool) intersectsWith: ( DNRect * ) rect
{
    NSDecimalNumber *left = [ self.origin.x decimalNumberByAdding:self.size.width ];
    
    if ( [ left compare: rect.origin.x ] == NSOrderedAscending ) return NO;
   
    NSDecimalNumber *leftRect = [ rect.origin.x decimalNumberByAdding:rect.size.width ];
    
    if ( [ leftRect compare: left ] == NSOrderedAscending ) return NO;
    
    
    NSDecimalNumber *top = [ self.origin.y decimalNumberByAdding:self.size.height ];
    
    if ( [ top compare: rect.origin.y ] == NSOrderedAscending ) return NO;
    
    NSDecimalNumber *topRect = [ rect.origin.y decimalNumberByAdding:rect.size.height ];
    
    if ( [ topRect compare: top ] == NSOrderedAscending ) return NO;
    
    
    return YES;
}

@end
