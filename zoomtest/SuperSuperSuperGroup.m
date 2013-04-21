//
//  SuperSuperSuperGroup.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-21.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "SuperSuperSuperGroup.h"
#import "SuperSuperGroup.h"
@implementation SuperSuperSuperGroup
+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ SuperSuperGroup drawParent: child
                         context: context
                            view: view
     ];
}
@end
