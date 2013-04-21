//
//  ViewController.h
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-02.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnyverseView.h"
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet AnyverseView *anyverseView;
- (IBAction)zoom:( UIPinchGestureRecognizer *)sender;
- (IBAction)pan:(UIPanGestureRecognizer *)sender;

@end
