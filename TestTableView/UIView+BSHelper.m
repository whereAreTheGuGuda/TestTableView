//
//  UIView+UIView_BSHelper.m
//  ChenXiao
//
//  Created by kenshin on 4/17/14.
//  Copyright (c) 2014 BazzarEntertainment. All rights reserved.
//

#import "UIView+BSHelper.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIView (Positioning)

- (void)centerInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerVerticallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake([self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerHorizontallyInRect:(CGRect)rect;
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0), [self center].y)];
}

- (void)centerInSuperView;
{
    [self centerInRect:[[self superview] bounds]];
}
- (void)centerVerticallyInSuperView;
{
    [self centerVerticallyInRect:[[self superview] bounds]];
}
- (void)centerHorizontallyInSuperView;
{
    [self centerHorizontallyInRect:[[self superview] bounds]];
}

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
{
    // for now, could use screen relative positions.
    NSAssert([self superview] == [view superview], @"views must have the same parent");
    
    [self setCenter:CGPointMake([view center].x,
                                floorf(padding + CGRectGetMaxY([view frame]) + ([self height] / 2)))];
}

- (void)centerHorizontallyBelow:(UIView *)view;
{
    [self centerHorizontallyBelow:view padding:0];
}

@end

@implementation UIView (Size)


- (CGPoint)rightTopPoint
{
	return CGPointMake(self.width, 0);
}

- (void)setSize:(CGSize)size;
{
    CGPoint origin = [self frame].origin;
    
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)size;
{
    return [self frame].size;
}

- (CGFloat)left;
{
    return CGRectGetMinX([self frame]);
}

- (void)setLeft:(CGFloat)x;
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)top;
{
    return CGRectGetMinY([self frame]);
}

- (void)setTop:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)right;
{
    return CGRectGetMaxX([self frame]);
}

- (void)setRight:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (CGFloat)bottom;
{
    return CGRectGetMaxY([self frame]);
}

- (void)setBottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

- (CGFloat)centerX;
{
    return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY;
{
    return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)width;
{
    return CGRectGetWidth([self frame]);
}

- (void)setWidth:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    
    [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)height;
{
    return CGRectGetHeight([self frame]);
}

- (void)setHeight:(CGFloat)height;
{
    CGRect frame = [self frame];
    frame.size.height = height;
	
    [self setFrame:CGRectStandardize(frame)];
}

@end


@implementation UIView (InnerShadow)

// sourced from http://stackoverflow.com/questions/4431292/inner-shadow-effect-on-uiview-layer

- (void)drawInnerShadowInRect:(CGRect)rect radius:(CGFloat)radius fillColor:(UIColor *)fillColor;
{
    CGRect bounds = [self bounds];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat outsideOffset = 20.f;
    
    CGMutablePathRef visiblePath = CGPathCreateMutable();
    CGPathMoveToPoint(visiblePath, NULL, bounds.size.width-radius, bounds.size.height);
    CGPathAddArc(visiblePath, NULL, bounds.size.width-radius, radius, radius, 0.5f*M_PI, 1.5f*M_PI, YES);
    CGPathAddLineToPoint(visiblePath, NULL, radius, 0.f);
    CGPathAddArc(visiblePath, NULL, radius, radius, radius, 1.5f*M_PI, 0.5f*M_PI, YES);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.size.width-radius, bounds.size.height);
    CGPathCloseSubpath(visiblePath);
    
    [fillColor setFill];
    CGContextAddPath(context, visiblePath);
    CGContextFillPath(context);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, -outsideOffset, -outsideOffset);
    CGPathAddLineToPoint(path, NULL, bounds.size.width+outsideOffset, -outsideOffset);
    CGPathAddLineToPoint(path, NULL, bounds.size.width+outsideOffset, bounds.size.height+outsideOffset);
    CGPathAddLineToPoint(path, NULL, -outsideOffset, bounds.size.height+outsideOffset);
    
    CGPathAddPath(path, NULL, visiblePath);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, visiblePath);
    CGContextClip(context);
    
    UIColor * shadowColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 4.0f), 8.0f, [shadowColor CGColor]);
    [shadowColor setFill];
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    
    CGPathRelease(path);
    CGPathRelease(visiblePath);
    CGContextRestoreGState(context);
}

- (void)drawInnerShadowInRect:(CGRect)rect fillColor:(UIColor *)fillColor
{
    [self drawInnerShadowInRect:rect radius:(0.5f * CGRectGetHeight(rect)) fillColor:fillColor];
}

+ (void)drawOuterShadow:(UIView *)view
{
//    view.layer.borderWidth = 1;
//    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowRadius = 0.5;
    view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:view.bounds] CGPath];
    view.layer.shadowColor = [UIColor blackColor].CGColor;
}

