//
//  POSphereCompassView.m
//  pōsi
//
//  Created by Chase Zhang on 12/16/13.
//  Copyright (c) 2013 cute. All rights reserved.
//

#import "POSphereCompassView.h"

@implementation POSphereCompassView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _poleZ = 0;
    _poleX = 0;
    _poleY = 1.0;
  }
  return self;
}


- (void)awakeFromNib
{
  [super awakeFromNib];
  _poleZ = 0;
  _poleX = 0;
  _poleY = 1;
}

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  CGFloat midX = CGRectGetMidX(rect);
  CGFloat midY = CGRectGetMidX(rect);
  
  CGFloat boardRadius = fmin(rect.size.width, rect.size.height) * .4;
  CGFloat boardConjugate = boardRadius * 2;
  
  CGFloat boardLineWidth = boardRadius * 0.04;
  CGFloat originInspectorRadius = boardRadius * .1;
  
  CGFloat uniformFactor = boardRadius / sqrt(_poleX*_poleX + _poleY*_poleY + _poleZ*_poleZ);
  
  CGFloat uniformZ = _poleZ * uniformFactor;
  CGFloat scaleFactorNorth = boardConjugate / (boardConjugate * 1.25 + uniformZ);
  CGFloat scaleFactorSorth = boardConjugate / (boardConjugate * 1.25 - uniformZ);
  
  CGFloat uniformNorthX = (_poleX * uniformFactor - originInspectorRadius) * scaleFactorNorth;
  CGFloat uniformNorthY = (_poleY * uniformFactor - originInspectorRadius) * scaleFactorNorth;
  CGFloat uniformSouthX = (-_poleX * uniformFactor - originInspectorRadius) * scaleFactorSorth;
  CGFloat uniformSouthY = (-_poleY * uniformFactor - originInspectorRadius) * scaleFactorSorth;
  
  CGFloat northInspectorConjugate = originInspectorRadius * scaleFactorNorth * 2;
  CGFloat southInspectorConjugate = originInspectorRadius * scaleFactorSorth * 2;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextTranslateCTM(context, midX, midY);
  
  CGContextSetRGBStrokeColor(context, 0.4, 0.6, 1.0, 1.0);
  CGContextSetLineWidth(context, boardLineWidth);
  CGContextStrokeEllipseInRect(context, CGRectMake(-boardRadius, -boardRadius, boardConjugate, boardConjugate));
  
  if (_poleZ < 0) {
    CGContextSetRGBFillColor(context, .35, 1.0, .43, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(uniformNorthX, uniformNorthY,
                                                   northInspectorConjugate, northInspectorConjugate));
    
    CGContextSetRGBFillColor(context, 1.0, .35, .43, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(uniformSouthX, uniformSouthY,
                                                   southInspectorConjugate, southInspectorConjugate));

  }
  else {
    CGContextSetRGBFillColor(context, 1.0, .35, .43, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(uniformSouthX, uniformSouthY,
                                                   southInspectorConjugate, southInspectorConjugate));
    
    CGContextSetRGBFillColor(context, .35, 1.0, .43, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(uniformNorthX, uniformNorthY,
                                                   northInspectorConjugate, northInspectorConjugate));
  }
}

@end
