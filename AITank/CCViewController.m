//
//  CCViewController.m
//  CCViewController
//
//  Created by Jerrod Putman on 2/7/12.
//  Copyright (c) 2012 Tiny Tim Games. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CCViewController.h"
#import "IntroLayer.h"
#import "DisplayManager.h"

@implementation CCViewController

#pragma mark - View lifecycle

//-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if(self)
//    {
//        director = [DisplayManager Instance];
//    }
//    return self;
//}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        director = ((DisplayManager *)[DisplayManager Instance]).director;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //director = [DisplayManager Instance];
    // and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director pushScene: [IntroLayer scene]]; 
	
     // Add the director as a child view controller.
    [self addChildViewController:director];
    
    // Add the director's OpenGL view, and send it to the back of the view hierarchy so we can place UIKit elements on top of it.
    [self.view addSubview:director.view];
    [self.view sendSubviewToBack:director.view];
    //[self presentModalViewController:director animated:YES];

    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
    // Ensure we fulfill all of our view controller containment requirements.
    [director didMoveToParentViewController:self];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Observe some notifications so we can properly instruct the director.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationSignificantTimeChange:)
                                                 name:UIApplicationSignificantTimeChangeNotification
                                               object:nil];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationSignificantTimeChangeNotification object:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    [director setDelegate:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [director purgeCachedData];
}



- (void)CloseView
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Notification handlers

- (void)applicationWillResignActive:(NSNotification *)notification
{
    [director pause];
}


- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [director resume];
}


- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    [director stopAnimation];
}


- (void)applicationWillEnterForeground:(NSNotification *)notification
{
    [director startAnimation];
}


- (void)applicationWillTerminate:(NSNotification *)notification
{
    [director end];
}


- (void)applicationSignificantTimeChange:(NSNotification *)notification
{
    [director setNextDeltaTimeZero:YES];
}


@end
