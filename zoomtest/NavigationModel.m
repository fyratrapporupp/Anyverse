//
//  ZoomModel.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-18.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "NavigationModel.h"

@interface NavigationModel()
@property ( strong ) NSDecimalNumber *baseZoomLevel;
@property ( strong ) NSDecimalNumber *x;
@property ( strong ) NSDecimalNumber *y;
@property ( strong ) NSDecimalNumber *baseX;
@property ( strong ) NSDecimalNumber *baseY;
@end

@implementation NavigationModel



#pragma mark - Singelton -
static NavigationModel *navigationModel;

+( NavigationModel * ) sharedModel
{
    if ( !navigationModel )
    {
        navigationModel = [ [ NavigationModel alloc] init ];
    }
    
    return navigationModel;
}

#pragma mark - 

-(id) init
{
    self = [ super init ];
    if ( self ){
        
        NSDictionary *star = @{
                               @"zoom": @( 219500000000.227731 ),
                               @"x": @( 0.12 ),
                               @"y": @( 0.2 )
                               };
        
        NSDictionary *universe = @{
                               @"zoom": @( 100 ),
                               @"x": @( 0.1 ),
                               @"y": @( 0.1 )
                               };
        
        NSDictionary *navPoint = star;
        
        
        self.zoomLevel = self.baseZoomLevel = [[ NSDecimalNumber alloc ] initWithDouble: [[ navPoint valueForKey:@"zoom"] doubleValue ] ];
        self.baseX = self.x = [[ NSDecimalNumber alloc ] initWithDouble: [[ navPoint valueForKey:@"x"] doubleValue ] ];
        self.baseY = self.y = [[ NSDecimalNumber alloc ] initWithDouble: [[ navPoint valueForKey:@"y"] doubleValue ] ];
    }
    return self;
}

-( void ) zoomWithFactor: ( double ) factor
{
    NSDecimalNumber *n = [[ NSDecimalNumber alloc ] initWithDouble: factor  ];
    self.baseZoomLevel = self.zoomLevel = [ self.zoomLevel decimalNumberByMultiplyingBy: n ];
}

-( void ) zoomWithGesture: ( UIPinchGestureRecognizer * ) gesture
{
    self.zoomLevel = [ self.baseZoomLevel decimalNumberByMultiplyingBy: [[ NSDecimalNumber alloc] initWithDouble: gesture.scale ] ];
    
    if ( gesture.state == UIGestureRecognizerStateEnded )
    {
        self.zoomLevel = self.baseZoomLevel = [ self.baseZoomLevel decimalNumberByMultiplyingBy: [[ NSDecimalNumber alloc] initWithDouble: gesture.scale ] ];
        
        NSLog( @"Zoom: %f", self.baseZoomLevel.doubleValue );
        
    }
}

-( void ) panWithGesture: ( UIPanGestureRecognizer * ) gesture
{
    CGPoint change = [ gesture translationInView: gesture.view ];
    
    change.x /= self.zoomLevel.doubleValue;
    change.y /= self.zoomLevel.doubleValue;
    
    
    self.x = [ self.baseX decimalNumberByAdding: [[ NSDecimalNumber alloc] initWithDouble: change.x ] ];
    self.y = [ self.baseY decimalNumberByAdding: [[ NSDecimalNumber alloc] initWithDouble: change.y ] ];
    
    
    if ( gesture.state == UIGestureRecognizerStateEnded )
    {
        self.x = self.baseX = [ self.baseX decimalNumberByAdding: [[ NSDecimalNumber alloc] initWithDouble: change.x ] ];
        self.y = self.baseY = [ self.baseY decimalNumberByAdding: [[ NSDecimalNumber alloc] initWithDouble: change.y ] ];
        NSLog( @"x: %@ y:%@", self.x, self.y );
    }
    
}

-( CGRect ) transformRect: ( CGRect ) orignalRect forView: ( UIView * ) view
{
    CGRect transformedRect =  CGRectMake(
                                         orignalRect.origin.x - ( ( orignalRect.size.width / 2 ) * self.zoomLevel.doubleValue ),
                                         orignalRect.origin.y - ( ( orignalRect.size.height / 2 ) * self.zoomLevel.doubleValue ),
                                         orignalRect.size.width * self.zoomLevel.doubleValue,
                                         orignalRect.size.height * self.zoomLevel.doubleValue
                                         );
    
    double f = view.bounds.size.width / transformedRect.size.width;
    
    CGRect pannedRect = CGRectMake(-transformedRect.size.width / 2.0 + view.bounds.size.width / 2.0 + self.x.doubleValue * self.zoomLevel.doubleValue,
                                    -transformedRect.size.height / 2.0 + view.bounds.size.height / 2.0 + self.y.doubleValue * self.zoomLevel.doubleValue,
                                    transformedRect.size.width,
                                    transformedRect.size.height
    );
    
    return pannedRect;
}



@end
