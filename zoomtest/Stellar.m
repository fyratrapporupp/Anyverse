//
//  Stellar.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-03.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

//Stellar
#import "Stellar.h"
//Math
#import "RandomGenerator.h"

//Statics
#define MAX_OBJECTS 250
#define MAX_SIZE_SYMBOL 20.0
#define MIN_SIZE_RECURSIVE 20.0
#define AREA_DIVISOR 20.0

@implementation Stellar

+( int ) numberOfVisibleObjectsInRect: ( CGRect ) rect
{
    double area = M_PI * pow( rect.size.width / 2.0, 2.0 );
    int nrOfVisibleObjects = MIN(
                                 MAX_OBJECTS,
                                 (int)round( area / AREA_DIVISOR )
                                 );
    return nrOfVisibleObjects;
}

+(void) drawSymbol: ( struct StellarData ) stellar
           context: ( CGContextRef ) context
{
    CGContextSetFillColorWithColor( context, [ UIColor colorWithWhite:1.0 alpha: 1.0 / ( stellar.rect.size.width * 2.0 ) ].CGColor );
    CGContextFillEllipseInRect( context, stellar.rect );
}

+( struct StellarData ) childNr: ( int ) nr forParent: ( struct StellarData ) parent
{
    double angle = [ RandomGenerator double ] * M_PI * 2.0f;
    double distance  = [ RandomGenerator double ];
    double size = parent.rect.size.width * 50.0 / ( 500.0 + nr );
    
    double stellarCenterX = parent.rect.origin.x + ( parent.rect.size.width / 2 );
    double stellarCenterY = parent.rect.origin.y + ( parent.rect.size.height / 2 );
    double stellarRadius = parent.rect.size.width / 2.0;
    
    double x = stellarCenterX + ( distance * stellarRadius ) * cos( angle ) ;
    double y = stellarCenterY + ( distance * stellarRadius ) * sin( angle );
    
    struct StellarData child;
    child.rect = CGRectMake(x,y,size,size);
    child.dData[0] = distance;
    
    return child;
}

+(void) drawChild: ( struct StellarData ) child
          context: ( CGContextRef ) context
             view: ( UIView * ) view
{
    [ self drawParent: child
              context: context
                 view: view
     ];
}


+(void) drawParent: (struct StellarData) parent
           context: (CGContextRef)context
              view: (UIView * )view
{
    if ( parent.rect.size.width < 1.0 )
        return;
    
    srand( parent.seed );
    
    if ( parent.rect.size.width < MAX_SIZE_SYMBOL )
    {
        [ self drawSymbol: parent
                  context: context
         ];
    }
    
    if ( parent.rect.size.width > MIN_SIZE_RECURSIVE )
    {
        int nrOfVisibleObjects = [ self numberOfVisibleObjectsInRect: parent.rect ];
        if ( nrOfVisibleObjects > 0 )
        {
            struct StellarData children[ nrOfVisibleObjects ];
            
            int m = 0;
            for ( int n = 0; n < nrOfVisibleObjects ; n++ )
            {
                struct StellarData child = [ self childNr: n forParent: parent ];
                child.seed = [ RandomGenerator int ];
                
                if ( CGRectIntersectsRect( view.frame, child.rect ) )
                {
                    children[ m ] = child;
                    m++;
                }
            }
            
            for( int n = 0; n < m; n++ )
            {
                [ self drawChild: children[ n ]
                         context: context
                            view: view
                 ];
            }
        }
    }
    
}

@end
