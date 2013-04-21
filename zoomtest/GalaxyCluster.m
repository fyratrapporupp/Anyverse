//
//  GalaxyCluster.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-18.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "GalaxyCluster.h"
#import "SpiralGalaxy.h"

@implementation GalaxyCluster
+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ SpiralGalaxy drawParent: child
                      context: context
                         view: view
     ];
}

@end
