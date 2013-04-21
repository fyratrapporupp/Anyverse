//
//  SuperGroup.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-21.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "SuperGroup.h"
#import "GalaxyCluster.h"
@implementation SuperGroup
+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ GalaxyCluster drawParent: child
                       context: context
                          view: view
     ];
}
@end
