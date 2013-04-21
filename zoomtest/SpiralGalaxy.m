//
//  SpiralGalaxy.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-18.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//



//Stellar
#import "SpiralGalaxy.h"
#import "StarCluster.h"
#import "PlanetarySystem.h"
//Math
#import "RandomGenerator.h"

@implementation SpiralGalaxy

+( struct StellarData ) childNr: ( int ) nr forParent: ( struct StellarData ) parent
{
    double distance  = [ RandomGenerator double ];
    double distance2 = [ RandomGenerator double ] * 0.1 - 0.05;
    double size = parent.rect.size.width * 20.0 / ( 500.0 + nr );
    
    int arms = parent.iData[0];
    int armLength = parent.iData[1];
    
    int arm = [ RandomGenerator int ] % arms;
    
    double stellarCenterX = parent.rect.origin.x + ( parent.rect.size.width / 2 );
    double stellarCenterY = parent.rect.origin.y + ( parent.rect.size.height / 2 );
    double stellarRadius = parent.rect.size.width / 2.0;
    
    double armV = ( M_PI * 2 ) / (double)arms * (double)arm;
    double v = (double)armV + distance * M_PI * (double)armLength;
    
    double x = stellarCenterX + (( distance + distance2 ) * stellarRadius ) * cos( v );
    double y = stellarCenterY + (( distance + distance2 ) * stellarRadius ) * sin( v );
    
    struct StellarData child;
    child.rect = CGRectMake(x,y,size,size);
    child.dData[0] = distance;
    
    return child;
}

+(void) drawParent: (struct StellarData) parent
           context: (CGContextRef)context
              view: (UIView * )view
{
    if ( parent.rect.size.width < 1.0 )
        return;
    
    srand( parent.seed );
    parent.iData[0] = [ RandomGenerator int ] % 4 + 1; //nr of arms
    parent.iData[1] = [ RandomGenerator int ] % 6 + 4; //length of arms
    
    [ super drawParent:parent
               context:context
                  view:view
     ];    
}

+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ StarCluster drawParent: child
                     context: context
                        view: view
     ];
}

@end
