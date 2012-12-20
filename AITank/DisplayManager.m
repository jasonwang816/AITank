//
//  DisplayManager.m
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DisplayManager.h"
#import "cocos2d.h"

@implementation DisplayManager

@synthesize director;

+ (id)Instance{
    static DisplayManager * display = nil;
    static dispatch_once_t displayToken;
    
    dispatch_once(&displayToken, ^{
        display = [[self alloc] init];
    });
    
    return display;
}

- (id) init{
    if (self = [super init]){
        //init gameData
        _gameData = [GameData Instance];

        //Init director
        director = [CCDirector sharedDirector];
        
        // If the director's OpenGL view hasn't been set up yet, then we should create it now. If you would like to prevent this "lazy loading", you should initialize the director and set its view elsewhere in your code.
        if([director isViewLoaded] == NO)
        {
            director.view = [self createDirectorGLView];
            [self didInitializeDirector];
        }
        
        director.delegate = self;      

    }
    return  self;
}

- (void) InitInstance:(CCLayer *) theLayer{

    
    //Init Game Field
    CGSize s = [director winSize];
    NSLog(@"winsize[ width:%f, height:%f]",s.width, s.height);
    
    //Init gameitems
    ball = [GameSprite spriteWithFile:@"ball.jpeg" rect:CGRectMake(0, 0, 23, 23)];
    [ball setGameItem:_gameData.ball];
    [theLayer addChild:ball];
    
}


- (void) UpdateGameData{
    
}

#pragma mark - Setting up the director

- (CCGLView *)createDirectorGLView
{
    // Create a default OpenGL view.
    CCGLView *glView = [CCGLView viewWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]
                                   pixelFormat:kEAGLColorFormatRGB565
                                   depthFormat:0
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0];
    
    // Enable multiple touches
	[glView setMultipleTouchEnabled:YES];
    
    
    
    return glView;
}


- (void)didInitializeDirector
{
    //CCDirector *director = [CCDirector sharedDirector];
    
    // Set up some common director properties.
    [director setAnimationInterval:1.0f/60.0f];
    [director enableRetinaDisplay:YES];
	
	director.wantsFullScreenLayout = YES;
	
	// Display FSP and SPF
	[director setDisplayStats:YES];
	
	// 2D projection
	[director setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
    
    
    
}


@end