@end



@implementation UIView (Draw)

static CGPoint gStart(CGRect bounds) {
	
	return CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.25);
}

static CGPoint gEnd(CGRect bounds) {
	
	return CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.75);
}

//static CGPoint gCenter(CGRect bounds) {
//	
//	return CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
//}
//
//static CGFloat gInnerRadius(CGRect bounds) {
//	
//	CGFloat r = bounds.size.width < bounds.size.height ? bounds.size.width : bounds.size.height;
//	return r * 0.125;
//}

#pragma mark -

+ (void)drawGradientInRect:(CGRect)rect withColors:(NSArray *)colors {
	
	NSMutableArray *ar = [NSMutableArray array];
	for (UIColor *c in colors) {
		[ar addObject:(id)c.CGColor];
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
	
	CGContextClipToRect(context, rect);
	
	CGPoint start = CGPointMake(0.0, 0.0);
	CGPoint end = CGPointMake(0.0, rect.size.height);
	
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	//CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
}

+ (void)drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colours {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colours, NULL, 2);
	CGColorSpaceRelease(rgb);
	CGPoint start, end;
	
	start = gStart(rect);
	end = gEnd(rect);
	
	CGContextClipToRect(context, rect);
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
	
	CGContextRestoreGState(context);
}

+ (void)drawRectangleInRect:(CGRect)rect color:(UIColor*)color {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[color set];
	CGContextAddRect(context, rect);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)dim
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    //Gradient colours
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {0.0f, 1.0f};
    CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);
    //Gradient center
    CGPoint gradCenter= CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    //Gradient radius
    float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    //Gradient draw
    CGContextDrawRadialGradient (context, gradient, gradCenter,
                                 0, gradCenter, gradRadius,
                                 kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

+ (void)drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor *)color
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[color set];
	
	CGRect rrect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height );
	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFill);
}

+ (void)drawDialogBoxInRect:(CGRect)rect withRadius:(CGFloat)radius strokeColors:(CGFloat[])sColor fillColor:(CGFloat[])fColor {
	
#define kOffset_Triangle 30
#define kTriangle_H (12)
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect rrect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height );
	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	CGContextMoveToPoint(context, minx+kOffset_Triangle+kTriangle_H, miny);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	
	CGContextAddLineToPoint(context, minx+kOffset_Triangle, miny);
	CGContextAddLineToPoint(context, minx+kOffset_Triangle+kTriangle_H/2, miny-kTriangle_H/2);
	CGContextAddLineToPoint(context, minx+kOffset_Triangle+kTriangle_H, miny);
	CGContextClosePath(context);
	
	CGContextSetLineWidth(context, 0.5);
	CGContextSetStrokeColor(context, sColor);
	CGContextSetFillColor(context, fColor);
	
	CGContextDrawPath(context, kCGPathEOFillStroke);
}

+ (void)drawLineInRect:(CGRect)rect colors:(CGFloat[])colors {
	
	[UIView drawLineInRect:rect colors:colors width:1 cap:kCGLineCapButt];
}

+ (void)drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	
	CGFloat colors[4];
	colors[0] = red;
	colors[1] = green;
	colors[2] = blue;
	colors[3] = alpha;
	[UIView drawLineInRect:rect colors:colors];
}

+ (void)drawLineInRect:(CGRect)rect colors:(CGFloat[])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextSetLineCap(context,cap);
	CGContextSetLineWidth(context, lineWidth);
	
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint(context,rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
	CGContextStrokePath(context);
	
	CGContextRestoreGState(context);
}

@end


@implementation UIView (Shake)
- (void)shake {
	CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[keyAn setDuration:0.5f];
	NSArray *array = [[NSArray alloc] initWithObjects:
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  nil];
	[keyAn setValues:array];
	NSArray *times = [[NSArray alloc] initWithObjects:
					  [NSNumber numberWithFloat:0.1f],
					  [NSNumber numberWithFloat:0.2f],
					  [NSNumber numberWithFloat:0.3f],
					  [NSNumber numberWithFloat:0.4f],
					  [NSNumber numberWithFloat:0.5f],
					  [NSNumber numberWithFloat:0.6f],
					  [NSNumber numberWithFloat:0.7f],
					  [NSNumber numberWithFloat:0.8f],
					  [NSNumber numberWithFloat:0.9f],
					  [NSNumber numberWithFloat:1.0f],
					  nil];
	[keyAn setKeyTimes:times];
	[self.layer addAnimation:keyAn forKey:@"TextAnim"];
	
}

@end
