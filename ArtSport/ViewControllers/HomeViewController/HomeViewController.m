//
//  HomeViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"

@interface HomeViewController () <AVCapturePhotoCaptureDelegate>
{
    AVCaptureSession *session;
    AVCapturePhotoOutput *stillImageOutput;
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
}
@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.centreBtn.layer.cornerRadius = 50/2;
    self.centreBtn.layer.masksToBounds = true;
    
    

  
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:3
                     animations:^{
                         
                         ;
                         self.bottomConstraintofBubble.constant += 73;
                         [self.centreBtn layoutIfNeeded];
                         
                     }
                     completion:^(BOOL finished)
     {
         
     }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarItem.image = [UIImage imageNamed:@""];
//    session = [[AVCaptureSession alloc] init];
//    session.sessionPreset = AVCaptureSessionPresetPhoto;
//    
//    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    
//    NSError *error;
//    AVCaptureDeviceInput *input;
//    
//    @try {
//        input = [[AVCaptureDeviceInput alloc] initWithDevice:backCamera error:&error];
//    } @catch (NSException *exception) {
//        NSLog(@"%@",exception.userInfo);
//        NSLog(@"%@",error.localizedDescription);
//    } @finally {
//        
//    }
//    
//    if (error == nil && [session canAddInput:input] ) {
//        [session addInput:input];
//        // The remainder of the session setup will go here...
//
//    }
//    
//    
//    
//    AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];
//    imageOutput.outputSettings = @{
//                                        (__bridge NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)
//                                        };
//    [session addOutput:imageOutput];
//
//    
//    videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
//    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
//    [self.previewView.layer addSublayer:videoPreviewLayer];
//    [session startRunning];

}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    videoPreviewLayer.frame = self.previewView.bounds;
//}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.tabBarItem.image = [UIImage imageNamed:@"icon_balloon"];

}

//- (IBAction)capturePhoto:(id)sender {
//    
//    AVCaptureConnection *connection = [stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
//    if (connection.active) {
//        //connection is active
//        NSLog(@"Connection is active");
//        AVCapturePhotoSettings *avSettings = [AVCapturePhotoSettings photoSettings];
//        [stillImageOutput capturePhotoWithSettings:avSettings delegate:self];
//    }
//}

- (IBAction)showSearch:(id)sender {

    SearchArtistViewController *searchArtistVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchArtistViewController"];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    searchArtistVC.hidesBottomBarWhenPushed = true;
    searchArtistVC.view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.85];
    [searchArtistVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [searchArtistVC setReferencedNavigation:self.navigationController];
    [self.navigationController presentViewController:searchArtistVC animated:false completion:nil];
    
}

#pragma mark - AVCapturePhotoCaptureDelegate
-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error
{
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
    }
    
    if (photoSampleBuffer) {
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
//        UIImage *image = [UIImage imageWithData:data];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
