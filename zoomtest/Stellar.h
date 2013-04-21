//
//  Stellar.h
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-18.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import <Foundation/Foundation.h>

struct StellarData {
    CGRect rect;
    double dData[3];
    int iData[3];
    int seed;
    CGColorRef color;
};

@interface Stellar : NSObject


+( struct StellarData ) childNr: ( int ) nr forParent: ( struct StellarData ) parent;

+(void) drawParent: (struct StellarData) parent
           context: (CGContextRef)context
              view: (UIView * )view;
@end
