//
//  BarcodeViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 7/30/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTBarcodeViewController.h"
#import "BTBookAPIManager.h"
#import "BTAddBookViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BTBarcodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) UIView *previewView;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) NSString *isbn;
@end

@implementation BTBarcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    self.captureSession = nil;
    self.previewView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.previewView];
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    self.captureSession = [AVCaptureSession new];
    [self.captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetaDataOutput = [AVCaptureMetadataOutput new];
    [self.captureSession addOutput:captureMetaDataOutput];
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetaDataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetaDataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeEAN13Code]];
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.previewView.layer.bounds];
    [self.previewView.layer addSublayer:self.videoPreviewLayer];
    [self.captureSession startRunning];
    [self drawBarcodeHeader];
}

-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code]) {
            self.isbn = [metadataObj stringValue];
            [self performSelectorOnMainThread:@selector(stopReading) withObject:[metadataObj stringValue] waitUntilDone:NO];
        }
    }
}

-(void)stopReading {
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [[BTBookAPIManager shared] fetchBookWithIsbn:self.isbn completion:^(id book, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            [self.delegate makeBook:book];
            [self.previewView removeFromSuperview];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawBarcodeHeader {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 125)];
    headerView.backgroundColor = [UIColor colorWithRed:200.0/256.0 green:1.0/256.0 blue:43.0/256.0 alpha:1];
    [self.view addSubview:headerView];
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
