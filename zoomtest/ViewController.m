//
//  ViewController.m
//  zoomtest
//
//  Created by Ronnie Persson on 2013-04-02.
//  Copyright (c) 2013 Ronnie Persson. All rights reserved.
//

#import "ViewController.h"
#import "NavigationModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog( @"%@", [NSDecimalNumber maximumDecimalNumber] );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)zoom:(UIPinchGestureRecognizer *) sender {
    [[ NavigationModel sharedModel] zoomWithGesture: sender ];
    [ self.anyverseView setNeedsDisplay ];
}

- (IBAction)pan:(UIPanGestureRecognizer *) sender {
    [[ NavigationModel sharedModel] panWithGesture: sender ];
    [ self.anyverseView setNeedsDisplay ];
}
@end
