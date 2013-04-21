//
//  DNRect.h
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-20.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNPoint.h"
#import "DNSize.h"

@interface DNRect : NSObject
@property ( strong ) DNPoint *origin;
@property ( strong ) DNSize *size;

+( DNRect * ) DNRectMakeWithX: ( NSDecimalNumber * ) x Y: ( NSDecimalNumber * ) y width: ( NSDecimalNumber * ) width height: ( NSDecimalNumber * ) height;

@end
