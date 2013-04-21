//
//  ZoomModel.h
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-18.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationModel : NSObject


@property ( strong ) NSDecimalNumber *zoomLevel;
+( NavigationModel * ) sharedModel;
-( void ) zoomWithGesture: ( UIPinchGestureRecognizer * ) gesture;
-( void ) panWithGesture: ( UIPanGestureRecognizer * ) gesture;
-( CGRect ) transformRect: ( CGRect ) orignalRect forView: ( UIView * ) view;
-( void ) zoomWithFactor: ( double ) factor;
@end
