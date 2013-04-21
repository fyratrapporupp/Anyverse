//
//  AnyverseView.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-03.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//
#import "NavigationModel.h"
#import "AnyverseView.h"
#import "Universe.h"
#import "PlanetarySystem.h"
#import "StarCluster.h"
#import "SpiralGalaxy.h"
#import "Stellar.h"
#import <QuartzCore/QuartzCore.h>
#define AUTO_ZOOM YES
#define RECORD NO
@interface AnyverseView()
@property NSDecimalNumber *startZoom;
@end
@implementation AnyverseView

static int step = 0;

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor( context, [ UIColor blackColor].CGColor );
    CGContextSetStrokeColorWithColor( context, [ UIColor whiteColor].CGColor );
    CGContextFillRect( context, self.bounds );
    
    CGRect frameOfUniverse = CGRectMake( 0, 0, 1, 1 );
    CGRect transformedFrame = [[ NavigationModel sharedModel ] transformRect: frameOfUniverse forView: self ];
    
   // CGContextStrokeRect( context, transformedFrame );

    struct StellarData universe;
    universe.rect = transformedFrame;
    universe.seed = 2;
    
    [ Universe drawParent: universe
                      context: context
                         view: self
     ];
    
    
   if ( AUTO_ZOOM ) [ self performSelector: @selector( redraw ) withObject: nil afterDelay: 0.01 ];
}


-(void)createImage {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent: [ NSString stringWithFormat: @"step_%d.png", step ] ];
    
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 2.0);
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData* imgData = UIImagePNGRepresentation(image);
    [imgData writeToFile:filePath atomically:YES];    
    step++;
}

-(void) redraw
{
    if ( RECORD )[ self createImage ];
    if ( !self.startZoom ) self.startZoom = [[NavigationModel sharedModel] zoomLevel];
    [[ NavigationModel sharedModel ] zoomWithFactor: self.startZoom.doubleValue < 100000 ? 1.05 : 0.95 ];
    [ self setNeedsDisplay ];
}


@end
