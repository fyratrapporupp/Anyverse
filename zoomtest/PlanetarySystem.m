//
//  Universe.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-03.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

//Stellar
#import "PlanetarySystem.h"
#import "Planet.h"
//Math
#import "RandomGenerator.h"

#define MAX_SATELLITES 10
#define MAX_SIZE_SYMBOL 20.0
#define MIN_SIZE_RECURSIVE 3.0
#define MIN_DISTANCE 0.5

#define SIZE_IN_AU 122


@implementation PlanetarySystem



+(void) drawParent: (struct StellarData) parent
           context: (CGContextRef)context
              view: (UIView * )view
{
    if ( parent.rect.size.width < 1.0 )
        return;
    
    srand( parent.seed );

    UIColor *color = [ UIColor colorWithRed: ( 75.0 + 150.0 * (1.0 - parent.dData[0] ) ) / 255.0
                                      green: ( 101.0 + 100.0 * (1.0 - parent.dData[0] ) ) / 255.0
                                       blue: ( 106.0 + 70 * (1.0 -  parent.dData[0] ) ) / 255.0
                                      alpha: 1.0 / ( parent.rect.size.width * 2.0 )
                      ];
    
    parent.color = color.CGColor;
    
    double oneAUPoint = (double)parent.rect.size.width / (double)SIZE_IN_AU;
    double planetSize = oneAUPoint * 0.05348;
    
    
    //Debug 
    /*UIColor *color = [ UIColor purpleColor ];
    CGContextSetStrokeColorWithColor( context, color.CGColor );
    CGContextStrokeEllipseInRect( context, rect );
    */
    
    if ( parent.rect.size.width < MAX_SIZE_SYMBOL )
    {
        [ self drawSymbol: parent
                  context: context
         ];
    }
    
    if ( parent.rect.size.width > MAX_SIZE_SYMBOL / 2.0 )
    {
    /*[ self drawCoronaInRect: rect
                    context: context
                      color: starColor ];
    */
    [ self drawStarInRect: parent.rect
                  context: context
                    color: parent.color ];
    }
    
    /*if ( parent.rect.size.width > MIN_SIZE_RECURSIVE && 0 )
    {
        int nrOfSatellites = [ RandomGenerator int ] % MAX_SATELLITES;
        if ( nrOfSatellites > 0 )
        {
            CGContextSetStrokeColorWithColor( context, [ UIColor whiteColor ].CGColor );
            
            NSMutableArray *satellites = [ NSMutableArray arrayWithCapacity: nrOfSatellites ];
            double distance = MIN_DISTANCE;
            for ( int n = 0; n < nrOfSatellites ; n++ )
            {
                distance += [ RandomGenerator double ] / 10.0;
                double size = planetSize;
                double stellarCenterX = rect.origin.x + ( parent.rect.size.width / 2 );
                double stellarCenterY = rect.origin.y + ( parent.rect.size.height / 2 );
                double stellarRadius = parent.rect.size.width / 2.0;
                
                double v = [ RandomGenerator double ] * M_PI * 2.0;
                
                double x = stellarCenterX + ( distance * stellarRadius ) * cos( v );
                double y = stellarCenterY + ( distance * stellarRadius ) * sin( v );
                
                CGRect planetRect = CGRectMake( x, y, size, size );
                
                int newSeed = [ RandomGenerator int ];
                
                if ( CGRectIntersectsRect( view.frame, planetRect ) )
                {
                    [ satellites addObject: @[
                     [ NSValue valueWithCGRect: planetRect ],
                     [ NSNumber numberWithInt: newSeed ]
                     ] ];
                }
            }
            
            for( NSArray *child in satellites )
            {
                [ self drawChildInRect: [ child[ 0 ] CGRectValue ]
                               context: context
                                  seed: child[ 1 ]
                                  view: view
                 ];
            }
        }
    }
    */
}

+(void) drawStarInRect: ( CGRect ) rect
               context: ( CGContextRef ) context
                 color: ( CGColorRef ) color
{
    
    double oneAUPoint = (double)rect.size.width / (double)SIZE_IN_AU;
    double starSize = MAX( 0.2, [ RandomGenerator double ] ) * oneAUPoint;
    
    CGRect starRect = CGRectMake( rect.origin.x
                                   + rect.size.width / 2.0 ,
                                  rect.origin.y
                                  + rect.size.height / 2.0 ,
                                  starSize,
                                  starSize
                                  );
    
    CGContextSetFillColorWithColor( context, color );
    CGContextFillEllipseInRect( context, starRect );
    
}

+(void) drawCoronaInRect: ( CGRect ) rect
                 context: ( CGContextRef ) context
                   color: ( UIColor * ) color
{
    
    double oneAUPoint = (double)rect.size.width / (double)SIZE_IN_AU;
    double starSize = [ RandomGenerator double ] * oneAUPoint * 30.0;
    
    CGRect starRect = CGRectMake( rect.origin.x
                                 + rect.size.width / 2.0 - starSize / 2.0 ,
                                 rect.origin.y
                                 + rect.size.height / 2.0 - starSize / 2.0 ,
                                 starSize,
                                 starSize
                                 );
    
    CGContextSetFillColorWithColor( context, [ color colorWithAlphaComponent: 1.0 / (double)( starRect.size.width / 5.0 ) ].CGColor );
    CGContextFillEllipseInRect( context, starRect );
    
}

+( UIColor * ) colorForStar
{
    UIColor *color;
    double str =  MAX( 0.5, [ RandomGenerator double ] );
    switch ( [ RandomGenerator int] % 3 )
    {
        case 0: //White
            color = [ UIColor colorWithWhite: str alpha: 1.0 ];
            break;
            
        case 1: //Blue
            color = [ UIColor colorWithRed: str * 0.9 green: str *0.9 blue: str alpha:1.0 ];
            break;
            
        case 2: //Orange
            color = [ UIColor colorWithRed: str green: str * 0.8 blue: str * 0.6 alpha:1.0 ];
            break;
    }
    return color;
}


+(void) drawSymbol: ( struct StellarData ) stellar
           context: ( CGContextRef ) context
{
    UIColor *color = [ UIColor colorWithCGColor: stellar.color ];
    CGContextSetFillColorWithColor( context, [ color colorWithAlphaComponent: 1.0 / ( stellar.rect.size.width * 2.0 ) ].CGColor );
    CGContextFillEllipseInRect( context, stellar.rect );
}


+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ Planet drawParent: child
                context: context
                   view: view
     ];
}

@end
