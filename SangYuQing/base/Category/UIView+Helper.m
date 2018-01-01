//
//  UIView+Helper.m
//  AnhuiNews
//
//  Created by History on 10/23/15.
//  Copyright © 2015 ahxmt. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Position)

- (CGFloat)left
{
    return CGRectGetMinX(self.frame);
}
- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)top
{
    return CGRectGetMinY(self.frame);
}
- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    CGFloat offset = self.right - right;
    frame.origin.x += offset;
    self.frame = frame;
}
- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}
- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    CGFloat offset = self.bottom - bottom;
    frame.origin.y += offset;
    self.frame = frame;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.centerY);
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.centerX, centerY);
}

@end

@implementation UIView (Layer)

- (void)setLayerBorderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)setLayerBorderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius
{
    [self setLayerBorderWidth:width borderColor:color];
    self.layer.cornerRadius = radius;
}

- (void)setCircleLayerBorderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius
{
    [self setLayerBorderWidth:width borderColor:color cornerRadius:radius];
    self.layer.masksToBounds = YES;
}

- (void)setCircleLayerBorderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    CGFloat radius = MAX(self.width, self.height) / 2;
    [self setCircleLayerBorderWidth:width borderColor:color cornerRadius:radius];
}

- (void)setLayerDashBorderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius
{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = color.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath;
    border.frame = self.bounds;
    border.lineWidth = width;
    border.lineCap = @"round";
    border.lineDashPattern = @[@6, @3];
    [self.layer addSublayer:border];
}

@end


@implementation UIView (Capture)

#pragma mark -
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)captureWithRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;
}

@end

@implementation UIView (Helper)
- (void)removeAllSubViews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
@end
