//
//  Universe.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-03.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

//Stellar
#import "Universe.h"
#import "SuperSuperSuperGroup.h"
//Math
#import "RandomGenerator.h"


@implementation Universe


+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ SuperSuperSuperGroup drawParent: child
                              context: context
                                 view: view
     ];
}


@end
