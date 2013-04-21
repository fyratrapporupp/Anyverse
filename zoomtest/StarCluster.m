//
//  StarCluster.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-18.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "StarCluster.h"
#import "PlanetarySystem.h"


@implementation StarCluster

+( struct StellarData ) childNr: ( int ) nr forParent: ( struct StellarData ) parent
{
    struct StellarData child = [ super childNr: nr forParent: parent ];
    
    child.dData[0] = parent.dData[0];
    return child;
}

+(void) drawSymbol: ( struct StellarData ) stellar
           context: ( CGContextRef ) context
{
    //75 101 106 blå
    //227 201 177
    UIColor *color = [ UIColor colorWithRed: ( 75.0 + 150.0 * (1.0 - stellar.dData[0] ) ) / 255.0
                                      green: ( 101.0 + 100.0 * (1.0 - stellar.dData[0] ) ) / 255.0
                                       blue: ( 106.0 + 70 * (1.0 -  stellar.dData[0] ) ) / 255.0
                                      alpha: 1.0 / ( stellar.rect.size.width * 2.0 )
                      ];
    
    
    CGContextSetFillColorWithColor( context, color.CGColor );
    CGContextFillEllipseInRect( context, stellar.rect );
}

+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ PlanetarySystem drawParent: child
                         context: context
                            view: view
     ];
}
@end
