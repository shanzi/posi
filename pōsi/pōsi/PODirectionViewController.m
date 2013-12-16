//
//  PODirectionViewController.m
//  pōsi
//
//  Created by Chase Zhang on 12/16/13.
//  Copyright (c) 2013 cute. All rights reserved.
//

#import "PODirectionViewController.h"
#import "POSphereCompassView.h"


#import <CoreMotion/CoreMotion.h>

@interface PODirectionViewController ()
{
  @private
  CMMotionManager *_motionManager;
  NSOperationQueue *_motionUpdateQueue;
}

@end

@implementation PODirectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  if (_motionManager==nil) {
    _motionManager = [[CMMotionManager alloc] init];
  }
  if (_motionUpdateQueue==nil) {
    _motionUpdateQueue = [[NSOperationQueue alloc] init];
  }
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self startUpdateDirection];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [_motionManager stopMagnetometerUpdates];
}

- (void)startUpdateDirection
{
  if (!_motionManager.isDeviceMotionAvailable) return;
  
  _motionManager.deviceMotionUpdateInterval = 1.0/5.0;
  [_motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical
                                                      toQueue:_motionUpdateQueue
                                      withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                        CMCalibratedMagneticField magneticField = motion.magneticField;
                                        POSphereCompassView *directionView = _directionView;
                                        directionView.poleX = magneticField.field.z;
                                        directionView.poleY = magneticField.field.y;
                                        directionView.poleZ = magneticField.field.x;
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                          [directionView setNeedsDisplay];
                                        });
                                      }];
}

@end
