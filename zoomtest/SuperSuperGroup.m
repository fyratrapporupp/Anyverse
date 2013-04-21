//
//  SuperSuperGroup.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-21.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "SuperSuperGroup.h"
#import "SuperGroup.h"
@implementation SuperSuperGroup
+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ SuperGroup drawParent: child
                    context: context
                       view: view
     ];
}
@end
