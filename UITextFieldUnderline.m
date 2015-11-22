//
//  UITextFieldUnderline.m
//  
//
//  Created by Irwin Gonzales on 10/26/15.
//
//

#import "UITextFieldUnderline.h"
#import "UITextFieldUnderline.h"
#import "kColorConstants.h"

#define DEFAULT_COLOR [UIColor whiteColor]
#define DEFAULT_LINE_WIDTH 0.5f
#define MARGIN 4

@implementation UITextFieldUnderline

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _underlineColor = DEFAULT_COLOR;
        _lineWidth = 0.5f;
        self.backgroundColor = [kColorConstants blueWetAsphalt:1.0f];
        [self setNeedsDisplay];
    }

    return self;
}

- (UIColor *)underlineColor
{
    if (_underlineColor == nil)
        _underlineColor = DEFAULT_COLOR;

    return _underlineColor;
}

- (float)lineWidth
{
    return _lineWidth;
}

- (void)drawRect:(CGRect)rect {
    //Get the current drawing context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the line color and width
    CGContextSetStrokeColorWithColor(context, _underlineColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    //Start a new Path
    CGContextBeginPath(context);

    // offset lines up - we are adding offset to font
    CGContextMoveToPoint(context, self.bounds.origin.x, (self.font.lineHeight * 2) + MARGIN);
    CGContextAddLineToPoint(context, self.bounds.size.width, (self.font.lineHeight * 2) + MARGIN);

    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);
}


@end
