//
//  Planet.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-19.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "Planet.h"
#import "RandomGenerator.h"

@implementation Planet


+(UIColor * ) colorForPlanet
{
    UIColor *color;
    double str =  MAX( 0.5, [ RandomGenerator double ] );
    switch ( [ RandomGenerator int] % 3 )
    {
        case 0: //gray
            color = [ UIColor colorWithRed: str green: str blue: str alpha:1.0 ];
            break;
            
        case 1: //Blue
            color = [ UIColor colorWithRed: str * 0.3 green: str *0.3 blue: str alpha:1.0 ];
            break;
            
        case 2: //Orange
            color = [ UIColor colorWithRed: str green: str * 0.5 blue: str * 0.25 alpha:1.0 ];
            
    }
    return color;
}

+(void) drawSymbolInRect: ( CGRect ) rect
                 context: ( CGContextRef ) context
                    seed: ( NSNumber * ) seed
                    data: ( NSDictionary * ) data
{
    UIColor *color = [ self colorForPlanet ];
    CGContextSetFillColorWithColor( context, color.CGColor );
    CGContextFillEllipseInRect( context, rect );
}

+(void) drawInRect:(CGRect)rect
           context:(CGContextRef)context
              seed:(NSNumber *)seed
              view:(UIView * )view
              data: ( NSDictionary * ) data
{
    if ( rect.size.width < 1.0 )
        return;
    
    srand( seed.intValue );
    [ self drawSymbolInRect: rect
                    context: context
                       seed: seed
                       data: data
     ];
}

+(void) drawChildInRect: ( CGRect) rect
                context: ( CGContextRef ) context
                   seed: ( NSNumber * ) seed
                   view: ( UIView * ) view
{
   //satellites
}




@end
